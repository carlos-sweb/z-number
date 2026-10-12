// Primitive/string adaptations from the pinned sources listed in data/test262-manifest.json.
const std = @import("std");
const z = @import("znumber");
const a = std.testing.allocator;
fn decodeNumber(text: []const u8) !f64 {
    if (std.mem.eql(u8, text, "nan")) return std.math.nan(f64);
    return @bitCast(try std.fmt.parseInt(u64, text, 16));
}
test "adapted Test262 numeric and string cases" {
    var lines = std.mem.splitScalar(u8, @embedFile("data/test262.tsv"), '\n');
    var count: usize = 0;
    while (lines.next()) |line| {
        if (line.len == 0) continue;
        var fields = std.mem.splitScalar(u8, line, '\t');
        const source = fields.next().?;
        const op = fields.next().?;
        const input = fields.next().?;
        const arg_text = fields.next().?;
        const arg: ?f64 = if (std.mem.eql(u8, arg_text, "omitted")) null else try decodeNumber(arg_text);
        const expected = fields.next().?;
        if (std.mem.eql(u8, op, "number") or std.mem.eql(u8, op, "parseFloat") or std.mem.eql(u8, op, "parseInt")) {
            const bytes = try a.alloc(u8, input.len / 2);
            defer a.free(bytes);
            _ = try std.fmt.hexToBytes(bytes, input);
            const actual = if (std.mem.eql(u8, op, "number")) try z.ParsingMethods.stringToNumber(a, bytes) else if (std.mem.eql(u8, op, "parseFloat")) z.ParsingMethods.parseFloat(bytes) else try z.ParsingMethods.parseInt(a, bytes, arg);
            const value = try decodeNumber(expected);
            if (std.math.isNan(value)) try std.testing.expect(std.math.isNan(actual)) else try std.testing.expectEqual(@as(u64, @bitCast(value)), @as(u64, @bitCast(actual)));
        } else {
            const value = try decodeNumber(input);
            const text = if (std.mem.eql(u8, op, "toFixed")) try z.FormattingMethods.toFixed(value, a, arg) else if (std.mem.eql(u8, op, "toExponential")) try z.FormattingMethods.toExponential(value, a, arg) else if (std.mem.eql(u8, op, "toPrecision")) try z.FormattingMethods.toPrecision(value, a, arg) else if (std.mem.eql(u8, op, "toString")) try z.FormattingMethods.toString(value, a, arg) else return error.UnknownOperation;
            defer a.free(text);
            std.testing.expectEqualStrings(expected, text) catch |err| {
                std.debug.print("\nTest262 source {s}, operation {s}\n", .{ source, op });
                return err;
            };
        }
        count += 1;
    }
    try std.testing.expect(count >= 200);
}
