const std = @import("std");
const znumber = @import("znumber");
const ParsingMethods = znumber.ParsingMethods;
const Constants = znumber.Constants;

// ===== parseFloat Tests =====

test "parseFloat() basic numbers" {
    try std.testing.expectEqual(@as(f64, 42.0), ParsingMethods.parseFloat("42"));
    try std.testing.expectEqual(@as(f64, 3.14), ParsingMethods.parseFloat("3.14"));
    try std.testing.expectEqual(@as(f64, -123.45), ParsingMethods.parseFloat("-123.45"));
    try std.testing.expectEqual(@as(f64, 0.0), ParsingMethods.parseFloat("0"));
}

test "parseFloat() with whitespace" {
    try std.testing.expectEqual(@as(f64, 42.0), ParsingMethods.parseFloat("  42  "));
    try std.testing.expectEqual(@as(f64, 3.14), ParsingMethods.parseFloat("\t3.14\n"));
    try std.testing.expectEqual(@as(f64, -5.5), ParsingMethods.parseFloat("  -5.5  "));
}

test "parseFloat() special values" {
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("NaN")));
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, ParsingMethods.parseFloat("Infinity"));
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, ParsingMethods.parseFloat("+Infinity"));
    try std.testing.expectEqual(Constants.NEGATIVE_INFINITY, ParsingMethods.parseFloat("-Infinity"));
}

test "parseFloat() empty and invalid" {
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("")));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("   ")));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("abc")));
}

test "parseFloat() scientific notation" {
    try std.testing.expectEqual(@as(f64, 1.23e5), ParsingMethods.parseFloat("1.23e5"));
    try std.testing.expectEqual(@as(f64, 1.5e-3), ParsingMethods.parseFloat("1.5e-3"));
}

test "parseFloat() stops at the longest valid prefix" {
    try std.testing.expectEqual(@as(f64, 3.14), ParsingMethods.parseFloat("3.14abc"));
    try std.testing.expectEqual(@as(f64, 42.0), ParsingMethods.parseFloat("42px"));
    try std.testing.expectEqual(@as(f64, 0.5), ParsingMethods.parseFloat(".5"));
    try std.testing.expectEqual(@as(f64, 5.0), ParsingMethods.parseFloat("5."));
    try std.testing.expectEqual(@as(f64, 50.0), ParsingMethods.parseFloat("+.5e2"));
}

// ===== parseInt Tests =====

test "parseInt() base 10" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 42), ParsingMethods.parseInt(a, "42", 10));
    try std.testing.expectEqual(@as(f64, -123), ParsingMethods.parseInt(a, "-123", 10));
    try std.testing.expectEqual(@as(f64, 0), ParsingMethods.parseInt(a, "0", 10));
    try std.testing.expectEqual(@as(f64, 999), ParsingMethods.parseInt(a, "999", 10));
}

test "parseInt() base 16" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "FF", 16));
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "ff", 16));
    try std.testing.expectEqual(@as(f64, 16), ParsingMethods.parseInt(a, "10", 16));
    try std.testing.expectEqual(@as(f64, 171), ParsingMethods.parseInt(a, "AB", 16));
}

test "parseInt() base 2" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 10), ParsingMethods.parseInt(a, "1010", 2));
    try std.testing.expectEqual(@as(f64, 7), ParsingMethods.parseInt(a, "111", 2));
    try std.testing.expectEqual(@as(f64, 0), ParsingMethods.parseInt(a, "0", 2));
    try std.testing.expectEqual(@as(f64, 1), ParsingMethods.parseInt(a, "1", 2));
}

test "parseInt() base 8" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 8), ParsingMethods.parseInt(a, "10", 8));
    try std.testing.expectEqual(@as(f64, 63), ParsingMethods.parseInt(a, "77", 8));
    try std.testing.expectEqual(@as(f64, 511), ParsingMethods.parseInt(a, "777", 8));
}

test "parseInt() auto-detect hex" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "0xFF", null));
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "0xff", null));
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "0XFF", null));
}

test "parseInt() does NOT auto-detect octal or binary (unlike legacy non-spec behavior)" {
    // Real Number.parseInt only special-cases "0x"/"0X"; "0o"/"0b" are parsed
    // as decimal, stopping at the first invalid decimal digit ('o'/'b').
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 0), ParsingMethods.parseInt(a, "0o17", null));
    try std.testing.expectEqual(@as(f64, 0), ParsingMethods.parseInt(a, "0b11", null));
}

test "parseInt() with sign" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, -42), ParsingMethods.parseInt(a, "-42", 10));
    try std.testing.expectEqual(@as(f64, 42), ParsingMethods.parseInt(a, "+42", 10));
    try std.testing.expectEqual(@as(f64, -255), ParsingMethods.parseInt(a, "-FF", 16));
}

test "parseInt() with whitespace" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 42), ParsingMethods.parseInt(a, "  42  ", 10));
    try std.testing.expectEqual(@as(f64, 255), ParsingMethods.parseInt(a, "\t0xFF\n", null));
}

test "parseInt() stops at the longest valid digit run" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 42), ParsingMethods.parseInt(a, "42abc", 10));
    try std.testing.expectEqual(@as(f64, -42), ParsingMethods.parseInt(a, "   -42abc", null));
    // '9' is not a valid base-2 digit, so only the leading "1" is consumed.
    try std.testing.expectEqual(@as(f64, 1), ParsingMethods.parseInt(a, "19", 2));
}

test "parseInt() invalid radix returns NaN, never throws" {
    const a = std.testing.allocator;
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "42", 1)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "42", 37)));
}

test "parseInt() empty or all-invalid input returns NaN, never throws" {
    const a = std.testing.allocator;
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "", 10)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "   ", 10)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "abc", 10)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "Infinity", null)));
}

test "parseInt() huge digit strings round to the nearest representable double" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, 1e24), ParsingMethods.parseInt(a, "999999999999999999999999", 10));
}
