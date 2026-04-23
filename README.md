# Z-Number

ECMAScript-compatible Number implementation in Zig 0.16

[![Zig 0.16](https://img.shields.io/badge/Zig-0.16-orange.svg)](https://ziglang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> A production-ready library implementing JavaScript's Number object in Zig, designed as a core component for JavaScript engines (like Bun/QuickJS).

[Español](README.es.md) | English

## Features

- **100% ECMAScript Compatible**: Implements all Number constants, static methods, and instance methods
- **IEEE 754 Compliant**: Proper handling of NaN, Infinity, -Infinity, and special values
- **Modern Zig**: Written for Zig 0.16 with labeled blocks and best practices
- **Comprehensive Testing**: 171+ tests covering all edge cases
- **Type Safe**: Full type safety with proper error handling
- **Production Ready**: Designed for use in JavaScript engines

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

zig fetch --save git+https://github.com/carlos-sweb/z-number.git

or 

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

#### Number.parseInt(str: []const u8, radix: ?u8) !i64

Parses a string to an integer with optional radix:

```zig
try ZNumber.parseInt("42", 10)      // 42
try ZNumber.parseInt("0xFF", null)  // 255 (auto-detect hex)
try ZNumber.parseInt("1010", 2)     // 10
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

try num.toInt()   // 42 (i64)
try num.toUint()  // 42 (u64)
try num.toI32()   // 42 (i32)
try num.toU32()   // 42 (u32)
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
- All constants (17 tests)
- Static methods (24 tests)
- Instance methods (22 tests)
- Formatting (15 tests)
- Parsing (20 tests)
- Validation (14 tests)
- Conversion (25 tests)
- Edge cases (30 tests)
- IEEE 754 compliance (24 tests)

**Total: 171+ tests, all passing**

## Implementation Details

### Labeled Blocks

Z-Number uses labeled blocks extensively (10+ places) for clear control flow:

```zig
pub fn parseInt(str: []const u8, radix: ?u8) !i64 {
    int_parser: {
        // Validation and preprocessing
        const radix_specified = radix != null;
        const base = radix orelse 10;

        // Auto-detect radix if not specified
        if (!radix_specified and trimmed.len >= 2) {
            if (trimmed[0] == '0' and trimmed[1] == 'x') {
                trimmed = trimmed[2..];
                base = 16;
            }
        }

        break :int_parser;
    }

    // Parse integer with radix
    return std.fmt.parseInt(i64, trimmed, base);
}
```

### Error Handling

Comprehensive error types for all failure modes:

```zig
pub const ZNumberError = error{
    OutOfMemory,
    InvalidNumber,
    InvalidRadix,
    RangeError,
    Overflow,
    Underflow,
    DivisionByZero,
    InvalidRadixConversion,
    ParseError,
    InvalidFormat,
    PrecisionLoss,
};
```

## Project Structure

```
z-number/
├── src/
│   ├── znumber.zig         # Main ZNumber structure
│   ├── constants.zig       # Number constants
│   ├── errors.zig          # Error types
│   ├── formatting.zig      # Formatting methods
│   ├── parsing.zig         # Parsing methods
│   ├── validation.zig      # Validation methods
│   └── conversion.zig      # Type conversions
├── tests/
│   ├── constants_test.zig
│   ├── static_test.zig
│   ├── formatting_test.zig
│   ├── parsing_test.zig
│   ├── validation_test.zig
│   ├── conversion_test.zig
│   ├── edge_cases_test.zig
│   └── ieee754_test.zig
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
const decimal = try ZNumber.parseInt("42", 10);
const hex = try ZNumber.parseInt("0xFF", null);  // auto-detect
const binary = try ZNumber.parseInt("1010", 2);
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
