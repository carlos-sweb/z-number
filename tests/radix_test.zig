// Independent exact interval verification of non-decimal shortest representations.
const std = @import("std");
const z = @import("znumber");
const Big = std.math.big.int.Managed;
const a = std.testing.allocator;

fn compareBound(s: *const Big, base: u8, exponent: i32, coefficient: u64, binary_exponent: i32) !std.math.Order {
    var left = try Big.init(a);
    defer left.deinit();
    try left.copy(s.toConst());
    var right = try Big.initSet(a, coefficient);
    defer right.deinit();
    var radix = try Big.initSet(a, base);
    defer radix.deinit();
    var scale = try Big.init(a);
    defer scale.deinit();
    try scale.pow(&radix, @intCast(@abs(exponent)));
    if (exponent >= 0) try left.mul(&left, &scale) else try right.mul(&right, &scale);
    if (binary_exponent >= 0) try right.shiftLeft(&right, @intCast(binary_exponent)) else try left.shiftLeft(&left, @intCast(-binary_exponent));
    return left.order(right);
}

fn inInterval(s: *const Big, base: u8, exponent: i32, value: f64) !bool {
    const bits: u64 = @bitCast(value);
    const raw_exp = (bits >> 52) & 0x7ff;
    const fraction = bits & 0xfffffffffffff;
    const f: u64 = fraction | (if (raw_exp == 0) @as(u64, 0) else (@as(u64, 1) << 52));
    const e: i32 = if (raw_exp == 0) -1074 else @as(i32, @intCast(raw_exp)) - 1075;
    const boundary = fraction == 0 and raw_exp > 1;
    const lower = try compareBound(s, base, exponent, if (boundary) 4 * f - 1 else 2 * f - 1, if (boundary) e - 2 else e - 1);
    const upper = try compareBound(s, base, exponent, 2 * f + 1, e - 1);
    const even = f & 1 == 0;
    return (lower == .gt or (even and lower == .eq)) and (upper == .lt or (even and upper == .eq));
}

test "all radixes satisfy exact rounding intervals and shortest significands" {
    const values = [_]f64{ @bitCast(@as(u64, 1)), @bitCast(@as(u64, 0x0010000000000000)), std.math.floatMax(f64), 0.1, std.math.pi, 1e-7, 1e21, 42.5 };
    for (2..37) |base_index| {
        const base: u8 = @intCast(base_index);
        for (values) |value| {
            const text = try z.FormattingMethods.toString(value, a, @floatFromInt(base));
            defer a.free(text);
            var digits = std.ArrayList(u8).empty;
            defer digits.deinit(a);
            var fraction_digits: i32 = 0;
            var after_point = false;
            const end = if (base == 10) (std.mem.indexOfScalar(u8, text, 'e') orelse text.len) else text.len;
            for (text[0..end]) |c| {
                if (c == '.') {
                    try std.testing.expect(!after_point);
                    after_point = true;
                } else {
                    _ = try std.fmt.charToDigit(c, base);
                    try digits.append(a, c);
                    if (after_point) fraction_digits += 1;
                }
            }
            var exponent = -fraction_digits;
            if (end < text.len) exponent += try std.fmt.parseInt(i32, text[end + 1 ..], 10);
            while (digits.items.len > 1 and digits.items[digits.items.len - 1] == '0') {
                digits.items.len -= 1;
                exponent += 1;
            }
            var significant = digits.items;
            while (significant.len > 1 and significant[0] == '0') significant = significant[1..];
            var s = try Big.init(a);
            defer s.deinit();
            try s.setString(base, significant);
            if (!try inInterval(&s, base, exponent, value)) {
                std.debug.print("\nradix {d}, value {x}, text {s}\n", .{ base, @as(u64, @bitCast(value)), text });
                return error.InvalidRoundingInterval;
            }
            if (significant.len > 1) {
                // At one fewer significant digit, neither neighboring candidate may round to x.
                try s.setString(base, significant[0 .. significant.len - 1]);
                try std.testing.expect(!try inInterval(&s, base, exponent + 1, value));
                try s.addScalar(&s, 1);
                try std.testing.expect(!try inInterval(&s, base, exponent + 1, value));
            }
            const negative = try z.FormattingMethods.toString(-value, a, @floatFromInt(base));
            defer a.free(negative);
            try std.testing.expect(negative[0] == '-');
            try std.testing.expectEqualStrings(text, negative[1..]);
        }
    }
}
