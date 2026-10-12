const std = @import("std");
const z = @import("znumber");
const N = z.ZNumber;
const P = z.ParsingMethods;
const F = z.FormattingMethods;
const C = z.ConversionMethods;
const a = std.testing.allocator;

fn number(v: f64) N {
    return N.init(a, v);
}
fn bitsEqual(expected: f64, actual: f64) !void {
    if (std.math.isNan(expected)) return std.testing.expect(std.math.isNan(actual));
    try std.testing.expectEqual(@as(u64, @bitCast(expected)), @as(u64, @bitCast(actual)));
}

test "checked Zig conversions reject exclusive upper limits without a panic" {
    try std.testing.expectError(error.Overflow, C.toInt(0x1p63));
    try std.testing.expectError(error.Overflow, C.toUint(0x1p64));
    try std.testing.expectEqual(@as(i64, 9223372036854774784), try C.toInt(0x1.fffffffffffffp62));
    try std.testing.expectEqual(@as(u64, 18446744073709549568), try C.toUint(0x1.fffffffffffffp63));
    try std.testing.expectEqual(std.math.minInt(i64), try C.toInt(-0x1p63));
    try std.testing.expectError(error.Underflow, C.toInt(-0x1.0000000000001p63));
    try std.testing.expectError(error.Underflow, C.toUint(-1));
}

test "Number division and remainder special values preserve signs" {
    const values = [_]f64{ 0, -0.0, 1, -1, std.math.inf(f64), -std.math.inf(f64), std.math.nan(f64) };
    for (values) |x| for (values) |y| {
        try bitsEqual(x / y, number(x).divide(number(y)).value);
        const expected = if (std.math.isNan(x) or std.math.isNan(y) or std.math.isInf(x) or y == 0)
            std.math.nan(f64)
        else if (std.math.isInf(y) or x == 0) x else @rem(x, y);
        try bitsEqual(expected, number(x).modulo(number(y)).value);
    };
    try bitsEqual(-0.0, number(-4).modulo(number(2)).value);
}

test "Number exponentiate normative special cases" {
    const inf = std.math.inf(f64);
    const nan = std.math.nan(f64);
    const rows = [_][3]f64{
        .{ nan, 0, 1 },      .{ nan, -0.0, 1 },    .{ 1, nan, nan },
        .{ 1, inf, nan },    .{ -1, -inf, nan },   .{ -0.0, 3, -0.0 },
        .{ -0.0, -3, -inf }, .{ -0.0, 2, 0 },      .{ -0.0, -2, inf },
        .{ -inf, 3, -inf },  .{ -inf, -3, -0.0 },  .{ -inf, 2, inf },
        .{ -inf, -2, 0 },    .{ 2, inf, inf },     .{ 2, -inf, 0 },
        .{ 0.5, inf, 0 },    .{ 0.5, -inf, inf },  .{ -2, 0.5, nan },
        .{ -2, 3, -8 },      .{ -2, 2, 4 },        .{ -2, -3, -0.125 },
        .{ -0.0, 0.5, 0 },   .{ -0.0, -0.5, inf }, .{ -inf, 0.5, inf },
        .{ -2, 1075, -inf }, .{ -2, -1077, -0.0 },
    };
    for (rows) |r| try bitsEqual(r[2], number(r[0]).power(r[1]).value);
}

test "Number equality policies and unordered comparison" {
    const nan = number(std.math.nan(f64));
    try std.testing.expect(nan.compare(number(1)) == null);
    try std.testing.expect(number(1).compare(nan) == null);
    try std.testing.expect(!nan.equals(nan));
    try std.testing.expect(nan.sameValue(nan));
    try std.testing.expect(nan.sameValueZero(nan));
    try std.testing.expect(!number(0).sameValue(number(-0.0)));
    try std.testing.expect(number(0).sameValueZero(number(-0.0)));
    try std.testing.expectEqual(std.math.Order.eq, number(0).compare(number(-0.0)).?);
    try std.testing.expectEqual(std.math.Order.lt, number(-1).compare(number(0)).?);
    try std.testing.expectEqual(std.math.Order.gt, number(1).compare(number(0)).?);
    try std.testing.expect(!nan.lessThan(number(1)) and !nan.greaterThan(number(1)));
}

test "Number bitwise operations normalize operands and shift counts" {
    try bitsEqual(-0.0, number(0).negate().value);
    try bitsEqual(-1, number(std.math.nan(f64)).bitwiseNot().value);
    try bitsEqual(1, number(0x1p32 + 3).bitwiseAnd(number(1)).value);
    try bitsEqual(-1, number(-2).bitwiseOr(number(1)).value);
    try bitsEqual(3, number(1).bitwiseXor(number(2)).value);
    try bitsEqual(-2147483648, number(1).shiftLeft(number(-1)).value);
    try bitsEqual(2, number(1).shiftLeft(number(33.9)).value);
    try bitsEqual(-1, number(-2).shiftRight(number(33)).value);
    try bitsEqual(2147483647, number(-1).shiftRightUnsigned(number(1)).value);
    try bitsEqual(4294967295, number(-1).shiftRightUnsigned(number(std.math.inf(f64))).value);
}

test "all ECMAScript whitespace code points are accepted, excluded code points are not" {
    const spaces = [_]u21{ 9, 10, 11, 12, 13, 32, 0xa0, 0x1680, 0x2000, 0x2001, 0x2002, 0x2003, 0x2004, 0x2005, 0x2006, 0x2007, 0x2008, 0x2009, 0x200a, 0x2028, 0x2029, 0x202f, 0x205f, 0x3000, 0xfeff };
    for (spaces) |cp| {
        var bytes: [10]u8 = undefined;
        const len: usize = try std.unicode.utf8Encode(cp, bytes[0..4]);
        @memcpy(bytes[len..][0..2], "42");
        @memcpy(bytes[len + 2 ..][0..len], bytes[0..len]);
        const input = bytes[0 .. 2 * len + 2];
        try bitsEqual(42, P.parseFloat(input));
        try bitsEqual(42, try P.parseInt(a, input, null));
        try bitsEqual(42, try P.stringToNumber(a, input));
    }
    for ([_][]const u8{ "\u{0085}42", "\u{180e}42", "\u{200b}42", "\u{0000}42" }) |input| {
        try std.testing.expect(std.math.isNan(P.parseFloat(input)));
        try std.testing.expect(std.math.isNan(try P.parseInt(a, input, null)));
        try std.testing.expect(std.math.isNan(try P.stringToNumber(a, input)));
    }
}

test "StringToNumber consumes the entire literal and differs from parseFloat" {
    const rows = [_]struct { input: []const u8, value: f64 }{
        .{ .input = "", .value = 0 },                       .{ .input = " \t\n", .value = 0 },
        .{ .input = "-0", .value = -0.0 },                  .{ .input = "-1e-9999", .value = -0.0 },
        .{ .input = "0xFF", .value = 255 },                 .{ .input = "0b101", .value = 5 },
        .{ .input = "0O77", .value = 63 },                  .{ .input = "+.5e2", .value = 50 },
        .{ .input = "1e9999", .value = std.math.inf(f64) },
    };
    for (rows) |r| try bitsEqual(r.value, try N.stringToNumber(a, r.input));
    for ([_][]const u8{ "42px", "1e", "1e+", "0x", "0b2", "0o8", "-0x1", "+0b1", "1_000", "1n", "Infinityx", "1 2", "\xff", "42\xff" }) |s| {
        try std.testing.expect(std.math.isNan(try P.stringToNumber(a, s)));
    }
    try bitsEqual(42, P.parseFloat("42px"));
    try bitsEqual(1, P.parseFloat("1e+"));
    try bitsEqual(42, P.parseFloat("42\xff"));
    try bitsEqual(5, (try N.fromString(a, "0b101")).value);
    try std.testing.expect(std.math.isNan((try N.fromString(a, "42px")).value));
    try bitsEqual(0x1p64, try P.stringToNumber(a, "0x10000000000000000"));
}

test "parseInt radix uses ToInt32 rather than a restricted Zig integer" {
    try bitsEqual(2, try P.parseInt(a, "10", 4294967298));
    try bitsEqual(2, try P.parseInt(a, "10", 2.9));
    try bitsEqual(10, try P.parseInt(a, "10", std.math.nan(f64)));
    try bitsEqual(16, try P.parseInt(a, "0x10", std.math.inf(f64)));
    try bitsEqual(-0.0, try P.parseInt(a, "-0tail", 10));
    try std.testing.expect(std.math.isNan(try P.parseInt(a, "10", -2)));
}

test "formatting normalizes numeric arguments and preserves exception order" {
    const nan = std.math.nan(f64);
    const inf = std.math.inf(f64);
    const rows = [_]struct { op: enum { string, fixed, exponential, precision }, value: f64, arg: ?f64, expected: []const u8 }{
        .{ .op = .string, .value = 10, .arg = 2.9, .expected = "1010" },
        .{ .op = .fixed, .value = 1.25, .arg = nan, .expected = "1" },
        .{ .op = .fixed, .value = 1, .arg = -0.5, .expected = "1" },
        .{ .op = .fixed, .value = 1.25, .arg = 1.9, .expected = "1.3" },
        .{ .op = .exponential, .value = 1.25, .arg = nan, .expected = "1e+0" },
        .{ .op = .exponential, .value = nan, .arg = -inf, .expected = "NaN" },
        .{ .op = .precision, .value = inf, .arg = 0, .expected = "Infinity" },
        .{ .op = .precision, .value = 1.25, .arg = 2.9, .expected = "1.3" },
    };
    for (rows) |r| {
        const s = try switch (r.op) {
            .string => F.toString(r.value, a, r.arg),
            .fixed => F.toFixed(r.value, a, r.arg),
            .exponential => F.toExponential(r.value, a, r.arg),
            .precision => F.toPrecision(r.value, a, r.arg),
        };
        defer a.free(s);
        try std.testing.expectEqualStrings(r.expected, s);
    }
    try std.testing.expectError(error.RangeError, F.toString(nan, a, nan));
    try std.testing.expectError(error.RangeError, F.toFixed(nan, a, 101));
    try std.testing.expectError(error.RangeError, F.toFixed(1, a, -1));
    try std.testing.expectError(error.RangeError, F.toExponential(1, a, inf));
    try std.testing.expectError(error.RangeError, F.toPrecision(1, a, nan));
}

test "ToIndex truncates and checks the safe integer interval" {
    try std.testing.expectEqual(@as(u64, 0), try N.toIndex(null));
    try std.testing.expectEqual(@as(u64, 0), try C.toIndex(std.math.nan(f64)));
    try std.testing.expectEqual(@as(u64, 0), try C.toIndex(-0.5));
    try std.testing.expectEqual(@as(u64, 3), try C.toIndex(3.9));
    try std.testing.expectEqual(@as(u64, 9007199254740991), try C.toIndex(9007199254740991));
    for ([_]f64{ -1, 0x1p53, std.math.inf(f64), -std.math.inf(f64) }) |v|
        try std.testing.expectError(error.RangeError, C.toIndex(v));
}

test "ErrorContext uses the Zig 0.17 custom formatter" {
    var buffer: [100]u8 = undefined;
    const text = try std.fmt.bufPrint(&buffer, "{f}", .{z.ErrorContext{ .message = "invalid", .value = 42 }});
    try std.testing.expectEqualStrings("ZNumberError: invalid (value: 42)", text);
}

test "public convenience APIs compile and returned strings outlive the number" {
    const n = N.fromInt(a, -9);
    try bitsEqual(-9, n.valueOf());
    try bitsEqual(9, n.abs().value);
    try bitsEqual(3, n.abs().sqrt().value);
    try bitsEqual(-0.0, number(-0.0).sqrt().value);
    try std.testing.expect(z.ValidationMethods.isInRange(9, 0, 10));
    try std.testing.expect(!z.ValidationMethods.isInRange(std.math.inf(f64), 0, 10));
    try std.testing.expectEqual(@as(u64, 9), try n.abs().toUint());
    try std.testing.expectEqual(@as(f32, 9), try C.toF32(9));
    const text = try n.toLocaleString("es-CL");
    defer a.free(text);
    n.deinit();
    try std.testing.expectEqualStrings("-9", text);
    var buffer: [100]u8 = undefined;
    const message = try std.fmt.bufPrint(&buffer, "{f}", .{z.ErrorContext{ .message = "invalid" }});
    try std.testing.expectEqualStrings("ZNumberError: invalid", message);
    var tiny: [1]u8 = undefined;
    try std.testing.expectError(error.NoSpaceLeft, std.fmt.bufPrint(&tiny, "{f}", .{z.ErrorContext{ .message = "invalid" }}));
}
