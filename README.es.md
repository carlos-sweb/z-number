# Z-Number

Implementación de Number compatible con ECMAScript en Zig 0.16

[![Zig 0.16](https://img.shields.io/badge/Zig-0.16-orange.svg)](https://ziglang.org/)
[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)

> Una biblioteca lista para producción que implementa el objeto Number de JavaScript en Zig, diseñada como componente central para motores JavaScript (como Bun/QuickJS).

Español | [English](README.md)

## Características

- **Formateo exacto según el spec**: `toString`/`toFixed`/`toExponential`/`toPrecision` se implementan con generación de dígitos de precisión arbitraria (bignum) — no formateo estilo `printf` — de modo que el redondeo y la representación "shortest round-trip" coinciden exactamente con un motor JS real, incluyendo bases 2-36 para `toString`.
- **Parsing exacto según el spec**: `Number.parseInt`/`Number.parseFloat` consumen el *prefijo válido más largo* e ignoran el resto, igual que en JS, en vez de exigir que toda la cadena sea válida.
- **`ToInt32`/`ToUint32` exactos según el spec**: `toI32`/`toU32` nunca fallan — hacen wrap-around módulo 2^32 como `| 0` / `>>> 0` en JS, en vez de lanzar error en overflow.
- **Cumple con IEEE 754**: Manejo correcto de NaN, Infinity, -Infinity y valores especiales
- **Zig Moderno**: Escrito para Zig 0.16 con labeled blocks y mejores prácticas
- **Pruebas Exhaustivas**: 200+ tests, incluyendo miles de vectores generados y verificados contra la salida real de Node.js/V8
- **Listo para Producción**: Diseñado para uso en motores JavaScript

### Alcance

Esta librería implementa las constantes de Number de ECMA-262 §21.1, los
métodos estáticos (`isFinite`/`isInteger`/`isNaN`/`isSafeInteger`/`parseInt`/`parseFloat`)
y los métodos de formateo de `Number.prototype`, operando sobre los tipos
nativos de Zig `f64`/`i64`/strings. **No** implementa la coerción `ToNumber`
del constructor `Number` desde otros tipos de valor JS (booleanos, `null`,
`undefined`, objetos) — no existe aquí un tipo "valor JS dinámico" del cual
coercionar, solo números, enteros y strings.

Para `toString(radix)` con `radix != 10`, ECMA-262 no exige un algoritmo
exacto de generación de dígitos (solo el `toString` decimal es normativo ahí).
Esta librería siempre produce una representación *correcta y exactamente
reversible*, calculada como la secuencia de dígitos más corta verdadera —
para valores fraccionarios o enteros más allá de 2^53 esto puede diferir
ocasionalmente en uno o dos dígitos de la salida propia (no normativa, y no
siempre mínima) de un motor específico, aunque ambas siguen siendo
representaciones válidas del mismo valor.

## Inicio Rápido

```zig
const std = @import("std");
const ZNumber = @import("znumber").ZNumber;
const Constants = @import("znumber").Constants;

pub fn main() !void {
    
    var gpa:std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();     
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

```sh
zig fetch --save git+https://github.com/carlos-sweb/z-number.git
```

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

#### Number.parseInt(allocator: Allocator, str: []const u8, radix: ?u8) f64

Parsea una cadena a un número con base opcional. Igual que en JS, consume el
prefijo de dígitos válidos más largo e ignora el resto, y devuelve `NaN`
—nunca un error— ante una entrada inválida:

```zig
ZNumber.parseInt(allocator, "42", 10)      // 42
ZNumber.parseInt(allocator, "0xFF", null)  // 255 (auto-detecta hex)
ZNumber.parseInt(allocator, "1010", 2)     // 10
ZNumber.parseInt(allocator, "42px", 10)    // 42 (se detiene en el primer dígito inválido)
ZNumber.parseInt(allocator, "abc", 10)     // NaN
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

try num.toInt()   // 42 (i64) — utilidad de conveniencia, no forma parte de ECMA-262; lanza error en NaN/Infinity/overflow
try num.toUint()  // 42 (u64) — igual que arriba
num.toI32()       // 42 (i32) — ToInt32 de ECMA-262; nunca falla, hace wrap mod 2^32 como `x | 0`
num.toU32()       // 42 (u32) — ToUint32 de ECMA-262; nunca falla, hace wrap mod 2^32 como `x >>> 0`
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
- Constantes, métodos estáticos, métodos de instancia, validación, conversión, casos edge y cumplimiento IEEE 754 (escritos a mano, ~190 tests)
- Vectores de formateo, parsing y `ToInt32`/`ToUint32` **generados y verificados contra la salida real de Node.js/V8** (`tests/*_vectors_test.zig`) — miles de aserciones individuales cubriendo `toString` (base 2-36), `toFixed`, `toExponential`, `toPrecision`, `parseInt`, `parseFloat` y coerción de enteros, sobre casos límite curados y doubles aleatorios

**Total: 200+ tests de primer nivel (miles de aserciones), todos pasando**

## Detalles de Implementación

### Bloques Etiquetados (Labeled Blocks)

Z-Number usa bloques etiquetados extensivamente (10+ lugares) para un flujo de control claro:

```zig
pub fn isFinite(value: f64) bool {
    finite_checker: {
        if (std.math.isNan(value)) {
            return false;
        }
        if (std.math.isInf(value)) {
            return false;
        }
        break :finite_checker;
    }
    return true;
}
```

### Manejo de Errores

Tipos de error comprehensivos para todos los modos de falla:

```zig
pub const ZNumberError = error{
    OutOfMemory,
    InvalidNumber,
    RangeError,
    Overflow,
    Underflow,
};
```

Nota: las operaciones propias de ECMA-262 (`toI32`/`toU32`/`parseInt`/`parseFloat`)
nunca devuelven estos errores — hacen wrap o devuelven `NaN` como en JS.
`RangeError` solo se usa para argumentos fuera del rango que exige el spec
(p. ej. `toFixed(101)`), y `Overflow`/`Underflow`/`InvalidNumber` solo los usan
las utilidades de conveniencia de 64 bits (`toInt`/`toUint`), que no son parte
de ECMA-262.

## Estructura del Proyecto

```
z-number/
├── src/
│   ├── znumber.zig         # Estructura principal ZNumber
│   ├── constants.zig       # Constantes de Number
│   ├── errors.zig          # Tipos de error
│   ├── bignum.zig          # Generación de dígitos de precisión arbitraria (estilo Dragon4)
│   ├── formatting.zig      # Métodos de formateo (toString/toFixed/toExponential/toPrecision)
│   ├── parsing.zig         # Métodos de parsing (parseInt/parseFloat)
│   ├── validation.zig      # Métodos de validación
│   └── conversion.zig      # Conversiones de tipos (incl. ToInt32/ToUint32)
├── tests/
│   ├── constants_test.zig
│   ├── static_test.zig
│   ├── formatting_test.zig
│   ├── parsing_test.zig
│   ├── validation_test.zig
│   ├── conversion_test.zig
│   ├── edge_cases_test.zig
│   ├── ieee754_test.zig
│   ├── formatting_vectors_test.zig      # generado desde la salida real de V8
│   ├── parsing_vectors_test.zig         # generado desde la salida real de V8
│   └── int_conversion_vectors_test.zig  # generado desde la salida real de V8
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
const decimal = ZNumber.parseInt(allocator, "42", 10);
const hex = ZNumber.parseInt(allocator, "0xFF", null);  // auto-detectar
const binary = ZNumber.parseInt(allocator, "1010", 2);
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

Construido con Zig 0.16 para máximo rendimiento y seguridad. Diseñado para ser un componente central de motores JavaScript modernos.

---

Hecho con ❤️ para la comunidad Zig
