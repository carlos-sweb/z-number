// Runs the pinned selected JS tests in isolated VMs and adapts primitive calls to Zig fixtures.
import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createHash } from 'node:crypto';
import vm from 'node:vm';
const root = fileURLToPath(new URL('../',import.meta.url));
const selection = JSON.parse(readFileSync(new URL('test262-selection.json', import.meta.url),'utf8'));
const directory = resolve(process.argv[2] ?? '/tmp/z-number-test262');
const view = new DataView(new ArrayBuffer(8));
function bits(value) {
  if (Number.isNaN(value)) return 'nan';
  view.setFloat64(0,value); return view.getBigUint64(0).toString(16).padStart(16,'0');
}
const records = [], sources = [];
let excludedCalls = 0;
for (const [i,path] of selection.paths.entries()) {
  const source = readFileSync(resolve(directory,`${i}.js`),'utf8');
  sources.push({path, sha256:createHash('sha256').update(source).digest('hex')});
  const context = vm.createContext({record(op,input,arg,result) {
    records.push([i, op, typeof input === 'string' ? Buffer.from(input).toString('hex') : bits(input),
      arg === undefined ? 'omitted' : bits(arg), typeof result === 'string' ? result : bits(result)].join('\t'));
  }, excluded() { excludedCalls++; }});
  vm.runInContext(`
    class Test262Error extends Error {}
    function assert(condition, message) { if (!condition) throw new Test262Error(message); }
    assert.sameValue = (actual, expected, message) => { if (!Object.is(actual,expected)) throw new Test262Error(message); };
    const NativeNumber = Number;
    for (const op of ['toFixed','toExponential','toPrecision','toString']) {
      const original = NativeNumber.prototype[op];
      NativeNumber.prototype[op] = function(arg) {
        'use strict';
        const result = Reflect.apply(original,this,arguments);
        const primitive = typeof this === 'number' ? this : this === NativeNumber.prototype ? 0 : undefined;
        if (primitive !== undefined && (typeof arg === 'number' || arg === undefined)) record(op,primitive,arg,result);
        else excluded();
        return result;
      };
    }
    Number = new Proxy(NativeNumber, {apply(target, receiver, args) {
      const result = Reflect.apply(target,receiver,args);
      if (typeof args[0] === 'string') record('number',args[0],undefined,result); else excluded();
      return result;
    }});
    for (const op of ['parseFloat','parseInt']) {
      const original = globalThis[op];
      globalThis[op] = function(input,arg) {
        const result = Reflect.apply(original,this,arguments);
        if (typeof input === 'string' && (typeof arg === 'number' || arg === undefined)) record(op,input,arg,result);
        else excluded();
        return result;
      };
    }
  `,context);
  vm.runInContext(source,context,{filename:path, timeout:5000});
}
writeFileSync(resolve(root,'tests/data/test262.tsv'),records.join('\n')+'\n');
writeFileSync(resolve(root,'tests/data/test262-manifest.json'),JSON.stringify({commit:selection.commit,node:process.version,tests:sources,adaptedCalls:records.length,excludedCalls,excluded:selection.excluded,policy:selection.policy},null,2)+'\n');
console.log(`Adapted ${records.length} calls from ${sources.length} passing Test262 sources; excluded ${excludedCalls} dynamic calls`);
