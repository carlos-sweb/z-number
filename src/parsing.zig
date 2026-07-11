const std = @import("std");
const Allocator = std.mem.Allocator;
const Managed = std.math.big.int.Managed;
const Constants = @import("constants.zig").Constants;

fn trimLeadingWhitespace(str: []const u8) []const u8 {
    var i: usize = 0;
    while (i < str.len and std.ascii.isWhitespace(str[i])) i += 1;
    return str[i..];
}

/// Parsing methods for converting strings to numbers.
/// These implement ECMA-262's Number.parseFloat (21.1.2.15) and
/// Number.parseInt (21.1.2.14): both take the *longest valid prefix* of the
/// (whitespace-trimmed) input and ignore anything after it, returning NaN
/// only when no valid prefix exists at all.
pub const ParsingMethods = struct {
    /// Number.parseFloat() - Parse the longest StrDecimalLiteral prefix.
    pub fn parseFloat(str: []const u8) f64 {
        const trimmed = trimLeadingWhitespace(str);

        if (std.mem.startsWith(u8, trimmed, "Infinity") or
            std.mem.startsWith(u8, trimmed, "+Infinity"))
        {
            return Constants.POSITIVE_INFINITY;
        }
        if (std.mem.startsWith(u8, trimmed, "-Infinity")) {
            return Constants.NEGATIVE_INFINITY;
        }

        var pos: usize = 0;
        if (pos < trimmed.len and (trimmed[pos] == '+' or trimmed[pos] == '-')) {
            pos += 1;
        }

        var has_digits = false;
        while (pos < trimmed.len and std.ascii.isDigit(trimmed[pos])) : (pos += 1) {
            has_digits = true;
        }

        if (pos < trimmed.len and trimmed[pos] == '.') {
            pos += 1;
            while (pos < trimmed.len and std.ascii.isDigit(trimmed[pos])) : (pos += 1) {
                has_digits = true;
            }
        }

        if (!has_digits) return Constants.NaN;

        var exp_end = pos;
        if (pos < trimmed.len and (trimmed[pos] == 'e' or trimmed[pos] == 'E')) {
            var epos = pos + 1;
            if (epos < trimmed.len and (trimmed[epos] == '+' or trimmed[epos] == '-')) {
                epos += 1;
            }
            const exp_digits_start = epos;
            while (epos < trimmed.len and std.ascii.isDigit(trimmed[epos])) : (epos += 1) {}
            if (epos > exp_digits_start) exp_end = epos;
        }

        const prefix = trimmed[0..exp_end];
        return std.fmt.parseFloat(f64, prefix) catch Constants.NaN;
    }

    /// Number.parseInt() - Parse the longest run of valid digits for `radix`
    /// (auto-detecting hex via a "0x"/"0X" prefix only, per spec — unlike
    /// this library's previous behavior, "0o"/"0b" are NOT special-cased,
    /// matching real JS). Returns NaN, never an error, exactly like JS.
    /// The exact digit run is parsed via arbitrary-precision arithmetic so
    /// very long digit strings round to the correctly-nearest f64, matching
    /// the "Number value for mathInt" step of the spec algorithm.
    pub fn parseInt(allocator: Allocator, str: []const u8, radix: ?u8) f64 {
        const trimmed = trimLeadingWhitespace(str);

        var pos: usize = 0;
        var neg = false;
        if (pos < trimmed.len and (trimmed[pos] == '+' or trimmed[pos] == '-')) {
            neg = trimmed[pos] == '-';
            pos += 1;
        }

        if (radix) |r| {
            if (r != 0 and (r < 2 or r > 36)) return Constants.NaN;
        }

        var base: u8 = radix orelse 0;
        const strip_hex_prefix = (base == 0 or base == 16);
        if (strip_hex_prefix and pos + 1 < trimmed.len and trimmed[pos] == '0' and
            (trimmed[pos + 1] == 'x' or trimmed[pos + 1] == 'X'))
        {
            pos += 2;
            base = 16;
        } else if (base == 0) {
            base = 10;
        }

        const digits_start = pos;
        while (pos < trimmed.len) : (pos += 1) {
            _ = std.fmt.charToDigit(trimmed[pos], base) catch break;
        }

        if (pos == digits_start) return Constants.NaN;

        var big = Managed.init(allocator) catch return Constants.NaN;
        defer big.deinit();
        big.setString(base, trimmed[digits_start..pos]) catch return Constants.NaN;

        const rounded = big.toFloat(f64, .nearest_even)[0];
        return if (neg) -rounded else rounded;
    }
};
