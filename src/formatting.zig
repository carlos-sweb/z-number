const std = @import("std");
const Allocator = std.mem.Allocator;
const Constants = @import("constants.zig").Constants;
const ZNumberError = @import("errors.zig").ZNumberError;
const ConversionMethods = @import("conversion.zig").ConversionMethods;
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
    /// Radix uses ToIntegerOrInfinity; null means 10, outside 2...36 yields RangeError.
    /// Returns an owned slice; free with allocator. Can return error.OutOfMemory.
    pub fn toString(value: f64, allocator: Allocator, radix: ?f64) ![]u8 {
        const r = ConversionMethods.toIntegerOrInfinity(radix orelse 10);
        if (r < 2 or r > 36) return ZNumberError.RangeError;
        const base: u8 = @intFromFloat(r);

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
    /// fraction_digits uses ToIntegerOrInfinity; null means 0, outside 0...100 yields RangeError.
    /// Returns an owned slice; free with allocator. Can return error.OutOfMemory.
    pub fn toFixed(
        value: f64,
        allocator: Allocator,
        fraction_digits: ?f64,
    ) ![]u8 {
        const requested = ConversionMethods.toIntegerOrInfinity(fraction_digits orelse 0);
        if (requested < 0 or requested > 100) return ZNumberError.RangeError;
        const f: usize = @intFromFloat(requested);
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
    /// null selects shortest output; explicit digits use ToIntegerOrInfinity (0...100).
    /// Finite values with an invalid digit count yield RangeError; NaN/Infinity bypass it.
    /// Returns an owned slice; free with allocator. Can return error.OutOfMemory.
    pub fn toExponential(
        value: f64,
        allocator: Allocator,
        fraction_digits: ?f64,
    ) ![]u8 {
        if (try specialValueString(allocator, value)) |s| return s;
        const requested = ConversionMethods.toIntegerOrInfinity(fraction_digits orelse 0);
        if (requested < 0 or requested > 100) return ZNumberError.RangeError;
        const fd: usize = @intFromFloat(requested);

        const neg = value < 0;
        const x = @abs(value);

        var out = std.ArrayList(u8).empty;
        errdefer out.deinit(allocator);
        if (neg) try out.append(allocator, '-');

        if (x == 0) {
            const count = fd + 1;
            const digits = try allocator.alloc(u8, count);
            defer allocator.free(digits);
            @memset(digits, '0');
            try assembleExponential(allocator, &out, digits, 0);
            return out.toOwnedSlice(allocator);
        }

        if (fraction_digits != null) {
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
    /// null selects decimal toString; explicit precision uses ToIntegerOrInfinity (1...100).
    /// Finite values outside that range yield RangeError; NaN/Infinity bypass it.
    /// Returns an owned slice; free with allocator. Can return error.OutOfMemory.
    pub fn toPrecision(
        value: f64,
        allocator: Allocator,
        precision: ?f64,
    ) ![]u8 {
        if (precision == null) {
            return toString(value, allocator, null);
        }
        const requested = ConversionMethods.toIntegerOrInfinity(precision.?);
        if (try specialValueString(allocator, value)) |s| return s;
        if (requested < 1 or requested > 100) return ZNumberError.RangeError;
        const prec: usize = @intFromFloat(requested);

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

    /// ECMA-262 fallback without ECMA-402 Intl support: decimal toString output.
    /// The locale argument is ignored; this does not implement locale validation.
    /// Returns an owned slice; free with allocator. Can return error.OutOfMemory.
    pub fn toLocaleString(
        value: f64,
        allocator: Allocator,
        locale: ?[]const u8,
    ) ![]u8 {
        _ = locale;
        return toString(value, allocator, null);
    }
};
