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

// ===== parseInt Tests =====

test "parseInt() base 10" {
    try std.testing.expectEqual(@as(i64, 42), try ParsingMethods.parseInt("42", 10));
    try std.testing.expectEqual(@as(i64, -123), try ParsingMethods.parseInt("-123", 10));
    try std.testing.expectEqual(@as(i64, 0), try ParsingMethods.parseInt("0", 10));
    try std.testing.expectEqual(@as(i64, 999), try ParsingMethods.parseInt("999", 10));
}

test "parseInt() base 16" {
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("FF", 16));
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("ff", 16));
    try std.testing.expectEqual(@as(i64, 16), try ParsingMethods.parseInt("10", 16));
    try std.testing.expectEqual(@as(i64, 171), try ParsingMethods.parseInt("AB", 16));
}

test "parseInt() base 2" {
    try std.testing.expectEqual(@as(i64, 10), try ParsingMethods.parseInt("1010", 2));
    try std.testing.expectEqual(@as(i64, 7), try ParsingMethods.parseInt("111", 2));
    try std.testing.expectEqual(@as(i64, 0), try ParsingMethods.parseInt("0", 2));
    try std.testing.expectEqual(@as(i64, 1), try ParsingMethods.parseInt("1", 2));
}

test "parseInt() base 8" {
    try std.testing.expectEqual(@as(i64, 8), try ParsingMethods.parseInt("10", 8));
    try std.testing.expectEqual(@as(i64, 63), try ParsingMethods.parseInt("77", 8));
    try std.testing.expectEqual(@as(i64, 511), try ParsingMethods.parseInt("777", 8));
}

test "parseInt() auto-detect hex" {
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("0xFF", null));
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("0xff", null));
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("0XFF", null));
}

test "parseInt() auto-detect octal" {
    try std.testing.expectEqual(@as(i64, 63), try ParsingMethods.parseInt("0o77", null));
    try std.testing.expectEqual(@as(i64, 63), try ParsingMethods.parseInt("0O77", null));
    try std.testing.expectEqual(@as(i64, 8), try ParsingMethods.parseInt("0o10", null));
}

test "parseInt() auto-detect binary" {
    try std.testing.expectEqual(@as(i64, 10), try ParsingMethods.parseInt("0b1010", null));
    try std.testing.expectEqual(@as(i64, 10), try ParsingMethods.parseInt("0B1010", null));
    try std.testing.expectEqual(@as(i64, 7), try ParsingMethods.parseInt("0b111", null));
}

test "parseInt() with sign" {
    try std.testing.expectEqual(@as(i64, -42), try ParsingMethods.parseInt("-42", 10));
    try std.testing.expectEqual(@as(i64, 42), try ParsingMethods.parseInt("+42", 10));
    try std.testing.expectEqual(@as(i64, -255), try ParsingMethods.parseInt("-FF", 16));
}

test "parseInt() with whitespace" {
    try std.testing.expectEqual(@as(i64, 42), try ParsingMethods.parseInt("  42  ", 10));
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseInt("\t0xFF\n", null));
}

test "parseInt() invalid radix" {
    try std.testing.expectError(znumber.ZNumberError.InvalidRadix, ParsingMethods.parseInt("42", 1));
    try std.testing.expectError(znumber.ZNumberError.InvalidRadix, ParsingMethods.parseInt("42", 37));
}

test "parseInt() empty string" {
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ParsingMethods.parseInt("", 10));
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ParsingMethods.parseInt("   ", 10));
}

// ===== parseHex Tests =====

test "parseHex() basic" {
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseHex("FF"));
    try std.testing.expectEqual(@as(i64, 255), try ParsingMethods.parseHex("ff"));
    try std.testing.expectEqual(@as(i64, 0), try ParsingMethods.parseHex("0"));
}

// ===== parseOctal Tests =====

test "parseOctal() basic" {
    try std.testing.expectEqual(@as(i64, 8), try ParsingMethods.parseOctal("10"));
    try std.testing.expectEqual(@as(i64, 63), try ParsingMethods.parseOctal("77"));
}

// ===== parseBinary Tests =====

test "parseBinary() basic" {
    try std.testing.expectEqual(@as(i64, 10), try ParsingMethods.parseBinary("1010"));
    try std.testing.expectEqual(@as(i64, 7), try ParsingMethods.parseBinary("111"));
}
