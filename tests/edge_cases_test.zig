const std = @import("std");
const znumber = @import("znumber");
const ZNumber = znumber.ZNumber;
const Constants = znumber.Constants;

// ===== Division by Zero Tests =====

test "division by zero - positive / 0 = Infinity" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, 42.0);
    const num2 = ZNumber.init(allocator, 0.0);
    const result = num1.divide(num2);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, result.value);
}

test "division by zero - negative / 0 = -Infinity" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, -42.0);
    const num2 = ZNumber.init(allocator, 0.0);
    const result = num1.divide(num2);
    try std.testing.expectEqual(Constants.NEGATIVE_INFINITY, result.value);
}

test "division by zero - 0 / 0 = NaN" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, 0.0);
    const num2 = ZNumber.init(allocator, 0.0);
    const result = num1.divide(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

// ===== Overflow Handling Tests =====

test "overflow handling in conversion" {
    const too_large = Constants.MAX_VALUE;
    try std.testing.expectError(znumber.ZNumberError.Overflow, znumber.ConversionMethods.toInt(too_large));
}

test "overflow in i32 conversion" {
    const too_large = @as(f64, @floatFromInt(std.math.maxInt(i32))) + 100.0;
    try std.testing.expectError(znumber.ZNumberError.Overflow, znumber.ConversionMethods.toI32(too_large));
}

test "overflow in u32 conversion" {
    const too_large = @as(f64, @floatFromInt(std.math.maxInt(u32))) + 100.0;
    try std.testing.expectError(znumber.ZNumberError.Overflow, znumber.ConversionMethods.toU32(too_large));
}

// ===== Underflow Handling Tests =====

test "underflow handling in conversion" {
    const too_small = -Constants.MAX_VALUE;
    try std.testing.expectError(znumber.ZNumberError.Underflow, znumber.ConversionMethods.toInt(too_small));
}

test "underflow in i32 conversion" {
    const too_small = @as(f64, @floatFromInt(std.math.minInt(i32))) - 100.0;
    try std.testing.expectError(znumber.ZNumberError.Underflow, znumber.ConversionMethods.toI32(too_small));
}

test "underflow in unsigned conversion" {
    try std.testing.expectError(znumber.ZNumberError.Underflow, znumber.ConversionMethods.toUint(-1.0));
    try std.testing.expectError(znumber.ZNumberError.Underflow, znumber.ConversionMethods.toU32(-1.0));
}

// ===== NaN Propagation Tests =====

test "NaN propagation in addition" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, 42.0);
    const result = num1.add(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

test "NaN propagation in subtraction" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, 42.0);
    const num2 = ZNumber.init(allocator, Constants.NaN);
    const result = num1.subtract(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

test "NaN propagation in multiplication" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, 42.0);
    const result = num1.multiply(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

test "NaN propagation in division" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, 42.0);
    const result = num1.divide(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

test "NaN propagation in power" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const result = num1.power(2.0);
    try std.testing.expect(std.math.isNan(result.value));
}

// ===== Infinity Arithmetic Tests =====

test "infinity arithmetic - Infinity + 100" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const num2 = ZNumber.init(allocator, 100.0);
    const result = num1.add(num2);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, result.value);
}

test "infinity arithmetic - Infinity - 100" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const num2 = ZNumber.init(allocator, 100.0);
    const result = num1.subtract(num2);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, result.value);
}

test "infinity arithmetic - Infinity * 2" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const num2 = ZNumber.init(allocator, 2.0);
    const result = num1.multiply(num2);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, result.value);
}

test "infinity arithmetic - Infinity / 2" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const num2 = ZNumber.init(allocator, 2.0);
    const result = num1.divide(num2);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, result.value);
}

test "infinity arithmetic - Infinity - Infinity = NaN" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const num2 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result = num1.subtract(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

// ===== Signed Zero Tests =====

test "signed zero - positive zero" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 0.0);
    try std.testing.expectEqual(@as(f64, 0.0), num.value);
}

test "signed zero - negative zero" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, -0.0);
    const bytes = num.toBytes();
    const reconstructed = znumber.ConversionMethods.fromBytes(bytes);

    // Check sign bit
    const sign_bit = bytes[7] & 0x80;
    try std.testing.expect(sign_bit != 0);
    try std.testing.expectEqual(@as(f64, -0.0), reconstructed);
}

test "signed zero - division producing negative zero" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, -1.0);
    const num2 = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result = num1.divide(num2);

    // -1 / Infinity should be -0
    const bytes = result.toBytes();
    const sign_bit = bytes[7] & 0x80;
    try std.testing.expect(sign_bit != 0);
}

// ===== Subnormal Numbers Tests =====

test "subnormal numbers - MIN_VALUE is subnormal" {
    try std.testing.expect(Constants.MIN_VALUE > 0.0);
    try std.testing.expect(Constants.MIN_VALUE < 1.0);
}

test "subnormal numbers - operations" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.MIN_VALUE);
    const num2 = ZNumber.init(allocator, 2.0);
    const result = num1.multiply(num2);

    try std.testing.expect(result.value > 0.0);
    try std.testing.expect(result.value > Constants.MIN_VALUE);
}

// ===== Comparison Edge Cases =====

test "NaN comparison - NaN != NaN" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, Constants.NaN);
    try std.testing.expect(!num1.equals(num2));
}

test "NaN comparison - NaN not less than anything" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, 42.0);
    try std.testing.expect(!num1.lessThan(num2));
}

test "NaN comparison - NaN not greater than anything" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, Constants.NaN);
    const num2 = ZNumber.init(allocator, 42.0);
    try std.testing.expect(!num1.greaterThan(num2));
}

// ===== Modulo Edge Cases =====

test "modulo with zero divisor = NaN" {
    const allocator = std.testing.allocator;
    const num1 = ZNumber.init(allocator, 42.0);
    const num2 = ZNumber.init(allocator, 0.0);
    const result = num1.modulo(num2);
    try std.testing.expect(std.math.isNan(result.value));
}

// ===== Power Edge Cases =====

test "power - 0^0 = 1" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 0.0);
    const result = num.power(0.0);
    try std.testing.expectEqual(@as(f64, 1.0), result.value);
}

test "power - Infinity^0 = 1" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, Constants.POSITIVE_INFINITY);
    const result = num.power(0.0);
    try std.testing.expectEqual(@as(f64, 1.0), result.value);
}

test "power - negative base with fractional exponent = NaN" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, -2.0);
    const result = num.power(0.5);
    try std.testing.expect(std.math.isNan(result.value));
}
