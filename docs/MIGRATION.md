# Numeric parity API migration (Zig 0.17)

Version 0.1.0 requires Zig 0.17.0. These API changes intentionally correct contracts that could not express ECMAScript numeric behavior. They apply to both static helper structs and `ZNumber` wrappers and replace the earlier unreleased APIs.

| Previous call / signature | Replacement |
| --- | --- |
| `parseInt(allocator, str, ?u8) f64` | `try parseInt(allocator, str, ?f64)`; returns NaN for invalid syntax, propagates host OOM |
| `fromString(allocator, str) ZNumber` | `try fromString(allocator, str)`; now uses complete Number(string) grammar |
| `compare(other) std.math.Order` | `compare(other) ?std.math.Order`; handle `null` for NaN |
| Formatting arguments `?usize` / `?u8` | `?f64`; cast runtime integer variables with `@floatFromInt`; numeric literals and `null` remain usable |
| `std.meta.Int(signedness, bits)` | Zig 0.17 `@Int(signedness, bits)` |
| `std.heap.DebugAllocator` examples | `std.heap.SafeAllocator.init(std.heap.page_allocator, .{})` |

```zig
const std = @import("std");
const znumber = @import("znumber");
const allocator = std.testing.allocator;

const parsed_prefix = try znumber.ZNumber.parseInt(allocator, "42px", 10); // 42
const prefix_float = znumber.ZNumber.parseFloat("42px"); // 42
const full_number = try znumber.ZNumber.fromString(allocator, "42px"); // NaN
const binary = try znumber.ZNumber.fromString(allocator, "0b101"); // 5
const whitespace = try znumber.ZNumber.stringToNumber(allocator, " "); // +0

const result = try binary.toFixed(2.9); // ToIntegerOrInfinity -> 2, "5.00"
defer allocator.free(result);
const order = full_number.compare(binary); // null: unordered
```

Use `parseFloat` when prefix parsing is intended. Use `stringToNumber` or `fromString` for Number(string). A `null` optional numeric argument means omission, not the JavaScript null value. For a JS null argument the embedding runtime must first coerce to numeric zero.

`parseInt` now avoids heap allocation for magnitudes up to `u64` (including signed zero and values beyond 2^53). Small valid inputs can succeed even with an allocator that rejects all reservations. The signature is unchanged; larger inputs still propagate `error.OutOfMemory` and round the exact integer to nearest-even.

Every formatting method returns an owned mutable slice, even for "NaN", "0" and "Infinity". Free it with the same allocator after use. `ZNumber.deinit()` is a no-op: a number owns neither its allocator nor the strings it previously returned. The allocator must remain usable while formatting that number or freeing its outputs.

New operations: `negate`, `bitwiseNot`, `bitwiseAnd`, `bitwiseOr`, `bitwiseXor`, `shiftLeft`, `shiftRight`, `shiftRightUnsigned`, `sameValue`, `sameValueZero`, `stringToNumber` and `toIndex`. Binary instance operations receive `ZNumber` and return `ZNumber` using the left operand's allocator; equality predicates return bool. `toIndex` is a static numeric conversion returning `!u64`.

`toLocaleString` is a decimal fallback and ignores locale; it does not implement ECMA-402 Intl. `toInt`, `toUint`, `toF32`, native-order bytes and `compare` are documented Zig extensions. Conformance policies and exclusions are in [CONFORMANCE.md](CONFORMANCE.md).
