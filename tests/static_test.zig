const std = @import("std");
const znumber = @import("znumber");
const ZNumber = znumber.ZNumber;
const Constants = znumber.Constants;

// ===== isFinite Tests =====

test "Number.isFinite() with finite number" {
    try std.testing.expect(ZNumber.isFinite(42.0));
    try std.testing.expect(ZNumber.isFinite(-42.0));
    try std.testing.expect(ZNumber.isFinite(0.0));
    try std.testing.expect(ZNumber.isFinite(3.14159));
}

test "Number.isFinite() with infinity" {
    try std.testing.expect(!ZNumber.isFinite(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ZNumber.isFinite(Constants.NEGATIVE_INFINITY));
}

test "Number.isFinite() with NaN" {
    try std.testing.expect(!ZNumber.isFinite(Constants.NaN));
}

test "Number.isFinite() with edge values" {
    try std.testing.expect(ZNumber.isFinite(Constants.MAX_VALUE));
    try std.testing.expect(ZNumber.isFinite(Constants.MIN_VALUE));
}

// ===== isInteger Tests =====

test "Number.isInteger() with integer" {
    try std.testing.expect(ZNumber.isInteger(42.0));
    try std.testing.expect(ZNumber.isInteger(-42.0));
    try std.testing.expect(ZNumber.isInteger(0.0));
    try std.testing.expect(ZNumber.isInteger(100.0));
}

test "Number.isInteger() with float" {
    try std.testing.expect(!ZNumber.isInteger(3.14));
    try std.testing.expect(!ZNumber.isInteger(0.5));
    try std.testing.expect(!ZNumber.isInteger(-2.7));
}

test "Number.isInteger() with special values" {
    try std.testing.expect(!ZNumber.isInteger(Constants.NaN));
    try std.testing.expect(!ZNumber.isInteger(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ZNumber.isInteger(Constants.NEGATIVE_INFINITY));
}

// ===== isNaN Tests =====

test "Number.isNaN() with NaN" {
    try std.testing.expect(ZNumber.isNaN(Constants.NaN));
}

test "Number.isNaN() with number" {
    try std.testing.expect(!ZNumber.isNaN(42.0));
    try std.testing.expect(!ZNumber.isNaN(0.0));
    try std.testing.expect(!ZNumber.isNaN(Constants.POSITIVE_INFINITY));
}

// ===== isSafeInteger Tests =====

test "Number.isSafeInteger() with safe integer" {
    try std.testing.expect(ZNumber.isSafeInteger(42.0));
    try std.testing.expect(ZNumber.isSafeInteger(0.0));
    try std.testing.expect(ZNumber.isSafeInteger(-42.0));
}

test "Number.isSafeInteger() with boundary values" {
    const max_safe = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER));
    const min_safe = @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER));
    try std.testing.expect(ZNumber.isSafeInteger(max_safe));
    try std.testing.expect(ZNumber.isSafeInteger(min_safe));
}

test "Number.isSafeInteger() with unsafe integer" {
    const unsafe_large = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER)) + 1.0;
    const unsafe_small = @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER)) - 1.0;
    try std.testing.expect(!ZNumber.isSafeInteger(unsafe_large));
    try std.testing.expect(!ZNumber.isSafeInteger(unsafe_small));
}

test "Number.isSafeInteger() with float" {
    try std.testing.expect(!ZNumber.isSafeInteger(3.14));
    try std.testing.expect(!ZNumber.isSafeInteger(0.5));
}

test "Number.isSafeInteger() with special values" {
    try std.testing.expect(!ZNumber.isSafeInteger(Constants.NaN));
    try std.testing.expect(!ZNumber.isSafeInteger(Constants.POSITIVE_INFINITY));
}

// ===== parseFloat Tests =====

test "Number.parseFloat() valid number" {
    try std.testing.expectEqual(@as(f64, 42.0), ZNumber.parseFloat("42"));
    try std.testing.expectEqual(@as(f64, 3.14), ZNumber.parseFloat("3.14"));
    try std.testing.expectEqual(@as(f64, -123.45), ZNumber.parseFloat("-123.45"));
}

test "Number.parseFloat() with whitespace" {
    try std.testing.expectEqual(@as(f64, 42.0), ZNumber.parseFloat("  42  "));
    try std.testing.expectEqual(@as(f64, 3.14), ZNumber.parseFloat("\t3.14\n"));
}

test "Number.parseFloat() special values" {
    try std.testing.expect(ZNumber.isNaN(ZNumber.parseFloat("NaN")));
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, ZNumber.parseFloat("Infinity"));
    try std.testing.expectEqual(Constants.NEGATIVE_INFINITY, ZNumber.parseFloat("-Infinity"));
}

test "Number.parseFloat() invalid input" {
    try std.testing.expect(ZNumber.isNaN(ZNumber.parseFloat("")));
    try std.testing.expect(ZNumber.isNaN(ZNumber.parseFloat("   ")));
}

// ===== parseInt Tests =====

test "Number.parseInt() base 10" {
    try std.testing.expectEqual(@as(i64, 42), try ZNumber.parseInt("42", 10));
    try std.testing.expectEqual(@as(i64, -123), try ZNumber.parseInt("-123", 10));
    try std.testing.expectEqual(@as(i64, 0), try ZNumber.parseInt("0", 10));
}

test "Number.parseInt() base 16" {
    try std.testing.expectEqual(@as(i64, 255), try ZNumber.parseInt("FF", 16));
    try std.testing.expectEqual(@as(i64, 255), try ZNumber.parseInt("ff", 16));
    try std.testing.expectEqual(@as(i64, 16), try ZNumber.parseInt("10", 16));
}

test "Number.parseInt() base 2" {
    try std.testing.expectEqual(@as(i64, 10), try ZNumber.parseInt("1010", 2));
    try std.testing.expectEqual(@as(i64, 7), try ZNumber.parseInt("111", 2));
}

test "Number.parseInt() base 8" {
    try std.testing.expectEqual(@as(i64, 8), try ZNumber.parseInt("10", 8));
    try std.testing.expectEqual(@as(i64, 63), try ZNumber.parseInt("77", 8));
}

test "Number.parseInt() auto-detect hex" {
    try std.testing.expectEqual(@as(i64, 255), try ZNumber.parseInt("0xFF", null));
    try std.testing.expectEqual(@as(i64, 255), try ZNumber.parseInt("0xff", null));
}

test "Number.parseInt() auto-detect octal" {
    try std.testing.expectEqual(@as(i64, 63), try ZNumber.parseInt("0o77", null));
    try std.testing.expectEqual(@as(i64, 63), try ZNumber.parseInt("0O77", null));
}

test "Number.parseInt() auto-detect binary" {
    try std.testing.expectEqual(@as(i64, 10), try ZNumber.parseInt("0b1010", null));
    try std.testing.expectEqual(@as(i64, 10), try ZNumber.parseInt("0B1010", null));
}

test "Number.parseInt() with sign" {
    try std.testing.expectEqual(@as(i64, -42), try ZNumber.parseInt("-42", 10));
    try std.testing.expectEqual(@as(i64, 42), try ZNumber.parseInt("+42", 10));
}

test "Number.parseInt() invalid radix" {
    try std.testing.expectError(znumber.ZNumberError.InvalidRadix, ZNumber.parseInt("42", 1));
    try std.testing.expectError(znumber.ZNumberError.InvalidRadix, ZNumber.parseInt("42", 37));
}
