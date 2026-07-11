const std = @import("std");
const znumber = @import("znumber");
const ZNumber = znumber.ZNumber;
const Constants = znumber.Constants;

// ===== toExponential Tests =====

test "toExponential() default" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toExponential(null);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("1.23456e+2", result);
}

test "toExponential() with fraction digits" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toExponential(2);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("1.23e+2", result);
}

test "toExponential() honors requested fraction digits beyond 2 (regression: used to be a no-op)" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 1234.5678);
    const result = try num.toExponential(4);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("1.2346e+3", result);
}

test "toExponential() with NaN" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.NaN);
    const result = try num.toExponential(2);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("NaN", result);
}

test "toExponential() with Infinity" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result1 = try num1.toExponential(2);
    defer allocator.free(result1);
    try std.testing.expectEqualStrings("Infinity", result1);

    const num2 = ZNumber.init(allocator, Constants.NEGATIVE_INFINITY);
    const result2 = try num2.toExponential(2);
    defer allocator.free(result2);
    try std.testing.expectEqualStrings("-Infinity", result2);
}

test "toExponential() range validation" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);

    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toExponential(101));
}

test "toExponential() checks NaN/Infinity before the fraction-digits range (regression: order used to be reversed)" {
    const allocator = std.testing.allocator;

    const nan_num = ZNumber.init(allocator, Constants.NaN);
    const nan_result = try nan_num.toExponential(200);
    defer allocator.free(nan_result);
    try std.testing.expectEqualStrings("NaN", nan_result);

    const inf_num = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const inf_result = try inf_num.toExponential(200);
    defer allocator.free(inf_result);
    try std.testing.expectEqualStrings("Infinity", inf_result);
}

// ===== toFixed Tests =====

test "toFixed() default" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toFixed(null);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123", result);
}

test "toFixed() honors requested digit count beyond 2 (regression: used to be a no-op)" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 1.23456);
    const result = try num.toFixed(4);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("1.2346", result);
}

test "toFixed() with decimals" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toFixed(2);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123.46", result);
}

test "toFixed() zero decimals" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toFixed(0);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123", result);
}

test "toFixed() with NaN" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.NaN);
    const result = try num.toFixed(2);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("NaN", result);
}

test "toFixed() with Infinity" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result = try num.toFixed(2);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("Infinity", result);
}

test "toFixed() range validation" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);

    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toFixed(101));
}

// ===== toPrecision Tests =====

test "toPrecision() default" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toPrecision(null);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123.456", result);
}

test "toPrecision() with precision" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toPrecision(5);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123.46", result);
}

test "toPrecision() with NaN" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.NaN);
    const result = try num.toPrecision(3);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("NaN", result);
}

test "toPrecision() range validation" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);

    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toPrecision(0));
    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toPrecision(101));
}

test "toPrecision() checks NaN/Infinity before the precision range (regression: order used to be reversed)" {
    const allocator = std.testing.allocator;

    const nan_num = ZNumber.init(allocator, Constants.NaN);
    const nan_result = try nan_num.toPrecision(0);
    defer allocator.free(nan_result);
    try std.testing.expectEqualStrings("NaN", nan_result);

    const inf_num = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const inf_result = try inf_num.toPrecision(200);
    defer allocator.free(inf_result);
    try std.testing.expectEqualStrings("Infinity", inf_result);
}

// ===== toString Tests =====

test "toString() base 10" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toString(null);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("123.456", result);
}

test "toString() with NaN" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.NaN);
    const result = try num.toString(null);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("NaN", result);
}

test "toString() with Infinity" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result1 = try num1.toString(null);
    defer allocator.free(result1);
    try std.testing.expectEqualStrings("Infinity", result1);

    const num2 = ZNumber.init(allocator, Constants.NEGATIVE_INFINITY);
    const result2 = try num2.toString(null);
    defer allocator.free(result2);
    try std.testing.expectEqualStrings("-Infinity", result2);
}

test "toString() radix validation" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.0);

    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toString(1));
    try std.testing.expectError(znumber.ZNumberError.RangeError, num.toString(37));
}

test "toString() supports fractional values in non-base-10 radixes (regression: used to error)" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toString(16);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("7b.74bc6a7ef9dc", result);
}

test "toString() large integers in non-base-10 radixes are no longer limited to i64" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 1e20);
    const result = try num.toString(16);
    defer allocator.free(result);

    try std.testing.expectEqualStrings("56bc75e2d63100000", result);
}

// ===== toLocaleString Tests =====

test "toLocaleString() basic" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const result = try num.toLocaleString(null);
    defer allocator.free(result);

    try std.testing.expect(result.len > 0);
}
