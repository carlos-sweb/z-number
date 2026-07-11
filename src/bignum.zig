const std = @import("std");
const Allocator = std.mem.Allocator;
const Managed = std.math.big.int.Managed;

/// Exact decimal/radix digit generation for f64, backing the ECMA-262
/// Number::toString / toFixed / toExponential / toPrecision algorithms.
///
/// All entry points here operate on strictly positive, finite `f64` values.
/// Callers are responsible for handling sign, zero, NaN and Infinity.
pub const Digits = struct {
    /// Significant digit characters, most significant first ('0'-'9' or 'a'-'z' for radix > 10).
    digits: []u8,
    /// value == 0.<digits> * radix^n, i.e. matches ECMA-262's `n` when `digits`
    /// is read as the spec's integer `s` of `k = digits.len` digits:
    /// s * radix^(n - k) == value.
    n: i32,

    pub fn deinit(self: Digits, allocator: Allocator) void {
        allocator.free(self.digits);
    }
};

const Decomposed = struct {
    /// Integer mantissa (53 bits for normals, up to 52 for denormals).
    f: u64,
    /// value == f * 2^e
    e: i32,
    /// True when the binary boundary above `value` is twice as far as the
    /// boundary below (i.e. `value` is an exact power of two, excluding the
    /// smallest normal, whose lower neighbor is a denormal at equal spacing).
    boundary: bool,
};

fn decompose(value: f64) Decomposed {
    const bits: u64 = @bitCast(value);
    const raw_exp: u64 = (bits >> 52) & 0x7FF;
    const raw_mantissa: u64 = bits & 0xFFFFFFFFFFFFF;
    if (raw_exp == 0) {
        return .{ .f = raw_mantissa, .e = -1074, .boundary = false };
    }
    const f = raw_mantissa | (@as(u64, 1) << 52);
    const e = @as(i32, @intCast(raw_exp)) - 1075;
    const boundary = (raw_mantissa == 0) and (raw_exp > 1);
    return .{ .f = f, .e = e, .boundary = boundary };
}

fn digitToChar(d: u8) u8 {
    return std.fmt.digitToChar(@intCast(d), .lower);
}

fn charToDigit(c: u8, radix: u8) u8 {
    return std.fmt.charToDigit(c, radix) catch unreachable;
}

fn mulSmall(r: *Managed, a: *const Managed, scalar: anytype) !void {
    var s = try Managed.initSet(r.allocator, scalar);
    defer s.deinit();
    try r.mul(a, &s);
}

fn powRadix(allocator: Allocator, radix: u8, exp: u32) !Managed {
    var base = try Managed.initSet(allocator, radix);
    defer base.deinit();
    var result = try Managed.initSet(allocator, 1);
    errdefer result.deinit();
    if (exp > 0) {
        try result.pow(&base, exp);
    }
    return result;
}

/// Shortest digit sequence in the given radix (2-36) that round-trips back to `value`.
/// Implements the Steele & White / Burger-Dybvig "free-format" algorithm using
/// arbitrary-precision integers so the result is exact for every representable f64.
pub fn shortestDigits(allocator: Allocator, value: f64, radix: u8) !Digits {
    std.debug.assert(value > 0 and std.math.isFinite(value));
    const dec = decompose(value);
    const even = (dec.f & 1) == 0;

    var R = try Managed.init(allocator);
    defer R.deinit();
    var S = try Managed.init(allocator);
    defer S.deinit();
    var Mp = try Managed.init(allocator);
    defer Mp.deinit();
    var Mm = try Managed.init(allocator);
    defer Mm.deinit();

    {
        var f_big = try Managed.initSet(allocator, dec.f);
        defer f_big.deinit();

        if (dec.e >= 0) {
            const e_u: usize = @intCast(dec.e);
            if (!dec.boundary) {
                try R.shiftLeft(&f_big, e_u + 1);
                try S.set(2);
                try Mp.set(1);
                try Mp.shiftLeft(&Mp, e_u);
                try Mm.copy(Mp.toConst());
            } else {
                try R.shiftLeft(&f_big, e_u + 2);
                try S.set(4);
                try Mm.set(1);
                try Mm.shiftLeft(&Mm, e_u);
                try Mp.set(1);
                try Mp.shiftLeft(&Mp, e_u + 1);
            }
        } else {
            const neg_e: usize = @intCast(-dec.e);
            if (!dec.boundary) {
                try R.shiftLeft(&f_big, 1);
                try S.set(1);
                try S.shiftLeft(&S, neg_e + 1);
                try Mp.set(1);
                try Mm.set(1);
            } else {
                try R.shiftLeft(&f_big, 2);
                try S.set(1);
                try S.shiftLeft(&S, neg_e + 2);
                try Mm.set(1);
                try Mp.set(2);
            }
        }
    }

    // Initial estimate of the radix-exponent `n` such that value == 0.d1d2...*radix^n.
    var n: i32 = blk: {
        const radix_f: f64 = @floatFromInt(radix);
        const est = @ceil(@log(value) / @log(radix_f));
        break :blk @intFromFloat(est);
    };

    if (n >= 0) {
        var scale = try powRadix(allocator, radix, @intCast(n));
        defer scale.deinit();
        try S.mul(&S, &scale);
    } else {
        var scale = try powRadix(allocator, radix, @intCast(-n));
        defer scale.deinit();
        try R.mul(&R, &scale);
        try Mp.mul(&Mp, &scale);
        try Mm.mul(&Mm, &scale);
    }

    // Exact fixup: ensure R + Mp is within S (upper bound), then check we
    // haven't overshot (lower bound), adjusting `n` by at most a couple of
    // steps regardless of the precision of the floating-point estimate above.
    // R and Mp are invariant in this loop (only S grows), so their sum is
    // computed once rather than on every iteration.
    {
        var sum = try Managed.init(allocator);
        defer sum.deinit();
        try sum.add(&R, &Mp);
        while (true) {
            const cmp = sum.order(S);
            const too_big = if (even) (cmp != .lt) else (cmp == .gt);
            if (!too_big) break;
            try mulSmall(&S, &S, radix);
            n += 1;
        }
    }
    while (true) {
        var sum = try Managed.init(allocator);
        defer sum.deinit();
        try sum.add(&R, &Mp);
        var scaled = try Managed.init(allocator);
        defer scaled.deinit();
        try mulSmall(&scaled, &sum, radix);
        const cmp = scaled.order(S);
        const can_shrink = if (even) (cmp != .gt) else (cmp == .lt);
        if (!can_shrink) break;
        try mulSmall(&R, &R, radix);
        try mulSmall(&Mp, &Mp, radix);
        try mulSmall(&Mm, &Mm, radix);
        n -= 1;
    }

    var digits = std.ArrayList(u8).empty;
    errdefer digits.deinit(allocator);

    while (true) {
        try mulSmall(&R, &R, radix);
        try mulSmall(&Mp, &Mp, radix);
        try mulSmall(&Mm, &Mm, radix);

        var q = try Managed.init(allocator);
        defer q.deinit();
        var r = try Managed.init(allocator);
        defer r.deinit();
        try q.divTrunc(&r, &R, &S);
        R.swap(&r);

        const digit_val: u8 = @intCast(try q.toInt(u32));

        const low_cmp = R.order(Mm);
        const low = if (even) (low_cmp != .gt) else (low_cmp == .lt);

        var sum = try Managed.init(allocator);
        defer sum.deinit();
        try sum.add(&R, &Mp);
        const high_cmp = sum.order(S);
        const high = if (even) (high_cmp != .lt) else (high_cmp == .gt);

        if (!low and !high) {
            try digits.append(allocator, digitToChar(digit_val));
            continue;
        }

        var final_digit = digit_val;
        if (high and !low) {
            final_digit += 1;
        } else if (low and high) {
            var doubled = try Managed.init(allocator);
            defer doubled.deinit();
            try doubled.shiftLeft(&R, 1);
            const tie_cmp = doubled.order(S);
            if (tie_cmp != .lt) final_digit += 1;
        }

        try appendDigit(allocator, &digits, final_digit, radix, &n, true);
        break;
    }

    return .{ .digits = try digits.toOwnedSlice(allocator), .n = n };
}

/// Increments the last digit in `digits` by one and propagates the carry
/// leftward through the already-generated digits. If the carry propagates
/// past the first digit (all digits were `radix - 1`), `n` is bumped by one
/// to account for the extra leading digit. If `collapse_on_full_carry` is
/// set, that leading-digit overflow collapses the whole list to a single
/// "1" (used by the shortest-digit algorithm, where trailing zeros must not
/// be introduced); otherwise a leading "1" is prepended and the digit count
/// grows by one (used by the fixed-digit-count algorithm, whose caller trims
/// back down to the requested count).
fn propagateCarry(
    allocator: Allocator,
    digits: *std.ArrayList(u8),
    radix: u8,
    n: *i32,
    collapse_on_full_carry: bool,
) !void {
    var i = digits.items.len;
    var carrying = true;
    while (i > 0) {
        i -= 1;
        const cur = charToDigit(digits.items[i], radix);
        if (cur + 1 < radix) {
            digits.items[i] = digitToChar(cur + 1);
            carrying = false;
            break;
        }
        digits.items[i] = digitToChar(0);
    }

    if (carrying) {
        n.* += 1;
        if (collapse_on_full_carry) {
            digits.clearRetainingCapacity();
            try digits.append(allocator, digitToChar(1));
        } else {
            try digits.insert(allocator, 0, digitToChar(1));
        }
    }
}

/// Appends `final_digit` as the next digit, unless it equals `radix` (a
/// carry out of that position), in which case the carry is propagated into
/// the digits already generated instead of appending a new one. See
/// `propagateCarry` for the carry semantics.
fn appendDigit(
    allocator: Allocator,
    digits: *std.ArrayList(u8),
    final_digit: u8,
    radix: u8,
    n: *i32,
    collapse_on_full_carry: bool,
) !void {
    if (final_digit < radix) {
        try digits.append(allocator, digitToChar(final_digit));
        return;
    }
    try propagateCarry(allocator, digits, radix, n, collapse_on_full_carry);
}

/// Exactly `digit_count` significant decimal digits of `value`, correctly
/// rounded per ECMA-262 (round to nearest; ties away from zero, i.e. towards
/// the larger magnitude, since `value` is positive here).
pub fn fixedDigits(allocator: Allocator, value: f64, digit_count: usize) !Digits {
    std.debug.assert(value > 0 and std.math.isFinite(value));
    std.debug.assert(digit_count >= 1);
    const dec = decompose(value);

    var R = try Managed.init(allocator);
    defer R.deinit();
    var S = try Managed.init(allocator);
    defer S.deinit();

    {
        var f_big = try Managed.initSet(allocator, dec.f);
        defer f_big.deinit();
        if (dec.e >= 0) {
            try R.shiftLeft(&f_big, @intCast(dec.e));
            try S.set(1);
        } else {
            try R.copy(f_big.toConst());
            try S.set(1);
            try S.shiftLeft(&S, @intCast(-dec.e));
        }
    }

    var n: i32 = blk: {
        const est = @ceil(@log10(value));
        break :blk @intFromFloat(est);
    };

    if (n >= 0) {
        var scale = try powRadix(allocator, 10, @intCast(n));
        defer scale.deinit();
        try S.mul(&S, &scale);
    } else {
        var scale = try powRadix(allocator, 10, @intCast(-n));
        defer scale.deinit();
        try R.mul(&R, &scale);
    }

    // Exact fixup so that 1/10 <= R/S < 1 (i.e. 10^(n-1) <= value < 10^n).
    while (true) {
        const cmp = R.order(S);
        if (cmp == .lt) break;
        try mulSmall(&S, &S, 10);
        n += 1;
    }
    while (true) {
        var scaled = try Managed.init(allocator);
        defer scaled.deinit();
        try mulSmall(&scaled, &R, 10);
        const cmp = scaled.order(S);
        if (cmp != .lt) break;
        try mulSmall(&R, &R, 10);
        n -= 1;
    }

    var digits = std.ArrayList(u8).empty;
    errdefer digits.deinit(allocator);

    var count: usize = 0;
    while (count < digit_count) : (count += 1) {
        try mulSmall(&R, &R, 10);
        var q = try Managed.init(allocator);
        defer q.deinit();
        var r = try Managed.init(allocator);
        defer r.deinit();
        try q.divTrunc(&r, &R, &S);
        R.swap(&r);
        const digit_val: u8 = @intCast(try q.toInt(u32));
        try digits.append(allocator, digitToChar(digit_val));
    }

    // Round based on the leftover remainder: round up on >= half.
    var doubled = try Managed.init(allocator);
    defer doubled.deinit();
    try doubled.shiftLeft(&R, 1);
    const round_up = doubled.order(S) != .lt;

    if (round_up) {
        try propagateCarry(allocator, &digits, 10, &n, false);
        if (digits.items.len > digit_count) {
            digits.shrinkRetainingCapacity(digit_count);
        }
    }

    return .{ .digits = try digits.toOwnedSlice(allocator), .n = n };
}

/// Digit string (no leading zeros; "0" for a zero result) of the integer
/// N = round(value * 10^f), ties broken towards the larger N (i.e. rounding
/// away from zero for positive `value`), computed exactly.
///
/// This is a direct translation of the ECMA-262 Number::toFixed algorithm's
/// "let n be an integer for which n / 10^f - x is as close to zero as
/// possible" step. Unlike `fixedDigits`, the requested precision here is
/// anchored to an absolute decimal position (10^-f), not to a count of
/// significant figures, so it correctly handles values whose leading digit
/// falls to the right of that position (e.g. 0.05.toFixed(1) rounding up to
/// "1" even though 0.05 itself has no digit at the tenths place).
pub fn toFixedDigits(allocator: Allocator, value: f64, f: usize) ![]u8 {
    std.debug.assert(value > 0 and std.math.isFinite(value));
    const dec = decompose(value);

    var numerator = try Managed.initSet(allocator, dec.f);
    defer numerator.deinit();
    var denom = try Managed.initSet(allocator, 1);
    defer denom.deinit();

    if (dec.e >= 0) {
        try numerator.shiftLeft(&numerator, @intCast(dec.e));
    } else {
        try denom.shiftLeft(&denom, @intCast(-dec.e));
    }

    if (f > 0) {
        var scale = try powRadix(allocator, 10, @intCast(f));
        defer scale.deinit();
        try numerator.mul(&numerator, &scale);
    }

    var q = try Managed.init(allocator);
    defer q.deinit();
    var r = try Managed.init(allocator);
    defer r.deinit();
    try q.divTrunc(&r, &numerator, &denom);

    var doubled = try Managed.init(allocator);
    defer doubled.deinit();
    try doubled.shiftLeft(&r, 1);
    if (doubled.order(denom) != .lt) {
        try q.addScalar(&q, 1);
    }

    return q.toString(allocator, 10, .lower);
}
