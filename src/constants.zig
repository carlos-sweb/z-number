const std = @import("std");

/// ECMAScript Number Constants
/// These constants match the behavior of JavaScript's Number object
pub const Constants = struct {
    /// The difference between 1 and the smallest floating point number greater than 1
    /// Represents the smallest increment between two representable numbers
    /// JavaScript: Number.EPSILON
    pub const EPSILON: f64 = 2.220446049250313e-16;

    /// The largest positive representable number
    /// JavaScript: Number.MAX_VALUE
    pub const MAX_VALUE: f64 = 1.7976931348623157e+308;

    /// The smallest positive representable number
    /// JavaScript: Number.MIN_VALUE
    pub const MIN_VALUE: f64 = 5e-324;

    /// The maximum safe integer in JavaScript (2^53 - 1)
    /// Beyond this value, not all integers can be represented exactly
    /// JavaScript: Number.MAX_SAFE_INTEGER
    pub const MAX_SAFE_INTEGER: i64 = 9007199254740991;

    /// The minimum safe integer in JavaScript (-(2^53 - 1))
    /// Below this value, not all integers can be represented exactly
    /// JavaScript: Number.MIN_SAFE_INTEGER
    pub const MIN_SAFE_INTEGER: i64 = -9007199254740991;

    /// Positive infinity
    /// JavaScript: Number.POSITIVE_INFINITY
    pub const POSITIVE_INFINITY: f64 = std.math.inf(f64);

    /// Negative infinity
    /// JavaScript: Number.NEGATIVE_INFINITY
    pub const NEGATIVE_INFINITY: f64 = -std.math.inf(f64);

    /// Not a Number
    /// JavaScript: Number.NaN
    pub const NaN: f64 = std.math.nan(f64);
};
