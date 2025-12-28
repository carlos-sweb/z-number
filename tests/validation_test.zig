const std = @import("std");
const znumber = @import("znumber");
const ValidationMethods = znumber.ValidationMethods;
const Constants = znumber.Constants;

// ===== isFinite Tests =====

test "isFinite() with finite numbers" {
    try std.testing.expect(ValidationMethods.isFinite(0.0));
    try std.testing.expect(ValidationMethods.isFinite(42.0));
    try std.testing.expect(ValidationMethods.isFinite(-42.0));
    try std.testing.expect(ValidationMethods.isFinite(3.14159));
    try std.testing.expect(ValidationMethods.isFinite(-999.999));
}

test "isFinite() with infinity" {
    try std.testing.expect(!ValidationMethods.isFinite(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ValidationMethods.isFinite(Constants.NEGATIVE_INFINITY));
    try std.testing.expect(!ValidationMethods.isFinite(std.math.inf(f64)));
    try std.testing.expect(!ValidationMethods.isFinite(-std.math.inf(f64)));
}

test "isFinite() with NaN" {
    try std.testing.expect(!ValidationMethods.isFinite(Constants.NaN));
    try std.testing.expect(!ValidationMethods.isFinite(std.math.nan(f64)));
}

test "isFinite() with boundary values" {
    try std.testing.expect(ValidationMethods.isFinite(Constants.MAX_VALUE));
    try std.testing.expect(ValidationMethods.isFinite(Constants.MIN_VALUE));
    try std.testing.expect(ValidationMethods.isFinite(-Constants.MAX_VALUE));
}

// ===== isInteger Tests =====

test "isInteger() with integers" {
    try std.testing.expect(ValidationMethods.isInteger(0.0));
    try std.testing.expect(ValidationMethods.isInteger(42.0));
    try std.testing.expect(ValidationMethods.isInteger(-42.0));
    try std.testing.expect(ValidationMethods.isInteger(100.0));
    try std.testing.expect(ValidationMethods.isInteger(-999.0));
}

test "isInteger() with floats" {
    try std.testing.expect(!ValidationMethods.isInteger(3.14));
    try std.testing.expect(!ValidationMethods.isInteger(0.5));
    try std.testing.expect(!ValidationMethods.isInteger(-2.7));
    try std.testing.expect(!ValidationMethods.isInteger(0.1));
}

test "isInteger() with special values" {
    try std.testing.expect(!ValidationMethods.isInteger(Constants.NaN));
    try std.testing.expect(!ValidationMethods.isInteger(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ValidationMethods.isInteger(Constants.NEGATIVE_INFINITY));
}

test "isInteger() with large integers" {
    const max_safe = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER));
    const min_safe = @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER));
    try std.testing.expect(ValidationMethods.isInteger(max_safe));
    try std.testing.expect(ValidationMethods.isInteger(min_safe));
}

// ===== isNaN Tests =====

test "isNaN() with NaN" {
    try std.testing.expect(ValidationMethods.isNaN(Constants.NaN));
    try std.testing.expect(ValidationMethods.isNaN(std.math.nan(f64)));
}

test "isNaN() with numbers" {
    try std.testing.expect(!ValidationMethods.isNaN(0.0));
    try std.testing.expect(!ValidationMethods.isNaN(42.0));
    try std.testing.expect(!ValidationMethods.isNaN(-42.0));
    try std.testing.expect(!ValidationMethods.isNaN(3.14));
}

test "isNaN() with infinity" {
    try std.testing.expect(!ValidationMethods.isNaN(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ValidationMethods.isNaN(Constants.NEGATIVE_INFINITY));
}

// ===== isSafeInteger Tests =====

test "isSafeInteger() with safe integers" {
    try std.testing.expect(ValidationMethods.isSafeInteger(0.0));
    try std.testing.expect(ValidationMethods.isSafeInteger(42.0));
    try std.testing.expect(ValidationMethods.isSafeInteger(-42.0));
    try std.testing.expect(ValidationMethods.isSafeInteger(1000.0));
}

test "isSafeInteger() with boundary values" {
    const max_safe = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER));
    const min_safe = @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER));
    try std.testing.expect(ValidationMethods.isSafeInteger(max_safe));
    try std.testing.expect(ValidationMethods.isSafeInteger(min_safe));
}

test "isSafeInteger() with unsafe integers" {
    const unsafe_large = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER)) + 1.0;
    const unsafe_small = @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER)) - 1.0;
    try std.testing.expect(!ValidationMethods.isSafeInteger(unsafe_large));
    try std.testing.expect(!ValidationMethods.isSafeInteger(unsafe_small));
}

test "isSafeInteger() with floats" {
    try std.testing.expect(!ValidationMethods.isSafeInteger(3.14));
    try std.testing.expect(!ValidationMethods.isSafeInteger(0.5));
    try std.testing.expect(!ValidationMethods.isSafeInteger(-2.7));
}

test "isSafeInteger() with special values" {
    try std.testing.expect(!ValidationMethods.isSafeInteger(Constants.NaN));
    try std.testing.expect(!ValidationMethods.isSafeInteger(Constants.POSITIVE_INFINITY));
    try std.testing.expect(!ValidationMethods.isSafeInteger(Constants.NEGATIVE_INFINITY));
}

// ===== isInRange Tests =====

test "isInRange() with values in range" {
    try std.testing.expect(ValidationMethods.isInRange(5.0, 0.0, 10.0));
    try std.testing.expect(ValidationMethods.isInRange(0.0, 0.0, 10.0));
    try std.testing.expect(ValidationMethods.isInRange(10.0, 0.0, 10.0));
    try std.testing.expect(ValidationMethods.isInRange(-5.0, -10.0, 0.0));
}

test "isInRange() with values out of range" {
    try std.testing.expect(!ValidationMethods.isInRange(11.0, 0.0, 10.0));
    try std.testing.expect(!ValidationMethods.isInRange(-1.0, 0.0, 10.0));
    try std.testing.expect(!ValidationMethods.isInRange(100.0, 0.0, 10.0));
}

test "isInRange() with special values" {
    try std.testing.expect(!ValidationMethods.isInRange(Constants.NaN, 0.0, 10.0));
    try std.testing.expect(!ValidationMethods.isInRange(Constants.POSITIVE_INFINITY, 0.0, 10.0));
    try std.testing.expect(!ValidationMethods.isInRange(Constants.NEGATIVE_INFINITY, 0.0, 10.0));
}
