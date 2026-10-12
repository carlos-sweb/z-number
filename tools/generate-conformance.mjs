// Deterministic binary64 differential corpus. No network or package dependencies.
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
const root = fileURLToPath(new URL('../', import.meta.url));
const count = 10_000;
const seed = 0x7a6e756d62657217n;
let state = seed;
const mask = (1n << 64n) - 1n;
function next() {
  state = (state + 0x9e3779b97f4a7c15n) & mask;
  let v = state;
  v = ((v ^ (v >> 30n)) * 0xbf58476d1ce4e5b9n) & mask;
  v = ((v ^ (v >> 27n)) * 0x94d049bb133111ebn) & mask;
  return (v ^ (v >> 31n)) & mask;
}
const buffer = new ArrayBuffer(8);
const view = new DataView(buffer);
function fromBits(v) { view.setBigUint64(0, v); return view.getFloat64(0); }
function bits(v) {
  if (Number.isNaN(v)) return 'nan';
  view.setFloat64(0, v); return view.getBigUint64(0).toString(16).padStart(16, '0');
}
const edge = [0n, 0x8000000000000000n, 1n, 0x8000000000000001n, 0x7fefffffffffffffn, 0xffefffffffffffffn, 0x7ff0000000000000n, 0xfff0000000000000n, 0x7ff8000000000042n];
const rows = [];
for (let i = 0; i < count; i++) {
  const xb = i < edge.length ? edge[i] : next();
  const yb = i < edge.length ? edge[edge.length - 1 - i] : next();
  const x = fromBits(xb), y = fromBits(yb);
  const digits = [0, 1, 2, 6, 17, 50, 100][i % 7];
  const precision = [1, 2, 6, 17, 50, 100][i % 6];
  const numeric = [x+y, x-y, x*y, x/y, x%y, -x, ~x, x&y, x|y, x^y, x<<y, x>>y, x>>>y,
    x|0, x>>>0, new Int8Array([x])[0], new Uint8Array([x])[0], new Int16Array([x])[0], new Uint16Array([x])[0], new Uint8ClampedArray([x])[0],
    Number.isNaN(x) || x === 0 ? 0 : Math.trunc(x)];
  numeric.push(Math.min(Math.max(numeric[numeric.length-1], 0), Number.MAX_SAFE_INTEGER));
  const booleans = [x===y, x<y, x>y, Object.is(x,y), x===y || (Number.isNaN(x)&&Number.isNaN(y)), Number.isFinite(x), Number.isInteger(x), Number.isNaN(x), Number.isSafeInteger(x)];
  const formatting = [x.toString(), x.toFixed(digits), x.toExponential(digits), x.toPrecision(precision), x.toExponential()];
  rows.push([xb.toString(16).padStart(16,'0'), yb.toString(16).padStart(16,'0'), digits, precision,
    ...numeric.map(bits), ...booleans.map(v=>v?'1':'0'), ...formatting].join('\t'));
}
mkdirSync(resolve(root,'tests/data'), {recursive:true});
writeFileSync(resolve(root,'tests/data/conformance.tsv'), rows.join('\n')+'\n');
writeFileSync(resolve(root,'tests/data/conformance-manifest.json'), JSON.stringify({schema:1, generator:'tools/generate-conformance.mjs', node:process.version, v8:process.versions.v8, seed:'0x'+seed.toString(16), algorithm:'SplitMix64', patterns:count, numericResults:22, booleanResults:9, formatResults:5, standard:'ECMA-262 edition 17 (2026)', policy:'NaN by category; other numeric results by binary64 bits. V8 strings are a differential oracle, including the recommended nearest-even shortest representation.'},null,2)+'\n');
console.log(`Generated ${count} deterministic binary64 patterns`);
// Exact integer oracle via BigInt avoids implementation-permitted parseInt approximation.
const parsingRows = [];
for (let i = 0; i < 1000; i++) {
  const base = 2 + i % 35;
  const length = 1 + i % 350;
  let integer = 0n, digits = '';
  for (let j = 0; j < length; j++) {
    const d = Number(next() % BigInt(base));
    digits += d.toString(36);
    integer = integer * BigInt(base) + BigInt(d);
  }
  const negative = i % 2 === 1;
  const prefix = '\u00a0' + (negative ? '-' : '+') + digits;
  const result = negative ? -Number(integer) : Number(integer);
  parsingRows.push(['parseInt', Buffer.from(prefix+'!suffix').toString('hex'), bits(base+0.75), bits(result)].join('\t'));
  if ([2,8,16].includes(base)) {
    const input = ' \ufeff0' + ({2:'b',8:'o',16:'x'}[base]) + digits + '\u2029';
    parsingRows.push(['number',Buffer.from(input).toString('hex'),'omitted',bits(Number(integer))].join('\t'));
  }
  // Long decimal mantissas and exponents exercise parsing beyond shortest strings.
  const decimal = (negative ? '-' : '+') + '1234567890'.repeat(1+i%30) + '.' + '9876543210'.repeat(1+i%10) + 'e' + (i%700-350);
  parsingRows.push(['number', Buffer.from(decimal).toString('hex'), 'omitted',bits(Number(decimal))].join('\t'));
  parsingRows.push(['parseFloat',Buffer.from('\ufeff'+decimal+'suffix').toString('hex'),'omitted',bits(parseFloat(decimal))].join('\t'));
}
writeFileSync(resolve(root,'tests/data/parsing-conformance.tsv'),parsingRows.join('\n')+'\n');
const manifestPath = resolve(root,'tests/data/conformance-manifest.json');
// The manifest describes both corpora; generation always resets SplitMix64 first.
const manifest = JSON.parse(readFileSync(manifestPath,'utf8'));
manifest.parsingCases = parsingRows.length;
manifest.integerOracle = 'Number(BigInt exact digit accumulation), nearest-even; stronger than implementation-permitted parseInt approximations';
writeFileSync(manifestPath,JSON.stringify(manifest,null,2)+'\n');
console.log(`Generated ${parsingRows.length} long-string parsing cases`);
