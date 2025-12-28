const std = @import("std");
const Constants = @import("constants.zig").Constants;

/// Validation methods for Number values
/// These methods match ECMAScript Number static methods
pub const ValidationMethods = struct {
    /// Number.isFinite() - Check if value is finite
    /// Returns true if value is neither NaN, Infinity, nor -Infinity
    /// Labeled block example 6
    pub fn isFinite(value: f64) bool {
        finite_checker: {
            // Check for NaN
            if (std.math.isNan(value)) {
                return false;
            }

            // Check for infinity (positive or negative)
            if (std.math.isInf(value)) {
                return false;
            }

            break :finite_checker;
        }

        return true;
    }

    /// Number.isInteger() - Check if value is an integer
    /// Returns true if value is finite and has no fractional part
    /// Labeled block example 7
    pub fn isInteger(value: f64) bool {
        integer_checker: {
            // Must be finite first
            if (!isFinite(value)) {
                return false;
            }

            // Truncate and compare
            const truncated = @trunc(value);

            if (value != truncated) {
                return false;
            }

            break :integer_checker;
        }

        return true;
    }

    /// Number.isNaN() - Check if value is NaN
    /// Returns true only if value is NaN
    /// Note: NaN is the only value that is not equal to itself
    pub fn isNaN(value: f64) bool {
        return std.math.isNan(value);
    }

    /// Number.isSafeInteger() - Check if value is a safe integer
    /// Returns true if value is an integer within the safe integer range
    /// Safe range: -(2^53 - 1) to (2^53 - 1)
    /// Labeled block example 8
    pub fn isSafeInteger(value: f64) bool {
        safety_checker: {
            // Must be an integer first
            if (!isInteger(value)) {
                return false;
            }

            // Check upper bound
            if (value > @as(f64, @floatFromInt(Constants.MAX_SAFE_INTEGER))) {
                return false;
            }

            // Check lower bound
            if (value < @as(f64, @floatFromInt(Constants.MIN_SAFE_INTEGER))) {
                return false;
            }

            break :safety_checker;
        }

        return true;
    }

    /// Validate if value is in valid range (helper method)
    pub fn isInRange(value: f64, min: f64, max: f64) bool {
        range_validator: {
            if (!isFinite(value)) {
                return false;
            }

            if (value < min or value > max) {
                return false;
            }

            break :range_validator;
        }

        return true;
    }
};
