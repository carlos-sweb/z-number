const std = @import("std");
const znumber = @import("znumber");
const Constants = znumber.Constants;

test "EPSILON is correct value" {
    try std.testing.expectEqual(@as(f64, 2.220446049250313e-16), Constants.EPSILON);
}

test "EPSILON is the smallest increment" {
    const one_plus_epsilon = 1.0 + Constants.EPSILON;
    try std.testing.expect(one_plus_epsilon > 1.0);

    const one_plus_half_epsilon = 1.0 + (Constants.EPSILON / 2.0);
    try std.testing.expectEqual(@as(f64, 1.0), one_plus_half_epsilon);
}

test "MAX_VALUE is correct" {
    try std.testing.expectEqual(@as(f64, 1.7976931348623157e+308), Constants.MAX_VALUE);
}

test "MAX_VALUE is largest representable number" {
    try std.testing.expect(Constants.MAX_VALUE > 0.0);
    try std.testing.expect(!std.math.isInf(Constants.MAX_VALUE));
}

test "MIN_VALUE is correct" {
    try std.testing.expectEqual(@as(f64, 5e-324), Constants.MIN_VALUE);
}

test "MIN_VALUE is smallest positive number" {
    try std.testing.expect(Constants.MIN_VALUE > 0.0);
    try std.testing.expect(Constants.MIN_VALUE < 1.0);
}

test "MAX_SAFE_INTEGER is correct" {
    try std.testing.expectEqual(@as(i64, 9007199254740991), Constants.MAX_SAFE_INTEGER);
}

test "MAX_SAFE_INTEGER is 2^53 - 1" {
    const expected = std.math.pow(i64, 2, 53) - 1;
    try std.testing.expectEqual(expected, Constants.MAX_SAFE_INTEGER);
}

test "MIN_SAFE_INTEGER is correct" {
    try std.testing.expectEqual(@as(i64, -9007199254740991), Constants.MIN_SAFE_INTEGER);
}

test "MIN_SAFE_INTEGER is -(2^53 - 1)" {
    const expected = -(std.math.pow(i64, 2, 53) - 1);
    try std.testing.expectEqual(expected, Constants.MIN_SAFE_INTEGER);
}

test "POSITIVE_INFINITY is infinity" {
    try std.testing.expect(std.math.isInf(Constants.POSITIVE_INFINITY));
    try std.testing.expect(Constants.POSITIVE_INFINITY > 0);
}

test "NEGATIVE_INFINITY is negative infinity" {
    try std.testing.expect(std.math.isInf(Constants.NEGATIVE_INFINITY));
    try std.testing.expect(Constants.NEGATIVE_INFINITY < 0);
}

test "NaN is not a number" {
    try std.testing.expect(std.math.isNan(Constants.NaN));
}

test "NaN is not equal to itself" {
    try std.testing.expect(Constants.NaN != Constants.NaN);
}

test "Constants are immutable" {
    // This test verifies that constants have expected properties
    try std.testing.expect(Constants.EPSILON > 0);
    try std.testing.expect(Constants.MAX_VALUE > Constants.MIN_VALUE);
    try std.testing.expect(Constants.MAX_SAFE_INTEGER > 0);
    try std.testing.expect(Constants.MIN_SAFE_INTEGER < 0);
}
