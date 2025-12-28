const std = @import("std");
const Constants = @import("constants.zig").Constants;
const ZNumberError = @import("errors.zig").ZNumberError;

/// Formatting methods for converting numbers to strings
/// These methods match ECMAScript Number instance methods
pub const FormattingMethods = struct {
    /// Format to exponential notation
    /// Returns a string representing the number in exponential notation
    /// Labeled block example 1
    pub fn toExponential(
        value: f64,
        allocator: std.mem.Allocator,
        fraction_digits: ?usize,
    ) ![]u8 {
        formatter: {
            // Validate fraction_digits (0-100)
            if (fraction_digits) |fd| {
                if (fd > 100) {
                    return ZNumberError.RangeError;
                }
            }

            // Handle special values
            if (std.math.isNan(value)) {
                return try allocator.dupe(u8, "NaN");
            }

            if (std.math.isInf(value)) {
                if (value > 0) {
                    return try allocator.dupe(u8, "Infinity");
                } else {
                    return try allocator.dupe(u8, "-Infinity");
                }
            }

            break :formatter;
        }

        // Format number in exponential notation
        // TODO: Use fraction_digits for precision formatting

        // Calculate exponent
        var abs_value = @abs(value);
        var exponent: i32 = 0;

        if (abs_value != 0.0) {
            exponent = @as(i32, @intFromFloat(@floor(std.math.log10(abs_value))));
            abs_value = abs_value / std.math.pow(f64, 10.0, @as(f64, @floatFromInt(exponent)));
        }

        // Format mantissa (manual because Zig doesn't support runtime precision in format strings)
        const mantissa = if (value < 0) -abs_value else abs_value;
        const exp_sign = if (exponent >= 0) "+" else "";

        return try std.fmt.allocPrint(
            allocator,
            "{d}e{s}{d}",
            .{ mantissa, exp_sign, exponent },
        );
    }

    /// Format to fixed-point notation
    /// Returns a string with a specified number of decimal places
    /// Labeled block example 2
    pub fn toFixed(
        value: f64,
        allocator: std.mem.Allocator,
        fraction_digits: ?usize,
    ) ![]u8 {
        fixed_formatter: {
            const digits = fraction_digits orelse 0;

            // Validate range (0-100)
            if (digits > 100) {
                return ZNumberError.RangeError;
            }

            // Handle special values
            if (std.math.isNan(value)) {
                return try allocator.dupe(u8, "NaN");
            }

            if (std.math.isInf(value)) {
                if (value > 0) {
                    return try allocator.dupe(u8, "Infinity");
                } else {
                    return try allocator.dupe(u8, "-Infinity");
                }
            }

            break :fixed_formatter;
        }

        // Format with fixed decimals
        const digits = fraction_digits orelse 0;
        // Manually format since Zig doesn't support runtime precision
        if (digits == 0) {
            return try std.fmt.allocPrint(allocator, "{d:.0}", .{value});
        } else if (digits == 1) {
            return try std.fmt.allocPrint(allocator, "{d:.1}", .{value});
        } else if (digits == 2) {
            return try std.fmt.allocPrint(allocator, "{d:.2}", .{value});
        } else {
            // For larger digit counts, just use default formatting
            return try std.fmt.allocPrint(allocator, "{d}", .{value});
        }
    }

    /// Format to precision notation
    /// Returns a string with a specified precision
    pub fn toPrecision(
        value: f64,
        allocator: std.mem.Allocator,
        precision: ?usize,
    ) ![]u8 {
        precision_formatter: {
            // If precision is not specified, use toString
            if (precision == null) {
                return toString(value, allocator, null);
            }

            const prec = precision.?;

            // Validate precision (1-100)
            if (prec < 1 or prec > 100) {
                return ZNumberError.RangeError;
            }

            // Handle special values
            if (std.math.isNan(value)) {
                return try allocator.dupe(u8, "NaN");
            }

            if (std.math.isInf(value)) {
                if (value > 0) {
                    return try allocator.dupe(u8, "Infinity");
                } else {
                    return try allocator.dupe(u8, "-Infinity");
                }
            }

            break :precision_formatter;
        }

        const prec = precision.?;

        // Determine if we should use exponential or fixed notation
        const abs_value = @abs(value);

        if (abs_value == 0.0) {
            return toFixed(value, allocator, if (prec > 0) prec - 1 else 0);
        }

        const exponent = @floor(std.math.log10(abs_value));

        if (exponent < -6 or exponent >= @as(f64, @floatFromInt(prec))) {
            // Use exponential notation
            return toExponential(value, allocator, prec - 1);
        } else {
            // Use fixed notation
            const decimals = prec - @as(usize, @intFromFloat(exponent)) - 1;
            return toFixed(value, allocator, decimals);
        }
    }

    /// Convert to string with radix
    /// Returns a string representation in the specified base
    /// Labeled block example 3
    pub fn toString(
        value: f64,
        allocator: std.mem.Allocator,
        radix: ?u8,
    ) ![]u8 {
        string_converter: {
            const base = radix orelse 10;

            // Validate radix (2-36)
            if (base < 2 or base > 36) {
                return ZNumberError.RangeError;
            }

            // Handle special values
            if (std.math.isNan(value)) {
                return try allocator.dupe(u8, "NaN");
            }

            if (std.math.isInf(value)) {
                if (value > 0) {
                    return try allocator.dupe(u8, "Infinity");
                } else {
                    return try allocator.dupe(u8, "-Infinity");
                }
            }

            // For non-base 10, must be integer
            if (base != 10) {
                const int_value = @as(i64, @intFromFloat(value));
                if (@as(f64, @floatFromInt(int_value)) != value) {
                    return ZNumberError.InvalidRadixConversion;
                }
            }

            break :string_converter;
        }

        const base = radix orelse 10;

        // Convert to string with radix
        if (base == 10) {
            return try std.fmt.allocPrint(allocator, "{d}", .{value});
        } else {
            const int_value = @as(i64, @intFromFloat(value));
            // Format with common radices
            if (base == 16) {
                return try std.fmt.allocPrint(allocator, "{x}", .{int_value});
            } else if (base == 2) {
                return try std.fmt.allocPrint(allocator, "{b}", .{int_value});
            } else if (base == 8) {
                return try std.fmt.allocPrint(allocator, "{o}", .{int_value});
            } else {
                // For other bases (3-36), use custom formatting
                // Simplified: only support common bases for now
                // For full ECMAScript compatibility, would need full base-36 support
                return try std.fmt.allocPrint(allocator, "{d}", .{int_value});
            }
        }
    }

    /// Convert to locale string (simplified version)
    pub fn toLocaleString(
        value: f64,
        allocator: std.mem.Allocator,
        locale: ?[]const u8,
    ) ![]u8 {
        // Simplified implementation - just returns standard string
        _ = locale;
        return toString(value, allocator, null);
    }
};
