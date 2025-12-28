const std = @import("std");
const znumber = @import("znumber");
const ConversionMethods = znumber.ConversionMethods;
const Constants = znumber.Constants;
const ZNumber = znumber.ZNumber;

// ===== toInt Tests =====

test "toInt() with valid integers" {
    try std.testing.expectEqual(@as(i64, 42), try ConversionMethods.toInt(42.0));
    try std.testing.expectEqual(@as(i64, -42), try ConversionMethods.toInt(-42.0));
    try std.testing.expectEqual(@as(i64, 0), try ConversionMethods.toInt(0.0));
}

test "toInt() with floats (truncate)" {
    try std.testing.expectEqual(@as(i64, 3), try ConversionMethods.toInt(3.14));
    try std.testing.expectEqual(@as(i64, -3), try ConversionMethods.toInt(-3.14));
    try std.testing.expectEqual(@as(i64, 99), try ConversionMethods.toInt(99.99));
}

test "toInt() with NaN" {
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ConversionMethods.toInt(Constants.NaN));
}

test "toInt() with infinity" {
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ConversionMethods.toInt(Constants.POSITIVE_INFINITY));
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ConversionMethods.toInt(Constants.NEGATIVE_INFINITY));
}

test "toInt() overflow" {
    const too_large = @as(f64, @floatFromInt(std.math.maxInt(i64))) * 2.0;
    try std.testing.expectError(znumber.ZNumberError.Overflow, ConversionMethods.toInt(too_large));
}

test "toInt() underflow" {
    const too_small = @as(f64, @floatFromInt(std.math.minInt(i64))) * 2.0;
    try std.testing.expectError(znumber.ZNumberError.Underflow, ConversionMethods.toInt(too_small));
}

// ===== toUint Tests =====

test "toUint() with valid unsigned integers" {
    try std.testing.expectEqual(@as(u64, 42), try ConversionMethods.toUint(42.0));
    try std.testing.expectEqual(@as(u64, 0), try ConversionMethods.toUint(0.0));
    try std.testing.expectEqual(@as(u64, 100), try ConversionMethods.toUint(100.5));
}

test "toUint() with negative number" {
    try std.testing.expectError(znumber.ZNumberError.Underflow, ConversionMethods.toUint(-42.0));
    try std.testing.expectError(znumber.ZNumberError.Underflow, ConversionMethods.toUint(-1.0));
}

test "toUint() with NaN" {
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ConversionMethods.toUint(Constants.NaN));
}

test "toUint() with infinity" {
    try std.testing.expectError(znumber.ZNumberError.InvalidNumber, ConversionMethods.toUint(Constants.POSITIVE_INFINITY));
}

// ===== toI32 Tests =====

test "toI32() with valid i32 values" {
    try std.testing.expectEqual(@as(i32, 42), try ConversionMethods.toI32(42.0));
    try std.testing.expectEqual(@as(i32, -42), try ConversionMethods.toI32(-42.0));
    try std.testing.expectEqual(@as(i32, 0), try ConversionMethods.toI32(0.0));
}

test "toI32() with floats" {
    try std.testing.expectEqual(@as(i32, 3), try ConversionMethods.toI32(3.99));
    try std.testing.expectEqual(@as(i32, -3), try ConversionMethods.toI32(-3.99));
}

test "toI32() overflow" {
    const too_large = @as(f64, @floatFromInt(std.math.maxInt(i32))) + 1.0;
    try std.testing.expectError(znumber.ZNumberError.Overflow, ConversionMethods.toI32(too_large));
}

test "toI32() underflow" {
    const too_small = @as(f64, @floatFromInt(std.math.minInt(i32))) - 1.0;
    try std.testing.expectError(znumber.ZNumberError.Underflow, ConversionMethods.toI32(too_small));
}

// ===== toU32 Tests =====

test "toU32() with valid u32 values" {
    try std.testing.expectEqual(@as(u32, 42), try ConversionMethods.toU32(42.0));
    try std.testing.expectEqual(@as(u32, 0), try ConversionMethods.toU32(0.0));
}

test "toU32() with negative number" {
    try std.testing.expectError(znumber.ZNumberError.Underflow, ConversionMethods.toU32(-1.0));
}

test "toU32() overflow" {
    const too_large = @as(f64, @floatFromInt(std.math.maxInt(u32))) + 1.0;
    try std.testing.expectError(znumber.ZNumberError.Overflow, ConversionMethods.toU32(too_large));
}

// ===== toBytes / fromBytes Tests =====

test "toBytes() and fromBytes() round-trip" {
    const value: f64 = 42.5;
    const bytes = ConversionMethods.toBytes(value);
    const result = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(value, result);
}

test "toBytes() NaN" {
    const bytes = ConversionMethods.toBytes(Constants.NaN);
    const result = ConversionMethods.fromBytes(bytes);
    try std.testing.expect(std.math.isNan(result));
}

test "toBytes() infinity" {
    const pos_bytes = ConversionMethods.toBytes(Constants.POSITIVE_INFINITY);
    const pos_result = ConversionMethods.fromBytes(pos_bytes);
    try std.testing.expectEqual(Constants.POSITIVE_INFINITY, pos_result);

    const neg_bytes = ConversionMethods.toBytes(Constants.NEGATIVE_INFINITY);
    const neg_result = ConversionMethods.fromBytes(neg_bytes);
    try std.testing.expectEqual(Constants.NEGATIVE_INFINITY, neg_result);
}

test "toBytes() zero" {
    const bytes = ConversionMethods.toBytes(0.0);
    const result = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(@as(f64, 0.0), result);
}

// ===== toF32 Tests =====

test "toF32() with valid f32 values" {
    try std.testing.expectEqual(@as(f32, 42.0), try ConversionMethods.toF32(42.0));
    try std.testing.expectEqual(@as(f32, 3.14), try ConversionMethods.toF32(3.14));
    try std.testing.expectEqual(@as(f32, 0.0), try ConversionMethods.toF32(0.0));
}

test "toF32() with NaN" {
    const result = try ConversionMethods.toF32(Constants.NaN);
    try std.testing.expect(std.math.isNan(result));
}

test "toF32() with infinity" {
    const pos_result = try ConversionMethods.toF32(Constants.POSITIVE_INFINITY);
    try std.testing.expect(std.math.isInf(pos_result));
    try std.testing.expect(pos_result > 0);

    const neg_result = try ConversionMethods.toF32(Constants.NEGATIVE_INFINITY);
    try std.testing.expect(std.math.isInf(neg_result));
    try std.testing.expect(neg_result < 0);
}

// ===== ZNumber Instance Conversion Tests =====

test "ZNumber.toInt() instance method" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.5);
    try std.testing.expectEqual(@as(i64, 42), try num.toInt());
}

test "ZNumber.toUint() instance method" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.5);
    try std.testing.expectEqual(@as(u64, 42), try num.toUint());
}

test "ZNumber.toI32() instance method" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.5);
    try std.testing.expectEqual(@as(i32, 42), try num.toI32());
}

test "ZNumber.toU32() instance method" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.5);
    try std.testing.expectEqual(@as(u32, 42), try num.toU32());
}

test "ZNumber.toBytes() instance method" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.5);
    const bytes = num.toBytes();
    const result = ConversionMethods.fromBytes(bytes);
    try std.testing.expectEqual(@as(f64, 42.5), result);
}

test "ZNumber.fromBytes() static method" {
    const allocator = std.testing.allocator;
    const bytes = ConversionMethods.toBytes(42.5);
    const num = ZNumber.fromBytes(allocator, bytes);
    try std.testing.expectEqual(@as(f64, 42.5), num.value);
}
