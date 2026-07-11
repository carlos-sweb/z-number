# Z-Number

ECMAScript-compatible Number implementation in Zig 0.16

[![Zig 0.16](https://img.shields.io/badge/Zig-0.16-orange.svg)](https://ziglang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> A production-ready library implementing JavaScript's Number object in Zig, designed as a core component for JavaScript engines (like Bun/QuickJS).

[Español](README.es.md) | English

## Features

- **Spec-exact formatting**: `toString`/`toFixed`/`toExponential`/`toPrecision` are implemented with arbitrary-precision (bignum) digit generation — not `printf`-style formatting — so rounding and the shortest round-tripping representation match a real JS engine exactly, including radixes 2-36 for `toString`.
- **Spec-exact parsing**: `Number.parseInt`/`Number.parseFloat` consume the *longest valid prefix* and ignore trailing garbage, exactly like JS, instead of requiring the whole string to be valid.
- **Spec-exact `ToInt32`/`ToUint32`**: `toI32`/`toU32` never fail — they wrap modulo 2^32 like JS's `| 0` / `>>> 0`, instead of throwing on overflow.
- **IEEE 754 Compliant**: Proper handling of NaN, Infinity, -Infinity, and special values
- **Modern Zig**: Written for Zig 0.16 with labeled blocks and best practices
- **Comprehensive Testing**: 200+ tests, including thousands of vectors generated from and cross-checked against real Node.js/V8 output
- **Production Ready**: Designed for use in JavaScript engines

### Scope

This library implements ECMA-262 §21.1 Number constants, static methods
(`isFinite`/`isInteger`/`isNaN`/`isSafeInteger`/`parseInt`/`parseFloat`), and
`Number.prototype` string/formatting methods, operating on Zig's native
`f64`/`i64`/strings. It does **not** implement the `Number` constructor's
`ToNumber` coercion from other JS value types (booleans, `null`, `undefined`,
objects) — there is no dynamic "JS value" type here to coerce from, only
numbers, integers and strings.

For `toString(radix)` with `radix != 10`, ECMA-262 does not mandate an exact
digit-generation algorithm (only decimal `toString` is normative there). This
library always produces a *correct, exactly round-tripping* representation,
computed as the true shortest digit sequence — for fractional values or
integers beyond 2^53 this can occasionally differ by a digit or two from a
specific engine's own (non-normative, and not always minimal) output, though
both remain valid representations of the same value.

## Quick Start

```zig
const std = @import("std");
const ZNumber = @import("znumber").ZNumber;
const Constants = @import("znumber").Constants;

pub fn main() !void {
    var gpa:std.heap.DebugAllocator(.{}) = .init;
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
```

## Installation

```sh
zig fetch --save git+https://github.com/carlos-sweb/z-number.git
```

Add Z-Number to your `build.zig`:

```zig
const znumber_dep = b.dependency("znumber", .{
    .target = target,
    .optimize = optimize,
});

exe.root_module.addImport("znumber", znumber_dep.module("znumber"));
```

## API Reference

### Constants

All ECMAScript Number constants are available:

```zig
Constants.EPSILON              // 2.220446049250313e-16
Constants.MAX_VALUE             // 1.7976931348623157e+308
Constants.MIN_VALUE             // 5e-324
Constants.MAX_SAFE_INTEGER      // 9007199254740991
Constants.MIN_SAFE_INTEGER      // -9007199254740991
Constants.POSITIVE_INFINITY     // Infinity
Constants.NEGATIVE_INFINITY     // -Infinity
Constants.NaN                   // NaN
```

### Static Methods

#### Number.isFinite(value: f64) bool

Checks if a value is finite (not NaN or Infinity):

```zig
ZNumber.isFinite(42.0)      // true
ZNumber.isFinite(NaN)       // false
ZNumber.isFinite(Infinity)  // false
```

#### Number.isInteger(value: f64) bool

Checks if a value is an integer:

```zig
ZNumber.isInteger(42.0)   // true
ZNumber.isInteger(42.5)   // false
```

#### Number.isNaN(value: f64) bool

Checks if a value is NaN:

```zig
ZNumber.isNaN(Constants.NaN)  // true
ZNumber.isNaN(42.0)           // false
```

#### Number.isSafeInteger(value: f64) bool

Checks if a value is within the safe integer range:

```zig
ZNumber.isSafeInteger(9007199254740991)  // true
ZNumber.isSafeInteger(9007199254740992)  // false
```

#### Number.parseFloat(str: []const u8) f64

Parses a string to a floating-point number:

```zig
ZNumber.parseFloat("3.14")        // 3.14
ZNumber.parseFloat("  42  ")      // 42.0
ZNumber.parseFloat("Infinity")    // Infinity
```

#### Number.parseInt(allocator: Allocator, str: []const u8, radix: ?u8) f64

Parses a string to a number with optional radix. Like JS, it consumes the
longest valid digit run and ignores the rest, and returns `NaN` — never an
error — on invalid input:

```zig
ZNumber.parseInt(allocator, "42", 10)      // 42
ZNumber.parseInt(allocator, "0xFF", null)  // 255 (auto-detect hex)
ZNumber.parseInt(allocator, "1010", 2)     // 10
ZNumber.parseInt(allocator, "42px", 10)    // 42 (stops at the first invalid digit)
ZNumber.parseInt(allocator, "abc", 10)     // NaN
```

### Instance Methods

#### toFixed(fraction_digits: ?usize) ![]u8

Formats number with fixed decimal places:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toFixed(2);
// result: "123.46"
```

#### toExponential(fraction_digits: ?usize) ![]u8

Formats number in exponential notation:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toExponential(2);
// result: "1.23e+2"
```

#### toPrecision(precision: ?usize) ![]u8

Formats number with specified precision:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toPrecision(5);
// result: "123.46"
```

#### toString(radix: ?u8) ![]u8

Converts to string with optional radix:

```zig
const num = ZNumber.init(allocator, 255.0);
const hex = try num.toString(16);
// hex: "ff"
```

### Arithmetic Operations

```zig
const a = ZNumber.init(allocator, 10.0);
const b = ZNumber.init(allocator, 5.0);

a.add(b)       // 15.0
a.subtract(b)  // 5.0
a.multiply(b)  // 50.0
a.divide(b)    // 2.0
a.modulo(b)    // 0.0
a.power(2.0)   // 100.0
```

### Conversion Methods

```zig
const num = ZNumber.init(allocator, 42.7);

try num.toInt()   // 42 (i64) — convenience helper, not part of ECMA-262; errors on NaN/Infinity/overflow
try num.toUint()  // 42 (u64) — same as above
num.toI32()       // 42 (i32) — ECMA-262 ToInt32; never fails, wraps mod 2^32 like `x | 0`
num.toU32()       // 42 (u32) — ECMA-262 ToUint32; never fails, wraps mod 2^32 like `x >>> 0`
```

## IEEE 754 Compliance

Z-Number fully implements IEEE 754 double-precision floating-point arithmetic:

```zig
// NaN propagation
const nan_result = Constants.NaN + 42.0;  // NaN

// Infinity arithmetic
const inf_result = Constants.POSITIVE_INFINITY + 100.0;  // Infinity

// Division by zero
const div_zero = 1.0 / 0.0;  // Infinity

// Signed zero
const neg_zero: f64 = -0.0;  // Distinct from +0.0 in bit representation
```

## Testing

Run the comprehensive test suite:

```bash
zig build test --summary all
```

Tests cover:
- Constants, static methods, instance methods, validation, conversion, edge cases, and IEEE 754 compliance (hand-written, ~190 tests)
- Formatting, parsing, and `ToInt32`/`ToUint32` **vectors generated from and cross-checked against real Node.js/V8 output** (`tests/*_vectors_test.zig`) — thousands of individual assertions covering `toString` (radix 2-36), `toFixed`, `toExponential`, `toPrecision`, `parseInt`, `parseFloat`, and integer coercion across curated edge cases and randomized doubles

**Total: 200+ top-level tests (thousands of assertions), all passing**

## Implementation Details

### Labeled Blocks

Z-Number uses labeled blocks extensively (10+ places) for clear control flow:

```zig
formatter: {
    // Validate fraction_digits (0-100)
    if (fraction_digits) |fd| {
        if (fd > 100) return ZNumberError.RangeError;
    }

    // Handle special values
    if (std.math.isNan(value)) return try allocator.dupe(u8, "NaN");
    if (std.math.isInf(value)) {
        return try allocator.dupe(u8, if (value > 0) "Infinity" else "-Infinity");
    }

    break :formatter;
}
```

### Error Handling

Comprehensive error types for all failure modes:

```zig
pub const ZNumberError = error{
    OutOfMemory,
    InvalidNumber,
    RangeError,
    Overflow,
    Underflow,
};
```

Note that the ECMA-262 operations themselves (`toI32`/`toU32`/`parseInt`/`parseFloat`)
never return these errors — they wrap or return `NaN` like JS. `RangeError` is
only used for out-of-spec-range arguments (e.g. `toFixed(101)`), and
`Overflow`/`Underflow`/`InvalidNumber` are only used by the non-spec 64-bit
convenience helpers (`toInt`/`toUint`).

## Project Structure

```
z-number/
├── src/
│   ├── znumber.zig         # Main ZNumber structure
│   ├── constants.zig       # Number constants
│   ├── errors.zig          # Error types
│   ├── bignum.zig          # Arbitrary-precision digit generation (Dragon4-style)
│   ├── formatting.zig      # Formatting methods (toString/toFixed/toExponential/toPrecision)
│   ├── parsing.zig         # Parsing methods (parseInt/parseFloat)
│   ├── validation.zig      # Validation methods
│   └── conversion.zig      # Type conversions (incl. ToInt32/ToUint32)
├── tests/
│   ├── constants_test.zig
│   ├── static_test.zig
│   ├── formatting_test.zig
│   ├── parsing_test.zig
│   ├── validation_test.zig
│   ├── conversion_test.zig
│   ├── edge_cases_test.zig
│   ├── ieee754_test.zig
│   ├── formatting_vectors_test.zig      # generated from real V8 output
│   ├── parsing_vectors_test.zig         # generated from real V8 output
│   └── int_conversion_vectors_test.zig  # generated from real V8 output
├── build.zig
├── README.md
└── README.es.md
```

## Examples

### Basic Operations

```zig
const allocator = std.testing.allocator;

// Create and manipulate numbers
const num = ZNumber.init(allocator, 42.5);
const doubled = num.multiply(ZNumber.init(allocator, 2.0));
std.debug.print("{d}\n", .{doubled.value}); // 85.0
```

### Formatting Numbers

```zig
const num = ZNumber.init(allocator, 1234.5678);

const fixed = try num.toFixed(2);
defer allocator.free(fixed);
// "1234.57"

const exp = try num.toExponential(3);
defer allocator.free(exp);
// "1.235e+3"
```

### Parsing Strings

```zig
// Parse floats
const float_val = ZNumber.parseFloat("3.14159");

// Parse integers with different radices
const decimal = ZNumber.parseInt(allocator, "42", 10);
const hex = ZNumber.parseInt(allocator, "0xFF", null);  // auto-detect
const binary = ZNumber.parseInt(allocator, "1010", 2);
```

### Special Values

```zig
// Working with NaN
if (ZNumber.isNaN(some_value)) {
    std.debug.print("Value is NaN\n", .{});
}

// Working with Infinity
const inf = Constants.POSITIVE_INFINITY;
const is_finite = ZNumber.isFinite(inf);  // false
```

## Contributing

Contributions are welcome! Please ensure:
1. All tests pass: `zig build test`
2. Code follows Zig style guidelines
3. New features include tests
4. Documentation is updated

## License

MIT License - see LICENSE file for details

## Acknowledgments

Built with Zig 0.16 for maximum performance and safety. Designed to be a core component of modern JavaScript engines.

---

Made with ❤️ for the Zig community
