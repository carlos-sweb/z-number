const std = @import("std");
const ZNumber = @import("znumber").ZNumber;
const Constants = @import("znumber").Constants;

pub fn main() !void {
    var gpa : std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Create numbers
    const num1 = ZNumber.init(allocator, 42.5);
    const num2 = ZNumber.fromInt(allocator, 100);

    // Arithmetic
    const sum = num1.add(num2);
    std.debug.print("Sum: {d}\n", .{sum.value}); // 142.5

    // Formatting
    const fixed = try num1.toFixed(2);
    defer allocator.free(fixed);
    std.debug.print("Fixed: {s}\n", .{fixed}); // "42.50"

    // Parsing
    const parsed = ZNumber.parseFloat("3.14");
    std.debug.print("Parsed: {d}\n", .{parsed}); // 3.14
}
