const std = @import("std");
const Constants = @import("constants.zig").Constants;
const ZNumberError = @import("errors.zig").ZNumberError;

/// Parsing methods for converting strings to numbers
/// These methods match ECMAScript Number.parseFloat and Number.parseInt
pub const ParsingMethods = struct {
    /// Number.parseFloat() - Parse string to float
    /// Parses a string and returns a floating point number
    /// Labeled block example 4
    pub fn parseFloat(str: []const u8) f64 {
        parser: {
            // Trim whitespace
            const trimmed = std.mem.trim(u8, str, &std.ascii.whitespace);

            if (trimmed.len == 0) {
                return Constants.NaN;
            }

            // Check for special values
            if (std.mem.eql(u8, trimmed, "NaN")) {
                return Constants.NaN;
            }

            if (std.mem.eql(u8, trimmed, "Infinity") or
                std.mem.eql(u8, trimmed, "+Infinity"))
            {
                return Constants.POSITIVE_INFINITY;
            }

            if (std.mem.eql(u8, trimmed, "-Infinity")) {
                return Constants.NEGATIVE_INFINITY;
            }

            break :parser;
        }

        // Parse numeric value
        const result = std.fmt.parseFloat(f64, std.mem.trim(u8, str, &std.ascii.whitespace)) catch {
            return Constants.NaN;
        };

        return result;
    }

    /// Number.parseInt() - Parse string to integer
    /// Parses a string and returns an integer based on the specified radix
    /// Labeled block example 5
    pub fn parseInt(str: []const u8, radix: ?u8) !i64 {
        var base: u8 = undefined;
        var trimmed: []const u8 = undefined;
        var is_negative = false;

        int_parser: {
            trimmed = std.mem.trim(u8, str, &std.ascii.whitespace);

            if (trimmed.len == 0) {
                return ZNumberError.InvalidNumber;
            }

            // Store whether radix was specified
            const radix_specified = radix != null;
            base = radix orelse 10;

            // Validate radix
            if (radix_specified and (base < 2 or base > 36)) {
                return ZNumberError.InvalidRadix;
            }

            // Handle sign
            if (trimmed[0] == '-') {
                is_negative = true;
                trimmed = trimmed[1..];
            } else if (trimmed[0] == '+') {
                trimmed = trimmed[1..];
            }

            if (trimmed.len == 0) {
                return ZNumberError.InvalidNumber;
            }

            // Auto-detect radix if not specified
            if (!radix_specified and trimmed.len >= 2) {
                if ((trimmed[0] == '0') and (trimmed[1] == 'x' or trimmed[1] == 'X')) {
                    // Hexadecimal
                    trimmed = trimmed[2..];
                    base = 16;
                } else if ((trimmed[0] == '0') and (trimmed[1] == 'o' or trimmed[1] == 'O')) {
                    // Octal
                    trimmed = trimmed[2..];
                    base = 8;
                } else if ((trimmed[0] == '0') and (trimmed[1] == 'b' or trimmed[1] == 'B')) {
                    // Binary
                    trimmed = trimmed[2..];
                    base = 2;
                }
            }

            if (trimmed.len == 0) {
                return ZNumberError.InvalidNumber;
            }

            break :int_parser;
        }

        // Parse integer with radix
        const result = std.fmt.parseInt(i64, trimmed, base) catch |err| {
            switch (err) {
                error.Overflow => return ZNumberError.Overflow,
                error.InvalidCharacter => return ZNumberError.ParseError,
            }
        };

        return if (is_negative) -result else result;
    }

    /// Parse hexadecimal string
    pub fn parseHex(str: []const u8) !i64 {
        return parseInt(str, 16);
    }

    /// Parse octal string
    pub fn parseOctal(str: []const u8) !i64 {
        return parseInt(str, 8);
    }

    /// Parse binary string
    pub fn parseBinary(str: []const u8) !i64 {
        return parseInt(str, 2);
    }
};
