//! Typed ECMAScript Number operations for Zig 0.17.0.
//!
//! Start with `ZNumber`, or use the stateless parsing, formatting, validation
//! and conversion helpers. Inputs are binary64 numbers and UTF-8 strings;
//! optional numeric arguments use `null` for omission, not JavaScript null.
//!
//! Formatting returns owned slices: free each with the supplied allocator.
//! Numbers borrow their allocator and `ZNumber.deinit` does not free strings.
//! Large integer parsing and formatting can return `error.OutOfMemory`.
//! Invalid parsing yields NaN; invalid formatting/index ranges yield
//! `error.RangeError`. Checked Zig conversions also report InvalidNumber,
//! Overflow or Underflow. See each helper for its specific contract.
//!
//! The scope excludes dynamic JS object coercion, BigInt and ECMA-402 Intl.
//! `toLocaleString` is a decimal fallback that ignores locale.

const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Constants = @import("constants.zig").Constants;
pub const ZNumberError = @import("errors.zig").ZNumberError;
pub const ErrorContext = @import("errors.zig").ErrorContext;
pub const ValidationMethods = @import("validation.zig").ValidationMethods;
pub const ParsingMethods = @import("parsing.zig").ParsingMethods;
pub const FormattingMethods = @import("formatting.zig").FormattingMethods;
pub const ConversionMethods = @import("conversion.zig").ConversionMethods;

/// ZNumber - ECMAScript-compatible Number implementation
/// Stores a binary64 value and a borrowed allocator. Binary instance operations
/// retain the left operand's allocator; no operation owns that allocator.
/// Formatting outputs must be freed individually by the caller.
pub const ZNumber = struct {
    value: f64,
    allocator: Allocator,

    const Self = @This();

    // ===== Initialization Methods =====

    /// Initialize a new ZNumber from f64
    pub fn init(allocator: Allocator, value: f64) Self {
        return .{
            .value = value,
            .allocator = allocator,
        };
    }

    /// Initialize from integer
    pub fn fromInt(allocator: Allocator, value: i64) Self {
        return .{
            .value = @floatFromInt(value),
            .allocator = allocator,
        };
    }

    /// Initialize using Number(string), requiring the complete UTF-8 literal.
    /// Invalid input yields a NaN value; nondecimal parsing may return OutOfMemory.
    pub fn fromString(allocator: Allocator, str: []const u8) !Self {
        const parsed_value = try ParsingMethods.stringToNumber(allocator, str);
        return .{
            .value = parsed_value,
            .allocator = allocator,
        };
    }

    /// No-op provided for API consistency; does not release formatting outputs.
    pub fn deinit(self: Self) void {
        _ = self;
    }

    // ===== Static Methods (Number.*) =====

    /// Number.isFinite() - Check if value is finite
    pub fn isFinite(value: f64) bool {
        return ValidationMethods.isFinite(value);
    }

    /// Number.isInteger() - Check if value is integer
    pub fn isInteger(value: f64) bool {
        return ValidationMethods.isInteger(value);
    }

    /// Number.isNaN() - Check if value is NaN
    pub fn isNaN(value: f64) bool {
        return ValidationMethods.isNaN(value);
    }

    /// Number.isSafeInteger() - Check if value is safe integer
    pub fn isSafeInteger(value: f64) bool {
        return ValidationMethods.isSafeInteger(value);
    }

    /// Parse the longest decimal/Infinity prefix after ECMAScript whitespace.
    /// Invalid input yields NaN; no heap allocation is performed.
    pub fn parseFloat(str: []const u8) f64 {
        return ParsingMethods.parseFloat(str);
    }

    /// Parse a UTF-8 integer prefix; radix uses ToInt32, with null/zero auto-detect.
    /// Bases 2...36 are valid; only 0x is auto-detected (otherwise decimal).
    /// Invalid input yields NaN. Magnitudes fitting u64 need no heap; larger
    /// inputs use temporary storage and may return error.OutOfMemory.
    pub fn parseInt(allocator: Allocator, str: []const u8, radix: ?f64) !f64 {
        return ParsingMethods.parseInt(allocator, str, radix);
    }

    // ===== Instance Methods =====

    /// toExponential() - Return string in exponential notation
    /// Returns an owned slice: free with self.allocator; may return OutOfMemory.
    /// See FormattingMethods.toExponential for argument normalization and RangeError.
    pub fn toExponential(self: Self, fraction_digits: ?f64) ![]u8 {
        return FormattingMethods.toExponential(self.value, self.allocator, fraction_digits);
    }

    /// toFixed() - Return string with fixed decimals
    /// Returns an owned slice: free with self.allocator; may return OutOfMemory.
    /// See FormattingMethods.toFixed for argument normalization and RangeError.
    pub fn toFixed(self: Self, fraction_digits: ?f64) ![]u8 {
        return FormattingMethods.toFixed(self.value, self.allocator, fraction_digits);
    }

    /// toPrecision() - Return string with specified precision
    /// Returns an owned slice: free with self.allocator; may return OutOfMemory.
    /// See FormattingMethods.toPrecision for argument normalization and RangeError.
    pub fn toPrecision(self: Self, precision: ?f64) ![]u8 {
        return FormattingMethods.toPrecision(self.value, self.allocator, precision);
    }

    /// toString() - Convert to string with optional radix
    /// Returns an owned slice: free with self.allocator; may return OutOfMemory.
    /// See FormattingMethods.toString for argument normalization and RangeError.
    pub fn toString(self: Self, radix: ?f64) ![]u8 {
        return FormattingMethods.toString(self.value, self.allocator, radix);
    }

    /// Decimal fallback without Intl; locale is accepted but ignored.
    /// Returns an owned slice: free with self.allocator; may return OutOfMemory.
    pub fn toLocaleString(self: Self, locale: ?[]const u8) ![]u8 {
        return FormattingMethods.toLocaleString(self.value, self.allocator, locale);
    }

    /// valueOf() - Return primitive value
    pub fn valueOf(self: Self) f64 {
        return self.value;
    }

    // ===== Arithmetic Operations =====

    /// Add two numbers
    pub fn add(self: Self, other: Self) Self {
        return Self.init(self.allocator, self.value + other.value);
    }

    /// Subtract two numbers
    pub fn subtract(self: Self, other: Self) Self {
        return Self.init(self.allocator, self.value - other.value);
    }

    /// Multiply two numbers
    pub fn multiply(self: Self, other: Self) Self {
        return Self.init(self.allocator, self.value * other.value);
    }

    /// IEEE 754 division, including signed zeros and NaN.
    pub fn divide(self: Self, other: Self) Self {
        return Self.init(self.allocator, self.value / other.value);
    }

    /// Number::remainder: sign follows the dividend; unlike mathematical modulo.
    pub fn modulo(self: Self, other: Self) Self {
        const x = self.value;
        const y = other.value;
        if (isNaN(x) or isNaN(y) or std.math.isInf(x) or y == 0) {
            return Self.init(self.allocator, Constants.NaN);
        }
        if (std.math.isInf(y) or x == 0) return self;
        return Self.init(self.allocator, @rem(x, y));
    }

    /// Number::exponentiate. The remaining finite result is implementation-approximated.
    pub fn power(self: Self, exponent: f64) Self {
        const x = self.value;
        if (isNaN(exponent)) return Self.init(self.allocator, Constants.NaN);
        if (exponent == 0) return Self.init(self.allocator, 1);
        if (isNaN(x)) return Self.init(self.allocator, Constants.NaN);
        const magnitude = @abs(x);
        const odd = std.math.isFinite(exponent) and @mod(@abs(exponent), 2) == 1;
        const negative = (@as(u64, @bitCast(x)) >> 63) != 0 and odd;
        if (std.math.isInf(x) or x == 0) {
            const infinite = (std.math.isInf(x) and exponent > 0) or (x == 0 and exponent < 0);
            const result: f64 = if (infinite) Constants.POSITIVE_INFINITY else 0;
            return Self.init(self.allocator, if (negative) -result else result);
        }
        if (std.math.isInf(exponent)) {
            if (magnitude == 1) return Self.init(self.allocator, Constants.NaN);
            const infinite = (magnitude > 1) == (exponent > 0);
            return Self.init(self.allocator, if (infinite) Constants.POSITIVE_INFINITY else 0);
        }
        if (x < 0 and @trunc(exponent) != exponent) return Self.init(self.allocator, Constants.NaN);
        const result = std.math.pow(f64, magnitude, exponent);
        return Self.init(self.allocator, if (negative) -result else result);
    }

    /// Unary minus, preserving IEEE 754 signed-zero behavior.
    pub fn negate(self: Self) Self {
        return Self.init(self.allocator, -self.value);
    }

    /// JavaScript `~`: complement after ToInt32, returned as a Number.
    pub fn bitwiseNot(self: Self) Self {
        return Self.init(self.allocator, @floatFromInt(~self.toI32()));
    }

    /// JavaScript `&`: convert both operands with ToInt32.
    pub fn bitwiseAnd(self: Self, other: Self) Self {
        return Self.init(self.allocator, @floatFromInt(self.toI32() & other.toI32()));
    }

    /// JavaScript `|`: convert both operands with ToInt32.
    pub fn bitwiseOr(self: Self, other: Self) Self {
        return Self.init(self.allocator, @floatFromInt(self.toI32() | other.toI32()));
    }

    /// JavaScript `^`: convert both operands with ToInt32.
    pub fn bitwiseXor(self: Self, other: Self) Self {
        return Self.init(self.allocator, @floatFromInt(self.toI32() ^ other.toI32()));
    }

    /// JavaScript `<<`: signed 32-bit result, shift count modulo 32.
    pub fn shiftLeft(self: Self, other: Self) Self {
        const shift: u5 = @intCast(other.toU32() & 31);
        const result: i32 = @bitCast(self.toU32() << shift);
        return Self.init(self.allocator, @floatFromInt(result));
    }

    /// JavaScript `>>`: sign-extending shift, count modulo 32.
    pub fn shiftRight(self: Self, other: Self) Self {
        const shift: u5 = @intCast(other.toU32() & 31);
        return Self.init(self.allocator, @floatFromInt(self.toI32() >> shift));
    }

    /// JavaScript `>>>`: zero-filling shift, count modulo 32, unsigned result.
    pub fn shiftRightUnsigned(self: Self, other: Self) Self {
        const shift: u5 = @intCast(other.toU32() & 31);
        return Self.init(self.allocator, @floatFromInt(self.toU32() >> shift));
    }

    /// Absolute value
    pub fn abs(self: Self) Self {
        return Self.init(self.allocator, @abs(self.value));
    }

    /// Square root
    pub fn sqrt(self: Self) Self {
        return Self.init(self.allocator, std.math.sqrt(self.value));
    }

    // ===== Comparison Operations =====

    /// Check equality (Note: NaN != NaN)
    pub fn equals(self: Self, other: Self) bool {
        if (isNaN(self.value) or isNaN(other.value)) {
            return false;
        }
        return self.value == other.value;
    }

    /// Less than comparison
    pub fn lessThan(self: Self, other: Self) bool {
        return self.value < other.value;
    }

    /// Greater than comparison
    pub fn greaterThan(self: Self, other: Self) bool {
        return self.value > other.value;
    }

    /// Three-way comparison; NaN operands are unordered (null).
    pub fn compare(self: Self, other: Self) ?std.math.Order {
        if (isNaN(self.value) or isNaN(other.value)) return null;
        if (self.value < other.value) return .lt;
        if (self.value > other.value) return .gt;
        return .eq;
    }

    /// Object.is semantics: NaNs are equal and signed zeros are distinct.
    pub fn sameValue(self: Self, other: Self) bool {
        if (isNaN(self.value) and isNaN(other.value)) return true;
        return @as(u64, @bitCast(self.value)) == @as(u64, @bitCast(other.value));
    }

    /// SameValueZero: NaNs are equal and both zeros are equal.
    pub fn sameValueZero(self: Self, other: Self) bool {
        return self.value == other.value or (isNaN(self.value) and isNaN(other.value));
    }

    /// Complete UTF-8 StringNumericLiteral conversion (Number(string)).
    /// Empty/whitespace yields +0, invalid input yields NaN. Nondecimal
    /// literals may return error.OutOfMemory.
    pub fn stringToNumber(allocator: Allocator, str: []const u8) !f64 {
        return ParsingMethods.stringToNumber(allocator, str);
    }

    /// ToIndex: truncate `value` (null means omitted) and require 0...2^53-1.
    /// Returns error.RangeError for a resulting negative or excessive index.
    pub fn toIndex(value: ?f64) !u64 {
        return ConversionMethods.toIndex(value);
    }

    // ===== Conversion Methods =====

    /// Checked truncation to i64: InvalidNumber for NaN/Infinity, Overflow
    /// at >=2^63, Underflow below -2^63.
    pub fn toInt(self: Self) !i64 {
        return ConversionMethods.toInt(self.value);
    }

    /// Checked truncation to u64: InvalidNumber for NaN/Infinity, Underflow
    /// for negative inputs, Overflow at >=2^64.
    pub fn toUint(self: Self) !u64 {
        return ConversionMethods.toUint(self.value);
    }

    /// ToInt32(value) - never throws, wraps like JS `value | 0`
    pub fn toI32(self: Self) i32 {
        return ConversionMethods.toI32(self.value);
    }

    /// ToUint32(value) - never throws, wraps like JS `value >>> 0`
    pub fn toU32(self: Self) u32 {
        return ConversionMethods.toU32(self.value);
    }

    /// ToInt8(value) - Int8Array element coercion, never throws
    pub fn toI8(self: Self) i8 {
        return ConversionMethods.toI8(self.value);
    }

    /// ToUint8(value) - Uint8Array element coercion, never throws
    pub fn toU8(self: Self) u8 {
        return ConversionMethods.toU8(self.value);
    }

    /// ToInt16(value) - Int16Array element coercion, never throws
    pub fn toI16(self: Self) i16 {
        return ConversionMethods.toI16(self.value);
    }

    /// ToUint16(value) - Uint16Array element coercion, never throws
    pub fn toU16(self: Self) u16 {
        return ConversionMethods.toU16(self.value);
    }

    /// ToUint8Clamp(value) - Uint8ClampedArray element coercion (saturating,
    /// round-half-to-even), never throws
    pub fn toUint8Clamp(self: Self) u8 {
        return ConversionMethods.toUint8Clamp(self.value);
    }

    /// ToIntegerOrInfinity(value), never throws
    pub fn toIntegerOrInfinity(self: Self) f64 {
        return ConversionMethods.toIntegerOrInfinity(self.value);
    }

    /// ToLength(value), never throws
    pub fn toLength(self: Self) f64 {
        return ConversionMethods.toLength(self.value);
    }

    /// Convert to bytes (IEEE 754, native byte order)
    pub fn toBytes(self: Self) [8]u8 {
        return ConversionMethods.toBytes(self.value);
    }

    /// Create from bytes (IEEE 754, native byte order)
    pub fn fromBytes(allocator: Allocator, bytes: [8]u8) Self {
        return Self.init(allocator, ConversionMethods.fromBytes(bytes));
    }
};

// Run tests when testing
test "ZNumber basic initialization" {
    const allocator = std.testing.allocator;
    const num = ZNumber.init(allocator, 42.0);
    try std.testing.expectEqual(@as(f64, 42.0), num.value);
}
