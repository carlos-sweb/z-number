// Fetch only the pinned selection. Explicit maintenance command; never used by zig build test.
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
const selection = JSON.parse(readFileSync(new URL('test262-selection.json', import.meta.url), 'utf8'));
const destination = resolve(process.argv[2] ?? '/tmp/z-number-test262');
mkdirSync(destination, {recursive:true});
for (const [i,path] of selection.paths.entries()) {
  const response = await fetch(`https://raw.githubusercontent.com/tc39/test262/${selection.commit}/${path}`);
  if (!response.ok) throw new Error(`${path}: HTTP ${response.status}`);
  writeFileSync(resolve(destination,`${i}.js`), await response.text());
}
console.log(`Fetched ${selection.paths.length} tests at ${selection.commit} to ${destination}`);
