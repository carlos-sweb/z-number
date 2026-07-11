const std = @import("std");
const Allocator = std.mem.Allocator;
const Constants = @import("constants.zig").Constants;
const ZNumberError = @import("errors.zig").ZNumberError;
const bignum = @import("bignum.zig");

/// Formatting methods for converting numbers to strings.
/// These implement the ECMA-262 Number.prototype string-producing methods
/// (toString, toFixed, toExponential, toPrecision) exactly, using
/// arbitrary-precision digit generation (see bignum.zig) for correct
/// rounding and shortest round-trip representations.
pub const FormattingMethods = struct {
    fn specialValueString(allocator: Allocator, value: f64) !?[]u8 {
        if (std.math.isNan(value)) return try allocator.dupe(u8, "NaN");
        if (std.math.isInf(value)) {
            return try allocator.dupe(u8, if (value > 0) "Infinity" else "-Infinity");
        }
        return null;
    }

    fn appendZeros(allocator: Allocator, out: *std.ArrayList(u8), count: usize) !void {
        var i: usize = 0;
        while (i < count) : (i += 1) try out.append(allocator, '0');
    }

    /// Assembles `digits` (k significant digits, value == 0.<digits> * 10^n)
    /// into plain positional notation, e.g. "1234.57", "0.0012", "1200".
    /// Shared by toString's fixed-notation branch, toString(radix != 10),
    /// and toPrecision's fixed-notation branch — all use this identical shape.
    fn assembleFixedNotation(allocator: Allocator, out: *std.ArrayList(u8), digits: []const u8, n: i32) !void {
        const k: i32 = @intCast(digits.len);
        if (n <= 0) {
            try out.appendSlice(allocator, "0.");
            try appendZeros(allocator, out, @intCast(-n));
            try out.appendSlice(allocator, digits);
        } else if (n >= k) {
            try out.appendSlice(allocator, digits);
            try appendZeros(allocator, out, @intCast(n - k));
        } else {
            const split: usize = @intCast(n);
            try out.appendSlice(allocator, digits[0..split]);
            try out.append(allocator, '.');
            try out.appendSlice(allocator, digits[split..]);
        }
    }

    /// Assembles `digits` into exponential notation, e.g. "1.23e+2", "5e-324".
    fn assembleExponential(allocator: Allocator, out: *std.ArrayList(u8), digits: []const u8, exponent: i32) !void {
        try out.append(allocator, digits[0]);
        if (digits.len > 1) {
            try out.append(allocator, '.');
            try out.appendSlice(allocator, digits[1..]);
        }
        try out.append(allocator, 'e');
        try out.append(allocator, if (exponent >= 0) '+' else '-');
        const exp_abs: u32 = @intCast(if (exponent >= 0) exponent else -exponent);
        var buf: [16]u8 = undefined;
        const s = std.fmt.bufPrint(&buf, "{d}", .{exp_abs}) catch unreachable;
        try out.appendSlice(allocator, s);
    }

    /// Number::toString(x, radix) — ECMA-262 6.1.6.1.20 / 21.1.3.6.
    pub fn toString(value: f64, allocator: Allocator, radix: ?u8) ![]u8 {
        const base = radix orelse 10;
        if (base < 2 or base > 36) return ZNumberError.RangeError;

        if (try specialValueString(allocator, value)) |s| return s;
        if (value == 0) return try allocator.dupe(u8, "0");

        const neg = value < 0;
        const abs_v = @abs(value);

        const d = try bignum.shortestDigits(allocator, abs_v, base);
        defer d.deinit(allocator);

        var out = std.ArrayList(u8).empty;
        errdefer out.deinit(allocator);
        if (neg) try out.append(allocator, '-');

        if (base == 10) {
            const n = d.n;
            if (n > -6 and n <= 21) {
                try assembleFixedNotation(allocator, &out, d.digits, n);
            } else {
                try assembleExponential(allocator, &out, d.digits, n - 1);
            }
        } else {
            try assembleFixedNotation(allocator, &out, d.digits, d.n);
        }

        return out.toOwnedSlice(allocator);
    }

    /// Number::toFixed(fractionDigits) — ECMA-262 21.1.3.3.
    pub fn toFixed(
        value: f64,
        allocator: Allocator,
        fraction_digits: ?usize,
    ) ![]u8 {
        const f = fraction_digits orelse 0;
        if (f > 100) return ZNumberError.RangeError;
        if (try specialValueString(allocator, value)) |s| return s;

        const neg = value < 0;
        const x = @abs(value);

        if (x >= 1e21) {
            // toString already handles sign for the (still-signed) original value.
            return toString(value, allocator, null);
        }

        const m = if (x == 0) try allocator.dupe(u8, "0") else try bignum.toFixedDigits(allocator, x, f);
        defer allocator.free(m);

        var out = std.ArrayList(u8).empty;
        errdefer out.deinit(allocator);
        if (neg) try out.append(allocator, '-');

        if (f == 0) {
            try out.appendSlice(allocator, m);
        } else {
            var padded = m;
            var owned_pad: ?[]u8 = null;
            defer if (owned_pad) |p| allocator.free(p);
            if (m.len <= f) {
                const pad = f + 1 - m.len;
                const buf = try allocator.alloc(u8, pad + m.len);
                @memset(buf[0..pad], '0');
                @memcpy(buf[pad..], m);
                owned_pad = buf;
                padded = buf;
            }
            const split = padded.len - f;
            try out.appendSlice(allocator, padded[0..split]);
            try out.append(allocator, '.');
            try out.appendSlice(allocator, padded[split..]);
        }

        return out.toOwnedSlice(allocator);
    }

    /// Number::toExponential(fractionDigits) — ECMA-262 21.1.3.2.
    pub fn toExponential(
        value: f64,
        allocator: Allocator,
        fraction_digits: ?usize,
    ) ![]u8 {
        if (try specialValueString(allocator, value)) |s| return s;
        if (fraction_digits) |fd| {
            if (fd > 100) return ZNumberError.RangeError;
        }

        const neg = value < 0;
        const x = @abs(value);

        var out = std.ArrayList(u8).empty;
        errdefer out.deinit(allocator);
        if (neg) try out.append(allocator, '-');

        if (x == 0) {
            const count = (fraction_digits orelse 0) + 1;
            const digits = try allocator.alloc(u8, count);
            defer allocator.free(digits);
            @memset(digits, '0');
            try assembleExponential(allocator, &out, digits, 0);
            return out.toOwnedSlice(allocator);
        }

        if (fraction_digits) |fd| {
            const d = try bignum.fixedDigits(allocator, x, fd + 1);
            defer d.deinit(allocator);
            try assembleExponential(allocator, &out, d.digits, d.n - 1);
        } else {
            const d = try bignum.shortestDigits(allocator, x, 10);
            defer d.deinit(allocator);
            try assembleExponential(allocator, &out, d.digits, d.n - 1);
        }

        return out.toOwnedSlice(allocator);
    }

    /// Number::toPrecision(precision) — ECMA-262 21.1.3.5.
    pub fn toPrecision(
        value: f64,
        allocator: Allocator,
        precision: ?usize,
    ) ![]u8 {
        if (precision == null) {
            return toString(value, allocator, null);
        }
        const prec = precision.?;
        if (try specialValueString(allocator, value)) |s| return s;
        if (prec < 1 or prec > 100) return ZNumberError.RangeError;

        const neg = value < 0;
        const x = @abs(value);

        var out = std.ArrayList(u8).empty;
        errdefer out.deinit(allocator);
        if (neg) try out.append(allocator, '-');

        if (x == 0) {
            const digits = try allocator.alloc(u8, prec);
            defer allocator.free(digits);
            @memset(digits, '0');
            try assembleFixedNotation(allocator, &out, digits, 1);
            return out.toOwnedSlice(allocator);
        }

        const d = try bignum.fixedDigits(allocator, x, prec);
        defer d.deinit(allocator);
        const e = d.n - 1;

        if (e < -6 or e >= @as(i32, @intCast(prec))) {
            try assembleExponential(allocator, &out, d.digits, e);
        } else {
            try assembleFixedNotation(allocator, &out, d.digits, d.n);
        }

        return out.toOwnedSlice(allocator);
    }

    /// Simplified toLocaleString: locale-aware formatting is implementation-defined
    /// even in real JS engines; this delegates to the base-10 toString algorithm.
    pub fn toLocaleString(
        value: f64,
        allocator: Allocator,
        locale: ?[]const u8,
    ) ![]u8 {
        _ = locale;
        return toString(value, allocator, null);
    }
};
