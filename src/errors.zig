const std = @import("std");

/// Error set for ZNumber operations
pub const ZNumberError = error{
    OutOfMemory,
    InvalidNumber,
    RangeError,
    Overflow,
    Underflow,
};

/// Context for providing detailed error information
pub const ErrorContext = struct {
    message: []const u8,
    value: ?f64 = null,

    /// Write the borrowed message and optional value to `writer`.
    /// Propagates error.WriteFailed from the writer; performs no allocation.
    pub fn format(self: ErrorContext, writer: *std.Io.Writer) std.Io.Writer.Error!void {
        try writer.print("ZNumberError: {s}", .{self.message});
        if (self.value) |val| {
            try writer.print(" (value: {d})", .{val});
        }
    }
};
