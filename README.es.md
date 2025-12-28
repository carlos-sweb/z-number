# Z-Number

Implementación de Number compatible con ECMAScript en Zig 0.15

[![Zig 0.15](https://img.shields.io/badge/Zig-0.15-orange.svg)](https://ziglang.org/)
[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)

> Una biblioteca lista para producción que implementa el objeto Number de JavaScript en Zig, diseñada como componente central para motores JavaScript (como Bun/QuickJS).

Español | [English](README.md)

## Características

- **100% Compatible con ECMAScript**: Implementa todas las constantes, métodos estáticos y métodos de instancia de Number
- **Cumple con IEEE 754**: Manejo correcto de NaN, Infinity, -Infinity y valores especiales
- **Zig Moderno**: Escrito para Zig 0.15 con labeled blocks y mejores prácticas
- **Pruebas Exhaustivas**: 171+ tests cubriendo todos los casos edge
- **Seguridad de Tipos**: Seguridad de tipos completa con manejo de errores adecuado
- **Listo para Producción**: Diseñado para uso en motores JavaScript

## Inicio Rápido

```zig
const std = @import("std");
const ZNumber = @import("znumber").ZNumber;
const Constants = @import("znumber").Constants;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Crear números
    const num1 = ZNumber.init(allocator, 42.5);
    const num2 = ZNumber.fromInt(allocator, 100);

    // Aritmética
    const sum = num1.add(num2);
    std.debug.print("Suma: {d}\n", .{sum.value}); // 142.5

    // Formateo
    const fixed = try num1.toFixed(2);
    defer allocator.free(fixed);
    std.debug.print("Fixed: {s}\n", .{fixed}); // "42.50"

    // Parsing
    const parsed = ZNumber.parseFloat("3.14");
    std.debug.print("Parsed: {d}\n", .{parsed}); // 3.14
}
```

## Instalación

Agrega Z-Number a tu `build.zig`:

```zig
const znumber_dep = b.dependency("znumber", .{
    .target = target,
    .optimize = optimize,
});

exe.root_module.addImport("znumber", znumber_dep.module("znumber"));
```

## Referencia de API

### Constantes

Todas las constantes de Number de ECMAScript están disponibles:

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

### Métodos Estáticos

#### Number.isFinite(value: f64) bool

Verifica si un valor es finito (no es NaN ni Infinity):

```zig
ZNumber.isFinite(42.0)      // true
ZNumber.isFinite(NaN)       // false
ZNumber.isFinite(Infinity)  // false
```

#### Number.isInteger(value: f64) bool

Verifica si un valor es un entero:

```zig
ZNumber.isInteger(42.0)   // true
ZNumber.isInteger(42.5)   // false
```

#### Number.isNaN(value: f64) bool

Verifica si un valor es NaN:

```zig
ZNumber.isNaN(Constants.NaN)  // true
ZNumber.isNaN(42.0)           // false
```

#### Number.isSafeInteger(value: f64) bool

Verifica si un valor está dentro del rango de enteros seguros:

```zig
ZNumber.isSafeInteger(9007199254740991)  // true
ZNumber.isSafeInteger(9007199254740992)  // false
```

#### Number.parseFloat(str: []const u8) f64

Parsea una cadena a un número de punto flotante:

```zig
ZNumber.parseFloat("3.14")        // 3.14
ZNumber.parseFloat("  42  ")      // 42.0
ZNumber.parseFloat("Infinity")    // Infinity
```

#### Number.parseInt(str: []const u8, radix: ?u8) !i64

Parsea una cadena a un entero con base opcional:

```zig
try ZNumber.parseInt("42", 10)      // 42
try ZNumber.parseInt("0xFF", null)  // 255 (auto-detecta hex)
try ZNumber.parseInt("1010", 2)     // 10
```

### Métodos de Instancia

#### toFixed(fraction_digits: ?usize) ![]u8

Formatea número con decimales fijos:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toFixed(2);
// result: "123.46"
```

#### toExponential(fraction_digits: ?usize) ![]u8

Formatea número en notación exponencial:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toExponential(2);
// result: "1.23e+2"
```

#### toPrecision(precision: ?usize) ![]u8

Formatea número con precisión especificada:

```zig
const num = ZNumber.init(allocator, 123.456);
const result = try num.toPrecision(5);
// result: "123.46"
```

#### toString(radix: ?u8) ![]u8

Convierte a cadena con base opcional:

```zig
const num = ZNumber.init(allocator, 255.0);
const hex = try num.toString(16);
// hex: "ff"
```

### Operaciones Aritméticas

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

### Métodos de Conversión

```zig
const num = ZNumber.init(allocator, 42.7);

try num.toInt()   // 42 (i64)
try num.toUint()  // 42 (u64)
try num.toI32()   // 42 (i32)
try num.toU32()   // 42 (u32)
```

## Cumplimiento IEEE 754

Z-Number implementa completamente la aritmética de punto flotante de doble precisión IEEE 754:

```zig
// Propagación de NaN
const nan_result = Constants.NaN + 42.0;  // NaN

// Aritmética de infinito
const inf_result = Constants.POSITIVE_INFINITY + 100.0;  // Infinity

// División por cero
const div_zero = 1.0 / 0.0;  // Infinity

// Cero con signo
const neg_zero: f64 = -0.0;  // Distinto de +0.0 en representación de bits
```

## Pruebas

Ejecuta el conjunto completo de pruebas:

```bash
zig build test --summary all
```

Las pruebas cubren:
- Todas las constantes (17 tests)
- Métodos estáticos (24 tests)
- Métodos de instancia (22 tests)
- Formateo (15 tests)
- Parsing (20 tests)
- Validación (14 tests)
- Conversión (25 tests)
- Casos edge (30 tests)
- Cumplimiento IEEE 754 (24 tests)

**Total: 171+ tests, todos pasando**

## Detalles de Implementación

### Bloques Etiquetados (Labeled Blocks)

Z-Number usa bloques etiquetados extensivamente (10+ lugares) para un flujo de control claro:

```zig
pub fn parseInt(str: []const u8, radix: ?u8) !i64 {
    int_parser: {
        // Validación y preprocesamiento
        const radix_specified = radix != null;
        const base = radix orelse 10;

        // Auto-detectar radix si no se especificó
        if (!radix_specified and trimmed.len >= 2) {
            if (trimmed[0] == '0' and trimmed[1] == 'x') {
                trimmed = trimmed[2..];
                base = 16;
            }
        }

        break :int_parser;
    }

    // Parsear entero con radix
    return std.fmt.parseInt(i64, trimmed, base);
}
```

### Manejo de Errores

Tipos de error comprehensivos para todos los modos de falla:

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

## Estructura del Proyecto

```
z-number/
├── src/
│   ├── znumber.zig         # Estructura principal ZNumber
│   ├── constants.zig       # Constantes de Number
│   ├── errors.zig          # Tipos de error
│   ├── formatting.zig      # Métodos de formateo
│   ├── parsing.zig         # Métodos de parsing
│   ├── validation.zig      # Métodos de validación
│   └── conversion.zig      # Conversiones de tipos
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

## Ejemplos

### Operaciones Básicas

```zig
const allocator = std.testing.allocator;

// Crear y manipular números
const num = ZNumber.init(allocator, 42.5);
const doubled = num.multiply(ZNumber.init(allocator, 2.0));
std.debug.print("{d}\n", .{doubled.value}); // 85.0
```

### Formateo de Números

```zig
const num = ZNumber.init(allocator, 1234.5678);

const fixed = try num.toFixed(2);
defer allocator.free(fixed);
// "1234.57"

const exp = try num.toExponential(3);
defer allocator.free(exp);
// "1.235e+3"
```

### Parsing de Cadenas

```zig
// Parsear flotantes
const float_val = ZNumber.parseFloat("3.14159");

// Parsear enteros con diferentes bases
const decimal = try ZNumber.parseInt("42", 10);
const hex = try ZNumber.parseInt("0xFF", null);  // auto-detectar
const binary = try ZNumber.parseInt("1010", 2);
```

### Valores Especiales

```zig
// Trabajar con NaN
if (ZNumber.isNaN(some_value)) {
    std.debug.print("El valor es NaN\n", .{});
}

// Trabajar con Infinity
const inf = Constants.POSITIVE_INFINITY;
const is_finite = ZNumber.isFinite(inf);  // false
```

## Contribuir

¡Las contribuciones son bienvenidas! Por favor asegúrate de:
1. Que todas las pruebas pasen: `zig build test`
2. El código siga las guías de estilo de Zig
3. Las nuevas características incluyan pruebas
4. La documentación esté actualizada

## Licencia

Licencia MIT - ver el archivo LICENSE para detalles

## Agradecimientos

Construido con Zig 0.15 para máximo rendimiento y seguridad. Diseñado para ser un componente central de motores JavaScript modernos.

---

Hecho con ❤️ para la comunidad Zig
