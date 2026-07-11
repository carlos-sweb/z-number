// AUTO-GENERATED from real Node.js (V8) output. Do not hand-edit.
const std = @import("std");
const znumber = @import("znumber");
const ParsingMethods = znumber.ParsingMethods;

test "parseFloat() vectors (against real V8 output)" {
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x40091eb851eb851f))), ParsingMethods.parseFloat("3.14"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4045000000000000))), ParsingMethods.parseFloat("  42  "));
    try std.testing.expectEqual(std.math.inf(f64), ParsingMethods.parseFloat("Infinity"));
    try std.testing.expectEqual(std.math.inf(f64), ParsingMethods.parseFloat("+Infinity"));
    try std.testing.expectEqual(-std.math.inf(f64), ParsingMethods.parseFloat("-Infinity"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x40091eb851eb851f))), ParsingMethods.parseFloat("3.14abc"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x3fe0000000000000))), ParsingMethods.parseFloat(".5"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4014000000000000))), ParsingMethods.parseFloat("5."));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4049000000000000))), ParsingMethods.parseFloat("+.5e2"));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("")));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("   ")));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("abc")));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4202a05f20000000))), ParsingMethods.parseFloat("1e10"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0xbddb7cdfd9d7bdbb))), ParsingMethods.parseFloat("-1e-10"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x3ff0000000000000))), ParsingMethods.parseFloat("1."));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("NaN")));
    try std.testing.expectEqual(-@as(f64, 0.0), ParsingMethods.parseFloat("  -0  "));
    try std.testing.expectEqual(std.math.inf(f64), ParsingMethods.parseFloat("1e400"));
    try std.testing.expectEqual(-std.math.inf(f64), ParsingMethods.parseFloat("-1e400"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x0000000000000000))), ParsingMethods.parseFloat("0x1F"));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat(".e5")));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4014000000000000))), ParsingMethods.parseFloat("5e"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4014000000000000))), ParsingMethods.parseFloat("5e+"));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("inf")));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("  .  ")));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x401c000000000000))), ParsingMethods.parseFloat("007"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x40091eb851eb851f))), ParsingMethods.parseFloat("3.14  extra"));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("   +  5")));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4016000000000000))), ParsingMethods.parseFloat("5.5.5"));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseFloat("e5")));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x3ff0000000000000))), ParsingMethods.parseFloat("1e"));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x3ff3333333333333))), ParsingMethods.parseFloat("1.2.3"));
}

test "parseInt() vectors (against real V8 output)" {
    const a = std.testing.allocator;
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x403f000000000000))), ParsingMethods.parseInt(a, "  0x1F  ", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x3ff0000000000000))), ParsingMethods.parseInt(a, "19", 2));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x0000000000000000))), ParsingMethods.parseInt(a, "0o17", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x0000000000000000))), ParsingMethods.parseInt(a, "0b11", null));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "Infinity", null)));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0xc045000000000000))), ParsingMethods.parseInt(a, "   -42abc", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x44ea784379d99db4))), ParsingMethods.parseInt(a, "999999999999999999999999", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4045000000000000))), ParsingMethods.parseInt(a, "42abc", 10));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "", null)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "   ", null)));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x403f000000000000))), ParsingMethods.parseInt(a, "0x1F", 16));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x406fe00000000000))), ParsingMethods.parseInt(a, "ff", 16));
    try std.testing.expectEqual(-@as(f64, 0.0), ParsingMethods.parseInt(a, "-0", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4041800000000000))), ParsingMethods.parseInt(a, "z", 36));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "42", 1)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "42", 37)));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4045000000000000))), ParsingMethods.parseInt(a, "  +42  ", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0xc06fe00000000000))), ParsingMethods.parseInt(a, "-FF", 16));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4065600000000000))), ParsingMethods.parseInt(a, "0XAB", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x43d070872e384000))), ParsingMethods.parseInt(a, "zzzzzzzzzzzz", 36));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x405ec00000000000))), ParsingMethods.parseInt(a, "123", 0));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "0x", null)));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0xc03f000000000000))), ParsingMethods.parseInt(a, "-0x1F", null));
    try std.testing.expectEqual(@as(f64, @bitCast(@as(u64, 0x4008000000000000))), ParsingMethods.parseInt(a, "3.99", 10));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "   ", 10)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "+", 10)));
    try std.testing.expect(std.math.isNan(ParsingMethods.parseInt(a, "-", 16)));
}

