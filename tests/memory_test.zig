const std = @import("std");
const z = @import("znumber");
const F = z.FormattingMethods;
const A = std.mem.Allocator;
const Case = struct { name: []const u8, op: enum { string, fixed, exp, precision, parse, full, from_string, locale }, value: f64 = 0, arg: ?usize = null, input: []const u8 = "" };
const cases = [_]Case{
    .{ .name = "StringToNumber(hex)", .op = .full, .input = "0xffffffffffffffffffffffffffffffffffffffffffffffffffff" },
    .{ .name = "fromString(hex)", .op = .from_string, .input = "0xffffffffffffffffffffffffffffffffffffffffffffffffffff" },
    .{ .name = "toLocaleString", .op = .locale, .value = -1234.567 },
    .{ .name = "precision carry", .op = .precision, .value = 9.99, .arg = 2 },
    .{ .name = "fixed carry", .op = .fixed, .value = -9.99, .arg = 1 },
    .{ .name = "toString(42.5)", .op = .string, .value = 42.5 },
    .{ .name = "toString(pi)", .op = .string, .value = std.math.pi },
    .{ .name = "toString(min_subnormal)", .op = .string, .value = @bitCast(@as(u64, 1)) },
    .{ .name = "toString(max_f64,2)", .op = .string, .value = std.math.floatMax(f64), .arg = 2 },
    .{ .name = "toString(0.1,16)", .op = .string, .value = 0.1, .arg = 16 },
    .{ .name = "toString(NaN)", .op = .string, .value = std.math.nan(f64) },
    .{ .name = "toFixed(1234.5678,2)", .op = .fixed, .value = 1234.5678, .arg = 2 },
    .{ .name = "toFixed(0.001,100)", .op = .fixed, .value = 0.001, .arg = 100 },
    .{ .name = "toFixed(0,100)", .op = .fixed, .value = 0, .arg = 100 },
    .{ .name = "toExponential(pi,100)", .op = .exp, .value = std.math.pi, .arg = 100 },
    .{ .name = "toExponential(0,100)", .op = .exp, .value = 0, .arg = 100 },
    .{ .name = "toPrecision(pi,100)", .op = .precision, .value = std.math.pi, .arg = 100 },
    .{ .name = "toPrecision(0,100)", .op = .precision, .value = 0, .arg = 100 },
    .{ .name = "parseInt(42)", .op = .parse, .input = "42" },
    .{ .name = "parseInt(100_digits)", .op = .parse, .input = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456" },
};
fn exercise(a: A, c: Case) !void {
    if (c.op == .full) {
        const v = try z.ParsingMethods.stringToNumber(a, c.input);
        std.mem.doNotOptimizeAway(v);
        return;
    }
    if (c.op == .from_string) {
        const v = try z.ZNumber.fromString(a, c.input);
        std.mem.doNotOptimizeAway(v);
        return;
    }
    if (c.op == .parse) {
        const v = try z.ParsingMethods.parseInt(a, c.input, null);
        std.mem.doNotOptimizeAway(v);
        return;
    }
    const s = try switch (c.op) {
        .string => F.toString(c.value, a, if (c.arg) |v| @floatFromInt(v) else null),
        .fixed => F.toFixed(c.value, a, if (c.arg) |v| @floatFromInt(v) else null),
        .exp => F.toExponential(c.value, a, if (c.arg) |v| @floatFromInt(v) else null),
        .precision => F.toPrecision(c.value, a, if (c.arg) |v| @floatFromInt(v) else null),
        .locale => F.toLocaleString(c.value, a, "es-CL"),
        .parse, .full, .from_string => unreachable,
    };
    a.free(s);
}
test "allocation profile and failure cleanup" {
    var injections: usize = 0;
    for (cases) |c| {
        // SafeAllocator resizing depends on allocation placement. Deny resizing for
        // checkAllAllocationFailures so its baseline allocation count is reproducible.
        // The separate sweep below also exercises the normal resizing allocator.
        var stable = std.testing.FailingAllocator.init(std.testing.allocator, .{ .resize_fail_index = 0 });
        std.testing.checkAllAllocationFailures(stable.allocator(), exercise, .{c}) catch |err| {
            std.debug.print("\n{s}: {s}\n", .{ c.name, @errorName(err) });
            return err;
        };
        try std.testing.expectEqual(stable.allocated_bytes, stable.freed_bytes);
        var fa = std.testing.FailingAllocator.init(std.testing.allocator, .{});
        try exercise(fa.allocator(), c);
        try std.testing.expectEqual(fa.allocated_bytes, fa.freed_bytes);
        for (0..fa.allocations + 1) |idx| {
            var failing = std.testing.FailingAllocator.init(std.testing.allocator, .{ .fail_index = idx });
            if (exercise(failing.allocator(), c)) |_| {
                try std.testing.expect(!failing.has_induced_failure);
            } else |err| try std.testing.expectEqual(error.OutOfMemory, err);
            try std.testing.expectEqual(failing.allocated_bytes, failing.freed_bytes);
            if (failing.has_induced_failure) injections += 1;
        }
        var no_resize = std.testing.FailingAllocator.init(std.testing.allocator, .{ .resize_fail_index = 0 });
        try exercise(no_resize.allocator(), c);
        try std.testing.expectEqual(no_resize.allocated_bytes, no_resize.freed_bytes);
        for (0..no_resize.allocations + 1) |idx| {
            var failing = std.testing.FailingAllocator.init(std.testing.allocator, .{ .fail_index = idx, .resize_fail_index = 0 });
            if (exercise(failing.allocator(), c)) |_| {
                try std.testing.expect(!failing.has_induced_failure);
            } else |err| try std.testing.expectEqual(error.OutOfMemory, err);
            try std.testing.expectEqual(failing.allocated_bytes, failing.freed_bytes);
            if (failing.has_induced_failure) injections += 1;
        }
    }
    // Counts may vary across backends and allocators; assert failures were induced
    // for every scenario, rather than fixing an incidental allocation count.
    try std.testing.expect(injections >= cases.len);
}

test "invalid syntax does not disguise allocation failure" {
    var failing = std.testing.FailingAllocator.init(std.testing.allocator, .{ .fail_index = 0 });
    const a = failing.allocator();
    try std.testing.expect(std.math.isNan(try z.ParsingMethods.parseInt(a, "bad", 10)));
    try std.testing.expect(std.math.isNan(try z.ParsingMethods.stringToNumber(a, "0xzz")));
    try std.testing.expectEqual(@as(f64, 42), try z.ParsingMethods.parseInt(a, "42", 10));
    try std.testing.expect(!failing.has_induced_failure);
    try std.testing.expectError(error.OutOfMemory, z.ParsingMethods.parseInt(a, "18446744073709551616", 10));
    try std.testing.expectError(error.OutOfMemory, z.ParsingMethods.stringToNumber(a, "0xff"));
    try std.testing.expectEqual(@as(usize, 0), failing.allocated_bytes);
}
