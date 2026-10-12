const std = @import("std");
const z = @import("znumber");
const a = std.testing.allocator;
fn checkNumber(expected: []const u8, actual: f64) !void {
    if (std.mem.eql(u8, expected, "nan")) return std.testing.expect(std.math.isNan(actual));
    try std.testing.expectEqual(try std.fmt.parseInt(u64, expected, 16), @as(u64, @bitCast(actual)));
}

test "10000 deterministic binary64 patterns against recorded Node results" {
    var lines = std.mem.tokenizeScalar(u8, @embedFile("data/conformance.tsv"), '\n');
    var count: usize = 0;
    while (lines.next()) |line| {
        var fields = std.mem.splitScalar(u8, line, '\t');
        const xb = try std.fmt.parseInt(u64, fields.next().?, 16);
        const yb = try std.fmt.parseInt(u64, fields.next().?, 16);
        const x: f64 = @bitCast(xb);
        const y: f64 = @bitCast(yb);
        const digits = try std.fmt.parseFloat(f64, fields.next().?);
        const precision = try std.fmt.parseFloat(f64, fields.next().?);
        const nx = z.ZNumber.init(a, x);
        const ny = z.ZNumber.init(a, y);
        const numeric = [_]f64{
            nx.add(ny).value,         nx.subtract(ny).value,    nx.multiply(ny).value,           nx.divide(ny).value,       nx.modulo(ny).value,
            nx.negate().value,        nx.bitwiseNot().value,    nx.bitwiseAnd(ny).value,         nx.bitwiseOr(ny).value,    nx.bitwiseXor(ny).value,
            nx.shiftLeft(ny).value,   nx.shiftRight(ny).value,  nx.shiftRightUnsigned(ny).value, @floatFromInt(nx.toI32()), @floatFromInt(nx.toU32()),
            @floatFromInt(nx.toI8()), @floatFromInt(nx.toU8()), @floatFromInt(nx.toI16()),       @floatFromInt(nx.toU16()), @floatFromInt(nx.toUint8Clamp()),
            nx.toIntegerOrInfinity(), nx.toLength(),
        };
        for (numeric, 0..) |actual, op| {
            checkNumber(fields.next().?, actual) catch |err| {
                std.debug.print("\npattern {d}, x={x}, y={x}, numeric operation {d}\n", .{ count, xb, yb, op });
                return err;
            };
        }
        const boolean = [_]bool{ nx.equals(ny), nx.lessThan(ny), nx.greaterThan(ny), nx.sameValue(ny), nx.sameValueZero(ny), z.ZNumber.isFinite(x), z.ZNumber.isInteger(x), z.ZNumber.isNaN(x), z.ZNumber.isSafeInteger(x) };
        for (boolean) |actual| try std.testing.expectEqual(fields.next().?[0] == '1', actual);
        // Construct and release one result at a time, including when an assertion fails.
        for (0..5) |op| {
            const expected = fields.next().?;
            const text = try switch (op) {
                0 => nx.toString(null),
                1 => nx.toFixed(digits),
                2 => nx.toExponential(digits),
                3 => nx.toPrecision(precision),
                4 => nx.toExponential(null),
                else => unreachable,
            };
            defer a.free(text);
            std.testing.expectEqualStrings(expected, text) catch |err| {
                std.debug.print("\npattern {d}, x={x}, formatting operation {d}\n", .{ count, xb, op });
                return err;
            };
            if (op == 0) {
                const restored = try z.ParsingMethods.stringToNumber(a, text);
                if (std.math.isNan(x)) try std.testing.expect(std.math.isNan(restored)) else try std.testing.expectEqual(@as(u64, @bitCast(if (x == 0) @as(f64, 0) else x)), @as(u64, @bitCast(restored)));
                const parsed = z.ParsingMethods.parseFloat(text);
                if (std.math.isNan(x)) try std.testing.expect(std.math.isNan(parsed)) else try std.testing.expectEqual(@as(u64, @bitCast(if (x == 0) @as(f64, 0) else x)), @as(u64, @bitCast(parsed)));
            }
        }
        try std.testing.expect(fields.next() == null);
        count += 1;
    }
    try std.testing.expectEqual(@as(usize, 10000), count);
}

test "long string parsing corpus with exact BigInt integer oracle" {
    var lines = std.mem.tokenizeScalar(u8, @embedFile("data/parsing-conformance.tsv"), '\n');
    var count: usize = 0;
    while (lines.next()) |line| {
        var fields = std.mem.splitScalar(u8, line, '\t');
        const op = fields.next().?;
        const encoded = fields.next().?;
        const radix = fields.next().?;
        const expected = fields.next().?;
        const input = try a.alloc(u8, encoded.len / 2);
        defer a.free(input);
        _ = try std.fmt.hexToBytes(input, encoded);
        const actual = if (std.mem.eql(u8, op, "number")) try z.ParsingMethods.stringToNumber(a, input) else if (std.mem.eql(u8, op, "parseFloat")) z.ParsingMethods.parseFloat(input) else try z.ParsingMethods.parseInt(a, input, @bitCast(try std.fmt.parseInt(u64, radix, 16)));
        checkNumber(expected, actual) catch |err| {
            std.debug.print("\nparsing case {d}, operation {s}\n", .{ count, op });
            return err;
        };
        count += 1;
    }
    try std.testing.expect(count >= 3000);
}
