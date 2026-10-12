const std = @import("std");
const Allocator = std.mem.Allocator;
const Managed = std.math.big.int.Managed;
const Constants = @import("constants.zig").Constants;
const ConversionMethods = @import("conversion.zig").ConversionMethods;

// ECMA-262 WhiteSpace (Unicode Zs plus TAB, VT, FF and BOM) and LineTerminator.
fn isWhitespace(cp: u21) bool {
    return switch (cp) {
        0x9...0xd, 0x20, 0xa0, 0x1680, 0x2000...0x200a, 0x2028, 0x2029, 0x202f, 0x205f, 0x3000, 0xfeff => true,
        else => false,
    };
}

fn trimLeadingWhitespace(str: []const u8) []const u8 {
    var pos: usize = 0;
    while (pos < str.len) {
        const c = str[pos];
        if (c < 0x80) {
            if (c != ' ' and (c < 0x09 or c > 0x0d)) break;
            pos += 1;
            continue;
        }
        const len = std.unicode.utf8ByteSequenceLength(c) catch break;
        if (len > str.len - pos) break;
        const cp = std.unicode.utf8Decode(str[pos..][0..len]) catch break;
        if (!isWhitespace(cp)) break;
        pos += len;
    }
    return str[pos..];
}

// Only called on valid UTF-8. Return a slice without trailing ECMA whitespace.
fn trimTrailingWhitespace(str: []const u8) []const u8 {
    var pos: usize = 0;
    var end: usize = 0;
    while (pos < str.len) {
        const len = std.unicode.utf8ByteSequenceLength(str[pos]) catch unreachable;
        const cp = std.unicode.utf8Decode(str[pos..][0..len]) catch unreachable;
        pos += len;
        if (!isWhitespace(cp)) end = pos;
    }
    return str[0..end];
}

const DecimalPrefix = struct {
    end: usize,
    kind: enum { invalid, decimal, infinity },
    negative: bool = false,

    fn value(self: DecimalPrefix, str: []const u8) f64 {
        return switch (self.kind) {
            .invalid => Constants.NaN,
            .infinity => if (self.negative) Constants.NEGATIVE_INFINITY else Constants.POSITIVE_INFINITY,
            .decimal => std.fmt.parseFloat(f64, str[0..self.end]) catch Constants.NaN,
        };
    }
};

// Longest StrDecimalLiteral prefix. An incomplete exponent does not consume 'e'.
fn decimalPrefix(str: []const u8) DecimalPrefix {
    var pos: usize = 0;
    const negative = str.len != 0 and str[0] == '-';
    if (pos < str.len and (str[pos] == '+' or str[pos] == '-')) pos += 1;
    if (pos < str.len and str[pos] == 'I' and std.mem.startsWith(u8, str[pos..], "Infinity")) {
        return .{ .end = pos + 8, .kind = .infinity, .negative = negative };
    }
    var has_digits = false;
    while (pos < str.len and std.ascii.isDigit(str[pos])) : (pos += 1) has_digits = true;
    if (pos < str.len and str[pos] == '.') {
        pos += 1;
        while (pos < str.len and std.ascii.isDigit(str[pos])) : (pos += 1) has_digits = true;
    }
    if (!has_digits) return .{ .end = 0, .kind = .invalid };
    const end = pos;
    if (pos < str.len and (str[pos] == 'e' or str[pos] == 'E')) {
        pos += 1;
        if (pos < str.len and (str[pos] == '+' or str[pos] == '-')) pos += 1;
        const start = pos;
        while (pos < str.len and std.ascii.isDigit(str[pos])) : (pos += 1) {}
        if (pos > start) return .{ .end = pos, .kind = .decimal };
    }
    return .{ .end = end, .kind = .decimal };
}

// Digits have already been validated. OOM is a host error, not an invalid number.
fn integerValue(allocator: Allocator, digits: []const u8, base: u8) Allocator.Error!f64 {
    const significant = std.mem.trimStart(u8, digits, "0");
    if (significant.len == 0) return 0;
    var big = try Managed.initCapacity(allocator, std.math.big.int.calcSetStringLimbCount(base, significant.len));
    defer big.deinit();
    // Capacity was computed above; use the public mutable operation to avoid
    // recalculating capacity (including log2) inside Managed.setString.
    var mutable = big.toMutable();
    mutable.setString(base, significant) catch unreachable; // validated by the caller
    big.setMetadata(mutable.positive, mutable.len);
    return big.toFloat(f64, .nearest_even)[0];
}

const IntegerPrefix = struct {
    end: usize,
    magnitude: ?u64,
};

// Exact digit counts of maxInt(u64), computed without floating-point logarithms.
const u64_digit_counts: [37]u8 = blk: {
    var counts: [37]u8 = @splat(0);
    for (2..37) |base| {
        var n = std.math.maxInt(u64);
        while (n != 0) : (n /= base) counts[base] += 1;
    }
    break :blk counts;
};

inline fn integerDigit(comptime decimal: bool, c: u8, base: u8) ?u8 {
    if (decimal) return if (std.ascii.isDigit(c)) c - '0' else null;
    return std.fmt.charToDigit(c, base) catch null;
}

fn integerEnd(comptime decimal: bool, str: []const u8, start: usize, base: u8) usize {
    var pos = start;
    while (pos < str.len and integerDigit(decimal, str[pos], base) != null) pos += 1;
    return pos;
}

fn integerPrefix(comptime decimal: bool, str: []const u8, start: usize, base: u8) IntegerPrefix {
    var pos = start;
    // Leading zeros have already been removed. Avoid checked arithmetic for a
    // prefix whose digit count (or decimal lexicographic value) proves overflow.
    if (decimal) {
        if (str.len - start >= 20) {
            var probe = start;
            while (probe < start + 20 and std.ascii.isDigit(str[probe])) probe += 1;
            if (probe == start + 20 and
                (std.mem.order(u8, str[start..probe], "18446744073709551615") == .gt or
                    (probe < str.len and std.ascii.isDigit(str[probe]))))
            {
                return .{ .end = integerEnd(true, str, probe, base), .magnitude = null };
            }
        }
    } else {
        const count: usize = u64_digit_counts[base];
        if (str.len - start > count) {
            var probe = start;
            while (probe < start + count + 1 and integerDigit(false, str[probe], base) != null) probe += 1;
            if (probe == start + count + 1) {
                return .{ .end = integerEnd(false, str, probe, base), .magnitude = null };
            }
        }
    }
    var magnitude: u64 = 0;
    while (pos < str.len) : (pos += 1) {
        const digit = integerDigit(decimal, str[pos], base) orelse break;
        const product = @mulWithOverflow(magnitude, if (decimal) @as(u64, 10) else @as(u64, base));
        const sum = @addWithOverflow(product[0], digit);
        if (product[1] != 0 or sum[1] != 0) {
            return .{ .end = integerEnd(decimal, str, pos, base), .magnitude = null };
        }
        magnitude = sum[0];
    }
    return .{ .end = pos, .magnitude = magnitude };
}

pub const ParsingMethods = struct {
    /// Number.parseFloat: parse the longest valid prefix, preserving negative zero.
    /// Invalid UTF-8 after a valid prefix behaves as an unrecognized suffix.
    pub fn parseFloat(str: []const u8) f64 {
        const trimmed = trimLeadingWhitespace(str);
        return decimalPrefix(trimmed).value(trimmed);
    }

    /// Number.parseInt: invalid input returns NaN; allocation failure propagates.
    /// null represents an omitted radix. A present radix is normalized by ToInt32.
    /// Integer digits are rounded exactly to the nearest-even f64.
    /// Magnitudes fitting u64 use no heap; larger integers use the allocator
    /// and may return error.OutOfMemory. Temporary storage is freed before return.
    pub fn parseInt(allocator: Allocator, str: []const u8, radix: ?f64) Allocator.Error!f64 {
        const trimmed = trimLeadingWhitespace(str);
        var pos: usize = 0;
        var neg = false;
        if (pos < trimmed.len and (trimmed[pos] == '+' or trimmed[pos] == '-')) {
            neg = trimmed[pos] == '-';
            pos += 1;
        }
        const r = ConversionMethods.toI32(radix orelse 0);
        if (r != 0 and (r < 2 or r > 36)) return Constants.NaN;
        var base: u8 = @intCast(r);
        if ((base == 0 or base == 16) and trimmed.len - pos >= 2 and trimmed[pos] == '0' and
            (trimmed[pos + 1] == 'x' or trimmed[pos + 1] == 'X'))
        {
            pos += 2;
            base = 16;
        } else if (base == 0) {
            base = 10;
        }
        const start = pos;
        while (pos < trimmed.len and trimmed[pos] == '0') pos += 1;
        const significant_start = pos;
        const prefix = if (base == 10) integerPrefix(true, trimmed, pos, base) else integerPrefix(false, trimmed, pos, base);
        if (prefix.end == start) return Constants.NaN;
        const rounded: f64 = if (prefix.magnitude) |magnitude|
            @floatFromInt(magnitude)
        else
            try integerValue(allocator, trimmed[significant_start..prefix.end], base);
        return if (neg) -rounded else rounded;
    }

    /// StringToNumber: complete StringNumericLiteral, as used by Number(string).
    /// Strings use UTF-8; malformed UTF-8 returns NaN. Empty/whitespace yields +0.
    /// Nondecimal literals can return error.OutOfMemory; temporary storage is freed.
    pub fn stringToNumber(allocator: Allocator, str: []const u8) Allocator.Error!f64 {
        if (!std.unicode.utf8ValidateSlice(str)) return Constants.NaN;
        const trimmed = trimTrailingWhitespace(trimLeadingWhitespace(str));
        if (trimmed.len == 0) return 0;
        if (trimmed.len >= 2 and trimmed[0] == '0') {
            const base: u8 = switch (trimmed[1]) {
                'x', 'X' => 16,
                'o', 'O' => 8,
                'b', 'B' => 2,
                else => 0,
            };
            if (base != 0) {
                if (trimmed.len == 2) return Constants.NaN;
                for (trimmed[2..]) |c| {
                    _ = std.fmt.charToDigit(c, base) catch return Constants.NaN;
                }
                return integerValue(allocator, trimmed[2..], base);
            }
        }
        const prefix = decimalPrefix(trimmed);
        if (prefix.end != trimmed.len) return Constants.NaN;
        return prefix.value(trimmed);
    }
};
