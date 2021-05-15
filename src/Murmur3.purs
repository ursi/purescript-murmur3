module Murmur3 (hash) where

import Prelude

import Data.Function.Uncurried (Fn2, runFn2)

foreign import hashImpl :: Fn2 String Int Int

hash :: Int -> String -> Int
hash = flip $ runFn2 hashImpl
