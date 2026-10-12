const std = @import("std");
const z = @import("znumber");
const P = z.ParsingMethods;
const a = std.testing.allocator;
fn bitsEqual(expected: f64, actual: f64) !void {
    if (std.math.isNan(expected)) return std.testing.expect(std.math.isNan(actual));
    try std.testing.expectEqual(@as(u64, @bitCast(expected)), @as(u64, @bitCast(actual)));
}
fn exactInteger(digits: []const u8, base: u8) !f64 {
    var n = try std.math.big.int.Managed.init(a);
    defer n.deinit();
    try n.setString(base, digits);
    return n.toFloat(f64, .nearest_even)[0];
}

// Generate arbitrary radix strings by exact division. Do not use big.toString:
// its power-of-two radix formatter can pad extra zero bits (e.g. 2^64 in base 8).
fn radixDigits(value: *const std.math.big.int.Managed, base: u8, uppercase: bool) ![]u8 {
    const Big = std.math.big.int.Managed;
    var n = try Big.init(a);
    defer n.deinit();
    try n.copy(value.toConst());
    var divisor = try Big.initSet(a, base);
    defer divisor.deinit();
    var q = try Big.init(a);
    defer q.deinit();
    var r = try Big.init(a);
    defer r.deinit();
    var digits = std.ArrayList(u8).empty;
    errdefer digits.deinit(a);
    if (n.toConst().eqlZero()) try digits.append(a, '0');
    while (!n.toConst().eqlZero()) {
        try q.divTrunc(&r, &n, &divisor);
        const digit = try r.toInt(u8);
        try digits.append(a, std.fmt.digitToChar(@intCast(digit), if (uppercase) .upper else .lower));
        n.swap(&q);
    }
    std.mem.reverse(u8, digits.items);
    return digits.toOwnedSlice(a);
}

test "u64 fast path is allocation-free with exact rounding in all radixes" {
    const values = [_]u64{ 0, 1, 0x1fffffffffffff, 0x20000000000000, 0x20000000000001, 0x20000000000002, 0x20000000000003, 0x20000000000004, 0x20000000000005, 0x7fffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff };
    for (2..37) |base_index| {
        const base: u8 = @intCast(base_index);
        for (values) |value| {
            var n = try std.math.big.int.Managed.initSet(a, value);
            defer n.deinit();
            const digits = try radixDigits(&n, base, false);
            defer a.free(digits);
            const input = try a.print("-000{s}!suffix", .{digits});
            defer a.free(input);
            var failing = std.testing.FailingAllocator.init(a, .{ .fail_index = 0 });
            const expected = n.toFloat(f64, .nearest_even)[0];
            try bitsEqual(expected, try P.parseInt(failing.allocator(), digits, @floatFromInt(base)));
            try bitsEqual(-expected, try P.parseInt(failing.allocator(), input, @floatFromInt(base)));
            try std.testing.expectEqual(@as(usize, 0), failing.allocations);
            try std.testing.expect(!failing.has_induced_failure);
        }
    }
}

test "u64 overflow transitions to exact bignum in all radixes" {
    const inputs = [_][]const u8{ "18446744073709551616", "18446744073709551617", "18446744073709551618", "36893488147419103231", "999999999999999999999999999999999999999999999999999999999999" };
    for (inputs) |decimal| {
        var n = try std.math.big.int.Managed.init(a);
        defer n.deinit();
        try n.setString(10, decimal);
        const expected = n.toFloat(f64, .nearest_even)[0];
        for (2..37) |base_index| {
            const base: u8 = @intCast(base_index);
            const digits = try radixDigits(&n, base, true);
            defer a.free(digits);
            const input = try a.print("\u{a0}-000{s}!suffix", .{digits});
            defer a.free(input);
            bitsEqual(expected, try P.parseInt(a, digits, @floatFromInt(base))) catch |err| {
                std.debug.print("\nbase={d} digits={s} decimal={s}\n", .{ base, digits, decimal });
                return err;
            };
            bitsEqual(-expected, try P.parseInt(a, input, @floatFromInt(base))) catch |err| {
                std.debug.print("\nnegative base={d} input={s} decimal={s}\n", .{ base, input, decimal });
                return err;
            };
            var failing = std.testing.FailingAllocator.init(a, .{ .fail_index = 0 });
            try std.testing.expectError(error.OutOfMemory, P.parseInt(failing.allocator(), digits, @floatFromInt(base)));
            try std.testing.expectEqual(@as(usize, 0), failing.allocated_bytes);
        }
    }
}

test "leading zeros do not require heap or oversized bignum capacity" {
    const input = try a.alloc(u8, 10003);
    defer a.free(input);
    @memset(input, '0');
    @memcpy(input[10000..], "42!");
    var failing = std.testing.FailingAllocator.init(a, .{ .fail_index = 0 });
    try bitsEqual(42, try P.parseInt(failing.allocator(), input, 10));
    try bitsEqual(0, try P.parseInt(failing.allocator(), input[0..10000], 10));
    try std.testing.expectEqual(@as(usize, 0), failing.allocations);

    const large = "18446744073709551616";
    const padded = try a.alloc(u8, 10000 + large.len);
    defer a.free(padded);
    @memset(padded[0..10000], '0');
    @memcpy(padded[10000..], large);
    var plain_state = std.testing.FailingAllocator.init(a, .{ .resize_fail_index = 0 });
    var padded_state = std.testing.FailingAllocator.init(a, .{ .resize_fail_index = 0 });
    try bitsEqual(0x1p64, try P.parseInt(plain_state.allocator(), large, 10));
    try bitsEqual(0x1p64, try P.parseInt(padded_state.allocator(), padded, 10));
    try std.testing.expectEqual(plain_state.allocated_bytes, padded_state.allocated_bytes);
    try std.testing.expectEqual(padded_state.allocated_bytes, padded_state.freed_bytes);
}

test "fast-path scanners preserve prefixes, Unicode and invalid UTF8 suffixes" {
    const floats = [_]struct { input: []const u8, expected: f64 }{
        .{ .input = " \t\u{a0}\u{feff}\r-0suffix", .expected = -0.0 },
        .{ .input = "\u{3000}\t+Infinitytail", .expected = std.math.inf(f64) },
        .{ .input = "-Infinity\xff", .expected = -std.math.inf(f64) },
        .{ .input = "1e+", .expected = 1 },
        .{ .input = ".5e-", .expected = 0.5 },
        .{ .input = "0x1p2", .expected = 0 },
        .{ .input = "1_2", .expected = 1 },
        .{ .input = "12.5\xff", .expected = 12.5 },
        .{ .input = "\xff42", .expected = std.math.nan(f64) },
        .{ .input = "\u{a0}\xe2\x80", .expected = std.math.nan(f64) },
        .{ .input = "Infinity", .expected = std.math.inf(f64) },
        .{ .input = "Inf", .expected = std.math.nan(f64) },
        .{ .input = "infinity", .expected = std.math.nan(f64) },
    };
    for (floats) |row| try bitsEqual(row.expected, P.parseFloat(row.input));
    var failing = std.testing.FailingAllocator.init(a, .{ .fail_index = 0 });
    try bitsEqual(-0.0, try P.parseInt(failing.allocator(), "-000tail", 10));
    try bitsEqual(15, try P.parseInt(failing.allocator(), " \u{a0}\t0x000F!", null));
    try bitsEqual(1, try P.parseInt(failing.allocator(), "19", 2));
    try bitsEqual(42, try P.parseInt(failing.allocator(), "42\xff", 10));
    for ([_][]const u8{ "0x", "0x!", "+", "-", "\xff42", "\u{a0}\xe2\x80" }) |input| {
        try std.testing.expect(std.math.isNan(try P.parseInt(failing.allocator(), input, null)));
    }
    try std.testing.expect(std.math.isNan(try P.stringToNumber(a, "Infinitytail")));
    try std.testing.expect(std.math.isNan(try P.stringToNumber(a, "1_2")));
    try std.testing.expect(std.math.isNan(try P.stringToNumber(a, "0x1p2")));
    try bitsEqual(-0.0, try P.stringToNumber(a, "-0"));
}

test "deterministic u64 rounding and decimal parser differential cases" {
    var prng = std.Random.DefaultPrng.init(0x7a6e706172736572);
    const random = prng.random();
    for (0..2000) |_| {
        const value = random.int(u64);
        var buffer: [64]u8 = undefined;
        const decimal = try std.fmt.bufPrint(&buffer, "{d}", .{value});
        try bitsEqual(try exactInteger(decimal, 10), try P.parseInt(a, decimal, 10));
        var literal: [96]u8 = undefined;
        const text = try std.fmt.bufPrint(&literal, "{s}.123456789e{d}", .{ decimal, random.intRangeAtMost(i16, -350, 350) });
        try bitsEqual(try std.fmt.parseFloat(f64, text), P.parseFloat(text));
    }
}

test "large-input probes preserve short prefixes followed by long suffixes" {
    const prefixes = [_]struct { text: []const u8, base: u8, value: f64 }{
        .{ .text = "42", .base = 10, .value = 42 },
        .{ .text = "18446744073709551615", .base = 10, .value = 0x1p64 },
        .{ .text = "101", .base = 2, .value = 5 },
        .{ .text = "FF", .base = 16, .value = 255 },
        .{ .text = "ZZ", .base = 36, .value = 1295 },
    };
    for (prefixes) |p| {
        const input = try a.alloc(u8, p.text.len + 10000);
        defer a.free(input);
        @memcpy(input[0..p.text.len], p.text);
        @memset(input[p.text.len..], '!');
        var failing = std.testing.FailingAllocator.init(a, .{ .fail_index = 0 });
        try bitsEqual(p.value, try P.parseInt(failing.allocator(), input, @floatFromInt(p.base)));
        try std.testing.expect(!failing.has_induced_failure);
    }
    try bitsEqual(0x1p64, try P.parseInt(a, "18446744073709551616!", 10));
    try bitsEqual(try exactInteger("99999999999999999999", 10), try P.parseInt(a, "99999999999999999999!", 10));
}
