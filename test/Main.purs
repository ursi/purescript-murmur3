module Test.Main where
import MasonPrelude
import Test.Assert (assert)
import Murmur3 (hash)

main :: Effect Unit
main = assert $ hash 0 "murmur" == 1945310157
