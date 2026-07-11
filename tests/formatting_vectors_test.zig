// AUTO-GENERATED from real Node.js (V8) output. Do not hand-edit.
// Regenerate with the node script used during the ECMAScript-compatibility audit.
const std = @import("std");
const znumber = @import("znumber");
const ZNumber = znumber.ZNumber;

test "toString(radix) vectors (against real V8 output)" {
    const a = std.testing.allocator;
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbff0000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4000000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("8", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("8", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4020000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("8", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1010", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("12", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("a", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4024000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("a", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("10000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("20", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("16", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4030000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("g", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1100100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("10201", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("144", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("64", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("2s", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("11111111", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("100110", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("377", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("255", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("ff", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x406fe00000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("73", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1111101000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("1101001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("1750", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("3e8", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f400000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("rs", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("-12", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc014000000000000)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fe0000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.456", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.5678", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3eb0c6f7a0b5ed8d)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e7ad7f29abcaf48)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e-7", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("5e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3cb0000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.220446049250313e-16", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("11111111111111111111111111111111111111111111111111111", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("1121202011211211122211100012101111", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("377777777777777777", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9007199254740991", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("1fffffffffffff", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("2gosa7pa2gv", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-11111111111111111111111111111111111111111111111111111", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(3);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1121202011211211122211100012101111", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(8);
        defer a.free(s);
        try std.testing.expectEqualStrings("-377777777777777777", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9007199254740991", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(16);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1fffffffffffff", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc33fffffffffffff)));
        const s = try num.toString(36);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2gosa7pa2gv", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4340000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9007199254740992", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4415af1d78b58c40)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("100000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159265358979", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4340000000000000)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9007199254740992", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4340000000000001)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9007199254740994", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f1a36e2eb1c432d)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4415af1d78b58c40)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("100000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x441ac53a7e04bcda)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("123456789012345680000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf89b3e7075fb4a9a)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.211395350157854e+272", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x89a89d0edb2b114a)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.908294661696854e-262", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9943b4ab1502cb40)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.661158973053939e-187", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc13743d500f31913)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1524693.0037093803", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x19f8579b726cfdde)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.432197000345281e-183", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x573e2d95c3145eb3)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.814386536795805e+112", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x508140926af4a7bb)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.392551159027731e+79", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e74affadafcfddf)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("7.706665061407686e-8", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xeda0d0fc005a4f43)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.187239842013875e+220", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe133b82f50f475b4)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.7327383701095616e+160", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1611c835cdf8887e)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.268638313188944e-202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4213e6a5e62c6106)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("21368502667.09475", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b9e1400cad2716f)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.3751572578456809e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1b05b11009db17e3)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.6728044991663883e-178", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0fcf0c70266e1150)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.562410650646945e-232", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6cc80d32c0a10b25)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.036406386469528e+216", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd97ea327ae52f0ea)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.2658116282612729e+123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9b6d16d50f774a0)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.0224369930745425e+278", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x720659b19f348009)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8629070837798737e+241", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe98155f3a4d5d9ec)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.658707251197156e+200", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe2e29518b8786a38)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.191540977390379e+168", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x12d92447fc6a328f)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("7.122266047330864e-218", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xfd4a7dd2ecfcf1ea)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.3838593922421526e+295", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2af099ca00f160ee)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("7.41188862684831e-102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb17a659844ea74fc)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.3904144479604358e-70", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x44cbc9068089e993)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.6242431824458715e+23", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0ac13e8e8f0de8c6)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("7.177957092861057e-257", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x70b3084c26ea92b1)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("7.564329971407208e+234", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe32d950f6007e4e9)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.5821179890283974e+169", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0fcbde24f5e3e043)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.4023463524154763e-232", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb493527605625e18)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.9700417597869304e-55", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9a8e50484068796b)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.131669097463256e-181", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa7e2e7e998e8f6a6)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.4994404780244895e-116", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x41b2c2b8255c070a)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("314751013.3594824", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x121faf54195ec96e)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.191367546208735e-221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xce1e43b7cb7cb0e3)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.039824830952327e+68", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf17f3433e8d2a62f)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.079789292535545e+238", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ef41ca411788094)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000019180181963674383", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2c2a0401f9e858d4)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.089843879419126e-96", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xaca6940dbac668de)));
        const s = try num.toString(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.3530170207046429e-93", s);
    }
}

test "toFixed(f) vectors (against real V8 output)" {
    const a = std.testing.allocator;
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2346", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2345600000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff3c0c1fc8f3238)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23456000000000010175", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1235", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.6", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.57", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.5678", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.5678000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1234.56780000000003383320", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.05", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0500", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0500000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fa999999999999a)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.05000000000000000278", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.01", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0060", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0060000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f789374bc6a7efa)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00600000000000000012", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0050", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0050000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0147ae147ae14)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00499999999999989342", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("10.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.9950", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.9950000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fd70a3d70a3d)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.99499999999999921840", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1500", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1500000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fc3333333333333)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.14999999999999999445", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.25", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.2500", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.2500000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fd0000000000000)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.25000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.9", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.9000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.9000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.89999999999997726263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0001000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1a36e2eb1c432d)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00010000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x444b1ae4d6e2ef50)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc44b1ae4d6e2ef50)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e+21", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.4560", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.4560000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.45600000000000306954", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc059000000000000)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-100.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.1000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3fb999999999999a)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.10000000000000000555", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1416", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1415926536", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159265358979000737", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8c6ff5302bf046d4)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46703f61721bca4f)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.0596255368222332e+31", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6117d326f5188d7f)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.233680699495995e+159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7254fba44921abb4)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.596591352589263e+242", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf6b5a67f0d368f02)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.817445349138349e+263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x46028c49e6ff560c)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8369052113387367e+29", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8be4d27324fdee66)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.0001115388", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbf1d3d3e0fe4dd03)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.00011153880402480294", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1cda130189f997dc)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdb4b01fdd5eb74a7)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.99069213229864e+131", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd486ea18317831ba)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5662377267294227e+99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xdea229bde92d4a97)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.257662423007136e+147", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4f8edfa81b092735)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7455690719015415e+75", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156.5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156.46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156.4619", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156.4619293213", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc21c80821391d904)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-30603773156.46192932128906250000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000003711", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3e98e6dc6a2d885d)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000037106574717592", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.97", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.9683", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.9682685985", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbfeefc0e6d8e8b19)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-0.96826859853567548431", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2153588f0211286e)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc48387e03b84663f)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1528928909767106e+22", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5f386e5e0c8363c7)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.998287947975437e+150", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7f8dc4fa254e0913)));
        const s = try num.toFixed(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.61310162938068e+306", s);
    }
}

test "toExponential(f) vectors (against real V8 output)" {
    const a = std.testing.allocator;
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("0e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("0e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("0e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000000000e+0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2300e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2300000000e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23000000000000000000e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2345678e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2346e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2345678000e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x40934a456d5cfaad)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.23456780000000003383e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0000e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0000000000e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00000000000000000000e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0000e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0000000000e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3f50624dd2f1a9fc)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00000000000000002082e-3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("5e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("5e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.9e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.94e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.9407e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.9406564584e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000001)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.94065645841246544177e-324", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931348623157e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.80e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7977e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.7976931349e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7fefffffffffffff)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.79769313486231570815e+308", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.007199254740991e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("9e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.0e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.01e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.0072e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.0071992547e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x433fffffffffffff)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.00719925474099100000e+15", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159265358979e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("3e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1416e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1415926536e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159265358979000737e+0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9288206290794844e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.93e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9288e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9288206291e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x69ef7f8545ec0dca)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.92882062907948444869e+202", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8582425811467542e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.86e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8582e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.8582425811e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4ef0d3e0c513cd66)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.85824258114675424327e+72", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.058836075084722e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("6e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.1e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.06e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.0588e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.0588360751e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2b553419371c0cb2)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("6.05883607508472244792e-100", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.879118801085252e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("9e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.9e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.88e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.8791e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.8791188011e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x67c8e91727acb822)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("8.87911880108525245739e+191", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.6206154000603514e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.6e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.62e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.6206e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.6206154001e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa5bcaeb63d24a6e3)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.62061540006035143561e-127", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.803086735573957e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.80e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8031e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8030867356e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x96ead1ff567fa535)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.80308673557395699145e-198", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.818242554666862e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.82e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8182e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8182425547e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf9f3df79c18b7097)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.81824255466686214234e+279", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.5976757935584925e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.6e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.60e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.5977e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.5976757936e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x5ca12c3b5de865a8)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.59767579355849253433e+138", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9450927804456508e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.95e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9451e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.9450927804e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x7af4edc60ec79260)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.94509278044565078360e+284", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.062506043992506e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("5e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.1e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.06e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.0625e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.0625060440e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6df66885bc358636)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.06250604399250580704e+221", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.831391669451814e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.8e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.83e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.8314e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.8313916695e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x929b49af8e745b78)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.83139166945181373338e-219", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5508951217665352e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.6e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.55e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5509e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5508951218e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa6706755f9c8d118)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.55089512176653520577e-123", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.5274582256518505e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.5e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.53e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.5275e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.5274582257e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9e9fbd4d4ff31316)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.52745822565185049036e-161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.713533566999507e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.7e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.71e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.7135e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.7135335670e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9fa97e1ebd36234b)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.71353356699950680170e-156", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.102379779527211e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.1e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.10e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.1024e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.1023797795e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x52b083641958634a)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.10237977952721079004e+90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.2200785596856278e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.2e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.22e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.2201e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.2200785597e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xb31413921daf2f01)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.22007855968562777287e-62", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.226148433874936e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.2e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.23e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.2261e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.2261484339e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xf1a117e6b8ea7748)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.22614843387493601186e+239", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0138145232841947e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.01e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0138e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0138145233e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x36628569bf3d57ce)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.01381452328419469062e-46", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8498974618886817e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.85e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8499e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.8498974619e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xad5738ac02112c2d)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.84989746188868167770e-90", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(null);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.092228317853758e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(0);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.1e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.09e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.0922e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.0922283179e+101", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd507630715946934)));
        const s = try num.toExponential(20);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4.09222831785375773241e+101", s);
    }
}

test "toPrecision(p) vectors (against real V8 output)" {
    const a = std.testing.allocator;
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x0000000000000000)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000000000", s);
    }
    {
        const num = ZNumber.init(a, -@as(f64, 0.0));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ff0000000000000)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.00000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.5", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.456", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.4560000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405edd2f1a9fbe77)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.456000000000003070", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00001", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.000012", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00001234", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000123400", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.00001234000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x3ee9e0fcaf9380fc)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("0.0000123400000000000004369", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.2e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.0000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x405ec00000000000)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("123.000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0e+3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.9", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.900", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.9000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x408f3f3333333333)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("999.899999999999977263", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("10", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("10.00", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.99990", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.999900000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4023fff2e48e8a72)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("9.99990000000000023306", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.0e+2", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.0", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.0000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4059000000000000)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("100.000000000000000000", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("3", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.142", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.141592654", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x400921fb54442d11)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.14159265358979000737", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.8e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.768e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.76760e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.767595991e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8ee608cdb00e6972)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.76759599060397311946e-237", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.4e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.443e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.44287e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.442865393e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd922eba20e8bd8a9)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.44286539311099255613e+121", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-4e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.6e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.574e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.57434e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.574336428e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xc6468ea6e5dae88f)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.57433642770914970643e+30", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.113e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.11289e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.112892829e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa1a1c9aa8a0c79e0)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.11289282934265724689e-146", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.5e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.525e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.52473e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.524729442e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xa33f147877b6a0a0)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6.52472944185157777648e-139", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.1e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.110e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.11018e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.110176249e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd7fcdf51cecdf21a)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-7.11017624938936979546e+115", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("1e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.1e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.116e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.11621e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.116214871e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x615fc1fdb56584ed)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("1.11621487062063389298e+161", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.5e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.494e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.49365e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.493649678e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xbafce431e920368c)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.49364967784252831584e-24", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("6e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.6e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.606e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.60581e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.605810857e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x11c9eff4aad8440f)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("5.60581085660549740066e-223", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-6e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.6e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.578e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.57761e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.577607075e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xe96751436aa92c64)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-5.57760707548847172017e+199", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.6e-99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.582e-99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.58183e-99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.581829727e-99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xab94f5369377da4f)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-9.58182972666597098967e-99", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("3e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.1e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.082e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.08241e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.082413372e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x6fffc45079c472aa)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.08241337234058648172e+231", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("4e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.2e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.200e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.19977e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.199773000e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x05b865222a98142c)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("4.19977299977490427742e-281", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("3e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.7e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.699e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.69902e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.699017102e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x2bad8462ff10b7b2)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.69901710215075371132e-98", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.2e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.208e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.20836e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.208357216e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0xd536eb61030326cc)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.20835721645178228680e+102", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.1e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.130e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.12993e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.129926122e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x9c883101cfa3d6f5)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3.12992612195027113917e-171", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("2e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.4e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.376e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.37572e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.375718179e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x1ad8a52bc1c580b5)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("2.37571817900246488199e-179", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("4e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.9e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.942e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.94221e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.942211735e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x4bb013dc70bd5019)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("3.94221173457629141381e+56", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.1e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.088e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.08776e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.087759093e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x8d7db58642606460)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-1.08775909291824950110e-243", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(1);
        defer a.free(s);
        try std.testing.expectEqualStrings("-3e-215", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(2);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.9e-215", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(4);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.920e-215", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(6);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.92001e-215", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(10);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.920008111e-215", s);
    }
    {
        const num = ZNumber.init(a, @bitCast(@as(u64, 0x936421d6fc83a559)));
        const s = try num.toPrecision(21);
        defer a.free(s);
        try std.testing.expectEqualStrings("-2.92000811096220492246e-215", s);
    }
}

