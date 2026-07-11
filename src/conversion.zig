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

    /// Generic ToUintN(value), covering ECMA-262 7.1.7 (ToUint32, bits=32)
    /// and the analogous ToUint8/ToUint16 used by TypedArrays: NaN/Infinity/±0
    /// map to 0, otherwise truncate towards zero and wrap modulo 2^bits.
    /// Never fails. `bits` is restricted to the widths ECMA-262 actually
    /// specifies this formula for; other widths have no spec backing here.
    pub fn toUintN(comptime bits: u16, value: f64) std.meta.Int(.unsigned, bits) {
        comptime std.debug.assert(bits == 8 or bits == 16 or bits == 32);
        if (!ValidationMethods.isFinite(value)) return 0;
        const modulus: f64 = @floatFromInt(@as(u64, 1) << bits);
        // @mod(±0, modulus) is already 0, and the unsigned/signed result
        // types have no negative-zero representation, so ±0 needs no
        // special case beyond the isFinite check above.
        const wrapped = @mod(@trunc(value), modulus);
        return @intFromFloat(wrapped);
    }

    /// Generic ToIntN(value), covering ECMA-262 7.1.6 (ToInt32, bits=32) and
    /// the analogous ToInt8/ToInt16: same wrap-around as ToUintN, with the
    /// top half of the range reinterpreted as negative (two's complement).
    /// Never fails.
    pub fn toIntN(comptime bits: u16, value: f64) std.meta.Int(.signed, bits) {
        return @bitCast(toUintN(bits, value));
    }

    /// ToUint32(value), ECMA-262 7.1.7. Never fails, matching JS's `value >>> 0`.
    pub fn toU32(value: f64) u32 {
        return toUintN(32, value);
    }

    /// ToInt32(value), ECMA-262 7.1.6. Never fails, matching JS's `value | 0`.
    pub fn toI32(value: f64) i32 {
        return toIntN(32, value);
    }

    /// ToInt8(value), used by Int8Array element coercion. Never fails.
    pub fn toI8(value: f64) i8 {
        return toIntN(8, value);
    }

    /// ToUint8(value), used by Uint8Array element coercion. Never fails.
    pub fn toU8(value: f64) u8 {
        return toUintN(8, value);
    }

    /// ToInt16(value), used by Int16Array element coercion. Never fails.
    pub fn toI16(value: f64) i16 {
        return toIntN(16, value);
    }

    /// ToUint16(value), used by Uint16Array element coercion. Never fails.
    pub fn toU16(value: f64) u16 {
        return toUintN(16, value);
    }

    /// ToUint8Clamp(value), ECMA-262 7.1.11, used by Uint8ClampedArray
    /// element coercion. Unlike the other TypedArray conversions this is NOT
    /// a wrap-around: out-of-range values saturate to 0/255, and non-integer
    /// values round to nearest with ties broken towards the even neighbor
    /// (not away from zero). Never fails.
    pub fn toUint8Clamp(value: f64) u8 {
        if (std.math.isNan(value) or value <= 0) return 0;
        if (value >= 255) return 255;

        const f = @floor(value);
        if (f + 0.5 < value) return @intFromFloat(f + 1);
        if (value < f + 0.5) return @intFromFloat(f);

        const fi: u8 = @intFromFloat(f);
        return if (fi % 2 == 1) fi + 1 else fi;
    }

    /// ToIntegerOrInfinity(value), ECMA-262 7.1.5: NaN/±0 map to 0, ±Infinity
    /// pass through unchanged, otherwise truncate towards zero. The result of
    /// truncating a finite f64 is always exactly representable in f64, so no
    /// precision is lost returning it as f64 (unlike the true spec algorithm,
    /// which allows unbounded mathematical integers — not reachable here
    /// since the input is already an f64).
    pub fn toIntegerOrInfinity(value: f64) f64 {
        if (std.math.isNan(value) or value == 0) return 0;
        if (std.math.isInf(value)) return value;
        return @trunc(value);
    }

    /// ToLength(value), ECMA-262 7.1.20: ToIntegerOrInfinity clamped to
    /// [0, 2^53 - 1] (Number.MAX_SAFE_INTEGER). Used pervasively for array
    /// lengths and indices throughout the spec.
    pub fn toLength(value: f64) f64 {
        const len = toIntegerOrInfinity(value);
        if (len <= 0) return 0;
        return @min(len, @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER)));
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
