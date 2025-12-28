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
/// This structure represents a JavaScript Number value with full IEEE 754 support
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

    /// Initialize from string
    pub fn fromString(allocator: Allocator, str: []const u8) Self {
        const parsed_value = ParsingMethods.parseFloat(str);
        return .{
            .value = parsed_value,
            .allocator = allocator,
        };
    }

    /// Deinitialize (for consistency, though f64 doesn't need cleanup)
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

    /// Number.parseFloat() - Parse string to float
    pub fn parseFloat(str: []const u8) f64 {
        return ParsingMethods.parseFloat(str);
    }

    /// Number.parseInt() - Parse string to integer
    pub fn parseInt(str: []const u8, radix: ?u8) !i64 {
        return ParsingMethods.parseInt(str, radix);
    }

    // ===== Instance Methods =====

    /// toExponential() - Return string in exponential notation
    pub fn toExponential(self: Self, fraction_digits: ?usize) ![]u8 {
        return FormattingMethods.toExponential(self.value, self.allocator, fraction_digits);
    }

    /// toFixed() - Return string with fixed decimals
    pub fn toFixed(self: Self, fraction_digits: ?usize) ![]u8 {
        return FormattingMethods.toFixed(self.value, self.allocator, fraction_digits);
    }

    /// toPrecision() - Return string with specified precision
    pub fn toPrecision(self: Self, precision: ?usize) ![]u8 {
        return FormattingMethods.toPrecision(self.value, self.allocator, precision);
    }

    /// toString() - Convert to string with optional radix
    pub fn toString(self: Self, radix: ?u8) ![]u8 {
        return FormattingMethods.toString(self.value, self.allocator, radix);
    }

    /// toLocaleString() - Return locale-specific string
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

    /// Divide two numbers
    /// Labeled block example 9
    pub fn divide(self: Self, other: Self) Self {
        division: {
            // Division by zero handling
            if (other.value == 0.0) {
                if (self.value == 0.0) {
                    // 0 / 0 = NaN
                    return Self.init(self.allocator, Constants.NaN);
                } else if (self.value > 0.0) {
                    // positive / 0 = Infinity
                    return Self.init(self.allocator, Constants.POSITIVE_INFINITY);
                } else {
                    // negative / 0 = -Infinity
                    return Self.init(self.allocator, Constants.NEGATIVE_INFINITY);
                }
            }

            break :division;
        }

        return Self.init(self.allocator, self.value / other.value);
    }

    /// Modulo operation
    pub fn modulo(self: Self, other: Self) Self {
        modulo_op: {
            if (other.value == 0.0) {
                return Self.init(self.allocator, Constants.NaN);
            }

            break :modulo_op;
        }

        return Self.init(self.allocator, @mod(self.value, other.value));
    }

    /// Power operation
    /// Labeled block example 10
    pub fn power(self: Self, exponent: f64) Self {
        power_op: {
            // Handle special cases
            if (isNaN(self.value) or isNaN(exponent)) {
                return Self.init(self.allocator, Constants.NaN);
            }

            // 0^0 = 1 (by convention)
            if (self.value == 0.0 and exponent == 0.0) {
                return Self.init(self.allocator, 1.0);
            }

            // Infinity cases
            if (std.math.isInf(self.value)) {
                if (exponent == 0.0) {
                    return Self.init(self.allocator, 1.0);
                }
            }

            break :power_op;
        }

        return Self.init(self.allocator, std.math.pow(f64, self.value, exponent));
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

    /// Three-way comparison
    pub fn compare(self: Self, other: Self) std.math.Order {
        if (self.value < other.value) return .lt;
        if (self.value > other.value) return .gt;
        return .eq;
    }

    // ===== Conversion Methods =====

    /// Convert to i64
    pub fn toInt(self: Self) !i64 {
        return ConversionMethods.toInt(self.value);
    }

    /// Convert to u64
    pub fn toUint(self: Self) !u64 {
        return ConversionMethods.toUint(self.value);
    }

    /// Convert to i32
    pub fn toI32(self: Self) !i32 {
        return ConversionMethods.toI32(self.value);
    }

    /// Convert to u32
    pub fn toU32(self: Self) !u32 {
        return ConversionMethods.toU32(self.value);
    }

    /// Convert to bytes (IEEE 754)
    pub fn toBytes(self: Self) [8]u8 {
        return ConversionMethods.toBytes(self.value);
    }

    /// Create from bytes (IEEE 754)
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
