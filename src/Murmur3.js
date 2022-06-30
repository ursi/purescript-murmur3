import { murmur3 }  from "./purs-nix.js"

export const hashImpl = murmur3.murmurhash3_32_gc
