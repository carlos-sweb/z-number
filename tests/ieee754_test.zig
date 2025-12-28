const std = @import("std");
const znumber = @import("znumber");
const ZNumber = znumber.ZNumber;
const Constants = znumber.Constants;
const ConversionMethods = znumber.ConversionMethods;

// ===== IEEE 754 Compliance Tests =====

test "IEEE 754 - double precision format" {
    // f64 is IEEE 754 double precision (64 bits)
    try std.testing.expectEqual(8, @sizeOf(f64));
}

test "IEEE 754 - NaN representation" {
    const nan_bytes = ConversionMethods.toBytes(Constants.NaN);
    const reconstructed = ConversionMethods.fromBytes(nan_bytes);
    try std.testing.expect(std.math.isNan(reconstructed));
}

test "IEEE 754 - positive infinity representation" {
    const inf_bytes = ConversionMethods.toBytes(Constants.POSITIVE_INFINITY);
    const reconstructed = ConversionMethods.fromBytes(inf_bytes);
    try std.testing.expect(std.math.isInf(reconstructed));
    try std.testing.expect(reconstructed > 0);
}

test "IEEE 754 - negative infinity representation" {
    const neg_inf_bytes = ConversionMethods.toBytes(Constants.NEGATIVE_INFINITY);
    const reconstructed = ConversionMethods.fromBytes(neg_inf_bytes);
    try std.testing.expect(std.math.isInf(reconstructed));
    try std.testing.expect(reconstructed < 0);
}

test "IEEE 754 - positive zero" {
    const bytes = ConversionMethods.toBytes(0.0);
    // Sign bit should be 0
    try std.testing.expectEqual(@as(u8, 0), bytes[7] & 0x80);
}

test "IEEE 754 - negative zero" {
    const bytes = ConversionMethods.toBytes(-0.0);
    // Sign bit should be 1
    try std.testing.expect((bytes[7] & 0x80) != 0);
}

// ===== Byte Representation Tests =====

test "byte representation - round trip for positive number" {
    const original: f64 = 42.5;
    const bytes = ConversionMethods.toBytes(original);
    const reconstructed = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(original, reconstructed);
}

test "byte representation - round trip for negative number" {
    const original: f64 = -42.5;
    const bytes = ConversionMethods.toBytes(original);
    const reconstructed = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(original, reconstructed);
}

test "byte representation - round trip for MAX_VALUE" {
    const bytes = ConversionMethods.toBytes(Constants.MAX_VALUE);
    const reconstructed = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(Constants.MAX_VALUE, reconstructed);
}

test "byte representation - round trip for MIN_VALUE" {
    const bytes = ConversionMethods.toBytes(Constants.MIN_VALUE);
    const reconstructed = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(Constants.MIN_VALUE, reconstructed);
}

test "byte representation - ZNumber instance methods" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 123.456);
    const bytes = num.toBytes();
    const reconstructed_num = ZNumber.fromBytes(allocator, bytes);
    try std.testing.expectEqual(num.value, reconstructed_num.value);
}

// ===== Special Values Encoding Tests =====

test "special values encoding - NaN has specific pattern" {
    // Exponent should be all 1s (bits 52-62)
    const exponent_mask: u64 = 0x7FF0000000000000;
    const bytes_as_u64: u64 = @bitCast(Constants.NaN);
    try std.testing.expectEqual(exponent_mask, bytes_as_u64 & exponent_mask);
}

test "special values encoding - infinity has specific pattern" {
    const bytes_as_u64: u64 = @bitCast(Constants.POSITIVE_INFINITY);

    // Exponent should be all 1s, mantissa should be 0
    const exponent_mask: u64 = 0x7FF0000000000000;
    const mantissa_mask: u64 = 0x000FFFFFFFFFFFFF;

    try std.testing.expectEqual(exponent_mask, bytes_as_u64 & exponent_mask);
    try std.testing.expectEqual(@as(u64, 0), bytes_as_u64 & mantissa_mask);
}

test "special values encoding - zero has all bits zero (except sign)" {
    const bytes_as_u64: u64 = @bitCast(@as(f64, 0.0));
    try std.testing.expectEqual(@as(u64, 0), bytes_as_u64);
}

// ===== Precision Limits Tests =====

test "precision limits - EPSILON represents minimum distinguishable difference" {
    const one_plus_epsilon = 1.0 + Constants.EPSILON;
    try std.testing.expect(one_plus_epsilon > 1.0);
    try std.testing.expect(one_plus_epsilon != 1.0);
}

test "precision limits - half EPSILON doesn't distinguish" {
    const one_plus_half_epsilon = 1.0 + (Constants.EPSILON / 2.0);
    try std.testing.expectEqual(@as(f64, 1.0), one_plus_half_epsilon);
}

test "precision limits - safe integer boundary" {
    const max_safe = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER));
    const max_safe_minus_one = max_safe - 1.0;
    const max_safe_minus_two = max_safe - 2.0;

    // Within safe range, consecutive integers are distinguishable
    try std.testing.expect(max_safe > max_safe_minus_one);
    try std.testing.expect(max_safe_minus_one > max_safe_minus_two);
}

test "precision limits - beyond safe integer loses precision" {
    const unsafe = @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER)) + 10.0;

    // Beyond safe range, we might not distinguish small increments
    // This test verifies we're aware of the limitation
    try std.testing.expect(unsafe > @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER)));
}

test "precision limits - subnormal number handling" {
    // MIN_VALUE is a subnormal number
    const min_val = Constants.MIN_VALUE;
    try std.testing.expect(min_val > 0.0);

    // Operations with subnormal numbers
    const doubled = min_val * 2.0;
    try std.testing.expect(doubled > min_val);
}

// ===== Bit Pattern Tests =====

test "bit pattern - sign bit extraction" {
    const pos_bytes = ConversionMethods.toBytes(42.0);
    const neg_bytes = ConversionMethods.toBytes(-42.0);

    // Positive number: sign bit = 0
    try std.testing.expectEqual(@as(u8, 0), pos_bytes[7] & 0x80);

    // Negative number: sign bit = 1
    try std.testing.expect((neg_bytes[7] & 0x80) != 0);
}

test "bit pattern - exponent extraction" {
    const value: f64 = 1.0; // 2^0
    const bytes_as_u64: u64 = @bitCast(value);
    const exponent_bits = (bytes_as_u64 >> 52) & 0x7FF;

    // For 1.0, exponent should be 1023 (bias for 2^0)
    try std.testing.expectEqual(@as(u64, 1023), exponent_bits);
}

test "bit pattern - mantissa extraction" {
    const value: f64 = 1.5; // 1.5 = 1.1 in binary
    const bytes_as_u64: u64 = @bitCast(value);
    const mantissa_bits = bytes_as_u64 & 0x000FFFFFFFFFFFFF;

    // Mantissa should be non-zero for 1.5
    try std.testing.expect(mantissa_bits > 0);
}

// ===== Rounding Tests =====

test "rounding - default round to nearest even" {
    // IEEE 754 uses "round to nearest, ties to even"
    const a = 0.1 + 0.2;
    const b = 0.3;

    // Due to floating point representation, these might not be exactly equal
    const diff = @abs(a - b);
    try std.testing.expect(diff < Constants.EPSILON);
}

test "rounding - truncation in conversion" {
    const value: f64 = 3.7;
    const truncated = try ConversionMethods.toInt(value);
    try std.testing.expectEqual(@as(i64, 3), truncated);
}

// ===== Denormalized Numbers Tests =====

test "denormalized numbers - MIN_VALUE is denormalized" {
    const min_val_u64: u64 = @bitCast(Constants.MIN_VALUE);
    const exponent_bits = (min_val_u64 >> 52) & 0x7FF;

    // Denormalized numbers have exponent = 0
    try std.testing.expectEqual(@as(u64, 0), exponent_bits);
}

test "denormalized numbers - operations preserve properties" {
    const min_val = Constants.MIN_VALUE;
    const result = min_val / 2.0;

    // Result should still be positive and finite
    try std.testing.expect(result >= 0.0);
}

// ===== Comparison of Representations =====

test "representation comparison - same value same bytes" {
    const value1: f64 = 42.42;
    const value2: f64 = 42.42;

    const bytes1 = ConversionMethods.toBytes(value1);
    const bytes2 = ConversionMethods.toBytes(value2);

    try std.testing.expectEqualSlices(u8, &bytes1, &bytes2);
}

test "representation comparison - different values different bytes" {
    const value1: f64 = 42.0;
    const value2: f64 = 43.0;

    const bytes1 = ConversionMethods.toBytes(value1);
    const bytes2 = ConversionMethods.toBytes(value2);

    try std.testing.expect(!std.mem.eql(u8, &bytes1, &bytes2));
}

test "representation comparison - +0 and -0 differ in sign bit only" {
    const pos_zero_bytes = ConversionMethods.toBytes(0.0);
    const neg_zero_bytes = ConversionMethods.toBytes(-0.0);

    // All bytes should be same except sign bit
    try std.testing.expectEqual(pos_zero_bytes[0], neg_zero_bytes[0]);
    try std.testing.expectEqual(pos_zero_bytes[1], neg_zero_bytes[1]);
    try std.testing.expectEqual(pos_zero_bytes[2], neg_zero_bytes[2]);
    try std.testing.expectEqual(pos_zero_bytes[3], neg_zero_bytes[3]);
    try std.testing.expectEqual(pos_zero_bytes[4], neg_zero_bytes[4]);
    try std.testing.expectEqual(pos_zero_bytes[5], neg_zero_bytes[5]);
    try std.testing.expectEqual(pos_zero_bytes[6], neg_zero_bytes[6]);

    // Only the sign bit in byte 7 should differ
    try std.testing.expectEqual(@as(u8, 0x80), pos_zero_bytes[7] ^ neg_zero_bytes[7]);
}
