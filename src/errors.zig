const std = @import("std");

/// Error set for ZNumber operations
pub const ZNumberError = error{
    OutOfMemory,
    InvalidNumber,
    InvalidRadix,
    RangeError,
    Overflow,
    Underflow,
    DivisionByZero,
    InvalidRadixConversion,
    ParseError,
    InvalidFormat,
    PrecisionLoss,
};

/// Context for providing detailed error information
pub const ErrorContext = struct {
    message: []const u8,
    value: ?f64 = null,

    pub fn format(
        self: ErrorContext,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;
        try writer.print("ZNumberError: {s}", .{self.message});
        if (self.value) |val| {
            try writer.print(" (value: {d})", .{val});
        }
    }
};
