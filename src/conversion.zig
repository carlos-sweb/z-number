const std = @import("std");
const Constants = @import("constants.zig").Constants;
const ZNumberError = @import("errors.zig").ZNumberError;
const ValidationMethods = @import("validation.zig").ValidationMethods;

/// Conversion methods for converting between numeric types
/// These methods handle safe conversions with proper error checking
pub const ConversionMethods = struct {
    /// Convert to integer (truncate)
    /// Labeled block example 11
    pub fn toInt(value: f64) !i64 {
        int_converter: {
            // Check if value is finite
            if (!ValidationMethods.isFinite(value)) {
                return ZNumberError.InvalidNumber;
            }

            // Check for overflow
            if (value > @as(f64, @floatFromInt(std.math.maxInt(i64)))) {
                return ZNumberError.Overflow;
            }

            // Check for underflow
            if (value < @as(f64, @floatFromInt(std.math.minInt(i64)))) {
                return ZNumberError.Underflow;
            }

            break :int_converter;
        }

        return @intFromFloat(@trunc(value));
    }

    /// Convert to unsigned integer
    pub fn toUint(value: f64) !u64 {
        uint_converter: {
            if (!ValidationMethods.isFinite(value)) {
                return ZNumberError.InvalidNumber;
            }

            if (value < 0) {
                return ZNumberError.Underflow;
            }

            if (value > @as(f64, @floatFromInt(std.math.maxInt(u64)))) {
                return ZNumberError.Overflow;
            }

            break :uint_converter;
        }

        return @intFromFloat(@trunc(value));
    }

    /// ToUint32(value), ECMA-262 7.1.7: NaN/Infinity/±0 map to 0, otherwise
    /// truncate towards zero and wrap modulo 2^32. Never fails, matching JS's
    /// `value >>> 0`.
    pub fn toU32(value: f64) u32 {
        if (!ValidationMethods.isFinite(value) or value == 0) return 0;
        const wrapped = @mod(@trunc(value), 4294967296.0);
        return @intFromFloat(wrapped);
    }

    /// ToInt32(value), ECMA-262 7.1.6: same as ToUint32 but the top half of
    /// the range is reinterpreted as negative (two's complement). Never
    /// fails, matching JS's `value | 0`.
    pub fn toI32(value: f64) i32 {
        return @bitCast(toU32(value));
    }

    /// Convert from bytes (IEEE 754)
    pub fn fromBytes(bytes: [8]u8) f64 {
        return @bitCast(bytes);
    }

    /// Convert to bytes (IEEE 754)
    pub fn toBytes(value: f64) [8]u8 {
        return @bitCast(value);
    }

    /// Convert to f32 (may lose precision)
    pub fn toF32(value: f64) !f32 {
        f32_converter: {
            if (std.math.isNan(value)) {
                return std.math.nan(f32);
            }

            if (std.math.isInf(value)) {
                if (value > 0) {
                    return std.math.inf(f32);
                } else {
                    return -std.math.inf(f32);
                }
            }

            const abs_value = @abs(value);
            if (abs_value > std.math.floatMax(f32) and abs_value != std.math.inf(f64)) {
                return ZNumberError.Overflow;
            }

            break :f32_converter;
        }

        return @floatCast(value);
    }
};
