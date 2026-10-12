# Numeric conformance

The target is [ECMA-262 edition 17, ECMAScript 2026](https://262.ecma-international.org/17.0/). z-number provides typed numeric and UTF-8 string operations for Zig 0.17. It is not a JavaScript runtime or an implementation of the entire ECMAScript language.

All rows below are implemented and have regression coverage. “Covered” means the listed finite tests pass; it is not a proof for every binary64 value. The Node corpus is a differential check, not the normative definition.

| Behavior / public APIs | Specification | Contract and coverage |
| --- | --- | --- |
| Number constants | §21.1.2 | `constants_test`, including smallest subnormal, infinity and safe integer limits |
| `init`, `fromInt`, `valueOf` | Typed construction; numeric portion of §21.1.1 / §21.1.3.7 | Zig `f64`/`i64` inputs; `static_test`, `ieee754_test`, public API smoke tests |
| `isFinite`, `isInteger`, `isNaN`, `isSafeInteger` | §21.1.2 | `f64` input, no dynamic coercion; static/validation tests and 10,000-case corpus |
| `parseFloat` | §19.2.4, §21.1.2.12 | Longest decimal prefix, ECMA whitespace, negative zero; parsing tests, long-string corpus and adapted Test262 |
| `parseInt` | §19.2.5, §21.1.2.13 | Longest digit prefix; numeric radix via ToInt32; allocation-free u64 accumulation and exact bignum fallback; parsing tests, BigInt oracle and adapted Test262 |
| `stringToNumber`, `fromString` | §7.1.4.1 StringNumericLiteral | Entire UTF-8 input; empty string → +0; decimal/Infinity and unsigned 0x/0o/0b; parsing, round-trip and Test262 tests |
| `add`, `subtract`, `multiply`, `divide`, `modulo`, `negate` | §6.1.6.1 | IEEE 754 and specified remainder; signed zeros, subnormals, NaN/Infinity; edge tests and corpus |
| `power` | §6.1.6.1.3 | Normative special-case order, signs and domain checks; remaining finite magnitude via `std.math.pow`, implementation-approximated; parity/edge tests |
| Bitwise NOT/AND/OR/XOR and three shifts | §6.1.6.1.2, .9–.11, .16–.19 | ToInt32/ToUint32 operands and five-bit shift count; parity tests and corpus |
| `equals`, `lessThan`, `greaterThan`, `sameValue`, `sameValueZero` | §6.1.6.1.12–.15, relational operators | Equality policies and relational false on NaN; parity tests and corpus |
| `compare` | Zig extension | `?std.math.Order`; null for NaN, signed zeros compare equal; parity tests |
| `toI8`, `toU8`, `toI16`, `toU16`, `toI32`, `toU32`, `toUint8Clamp` | §7.1.6–§7.1.12 | Wrapping or saturation/ties-to-even; conversion tests, V8 vectors and corpus |
| `toIntegerOrInfinity`, `toLength`, `toIndex` | §7.1.5, §7.1.20, §7.1.22 | Numeric input; safe integer bounds and RangeError for invalid indices; conversion/parity tests and corpus |
| `toString`, `toExponential`, `toFixed`, `toPrecision` | §6.1.6.1.20, §21.1.3 | Numeric optional arguments normalized by ToIntegerOrInfinity, method-specific exception order, arbitrary precision; formatting vectors, parity tests and 10,000-case corpus |
| Radixes 2–36 | §6.1.6.1.20 | Shortest significand, exact binary64 rounding interval; independent integer interval/minimality tests for all 35 radixes and extreme/curated values |
| `toLocaleString` | §21.1.3.4 without ECMA-402 | Deterministic decimal fallback; locale ignored; no Intl locale validation, grouping or numbering systems |
| `toInt`, `toUint`, `toF32`, `toBytes`, `fromBytes`, `isInRange`, `abs`, `sqrt` | Zig extensions; sqrt corresponds to numeric Math.sqrt cases | Checked integer/f32 conversion, native byte order and convenience operations; conversion/IEEE/validation/public API tests |
| `ErrorContext.format`, result ownership and OOM | Zig host contracts | Custom formatter compatible with 0.17; every returned string owned by caller; memory tests inject allocation failures and reject resizes |

## Policies and boundaries

- `?f64` arguments: Zig `null` represents omission / JavaScript `undefined`; it does not represent JavaScript `null`. Callers perform dynamic value coercion outside this library.
- JS strings are UTF-16; this API deliberately accepts UTF-8. The full conversion rejects malformed UTF-8 with NaN. Prefix parsers stop on unrecognized suffix bytes, including malformed UTF-8 after a valid prefix.
- Parsing invalid syntax returns NaN. `parseInt` validates and accumulates magnitudes fitting `u64` without heap allocation; the sign is applied after one correctly rounded conversion. Larger integers use bignum with capacity calculated from significant digits; prefixes whose digit count or decimal value already proves overflow bypass the u64 arithmetic. Exhausted host memory returns `error.OutOfMemory` only when allocation is needed. No valid-input length limit has been added.
- Prefix whitespace scanning uses an ASCII fast path and retains ECMA Unicode decoding for non-ASCII bytes. Float prefix classification handles Infinity directly and delegates decimal conversion to Zig’s existing exact converter; its grammar and longest-prefix behavior are unchanged.
- The spec allows multiple shortest representations in some cases. This library chooses nearest value, breaking exact ties by even significand as recommended by §6.1.6.1.20 Note 2; fixed precision uses the specified larger-magnitude tie. A particular engine can differ where the specification permits a choice.
- `parseInt` may be implementation-approximated for some radixes and long decimal inputs under ECMA-262. This library instead retains all digits and rounds the exact integer to nearest-even. The integer corpus uses `Number(BigInt(exact accumulation))`, avoiding dependence on an engine's parseInt approximation.
- General finite exponentiation is implementation-approximated. It is not promised to match V8 bit-for-bit; the tests require the normative special cases, not universal equality with one libm implementation. Checked `toF32` is not Float32Array coercion.
- No object receivers, Number wrappers/properties/descriptors, Symbol, boolean/null/undefined coercion, BigInt runtime operations, ToPrimitive hooks, evaluation-order effects or Intl are implemented. Typed `f64` APIs make invalid receiver types unrepresentable rather than throwing a JS TypeError.

## Reproduce validation

```sh
zig build test --summary all
zig build test -Doptimize=ReleaseSafe --summary all
node tools/generate-conformance.mjs
node tools/fetch-test262.mjs /tmp/z-number-test262
node tools/generate-test262.mjs /tmp/z-number-test262
```

Normal tests use committed fixtures and need neither Node nor network. Regeneration requires Node; manifests record its version, V8 version, PRNG seed, schema, Test262 commit, source hashes and exclusion policy. The binary64 corpus has 10,000 cases, each checking 22 numeric results, nine predicates, five formatting results and decimal parsing round-trips. Another 3,087 cases exercise long strings and exact integer conversion.

The adapted Test262 corpus contains 214 primitive/string calls from ten selected source files pinned to commit `2e0a56762801e275a9fdf96dc49d90ba0cddcf63`. Original selected JS tests are checked against their own assertions during regeneration; dynamic calls outside this API are excluded. Number.prototype formatting calls are explicitly translated to the primitive numeric value +0. This is not a claim that the entire Test262 suite runs against z-number. Source paths, SHA-256 hashes and exclusions are in `tests/data/test262-manifest.json`. See [Test262 notices](NOTICE-Test262.md) and [license](LICENSE-Test262).

Memory validation uses `std.testing.allocator` and `checkAllAllocationFailures`, including fallback paths after denied resizes. It covers 20 success scenarios plus invalid-input/OOM distinction. Additional parser tests check zero heap allocations up to u64, exact rounding and bignum transitions in all 35 radixes, long leading zeros, mixed whitespace and malformed suffixes. Passing tests establish cleanup for these exercised routes, not a universal absence-of-leaks proof.
