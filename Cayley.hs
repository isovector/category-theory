{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GADTs         #-}
{-# LANGUAGE RankNTypes    #-}
{-# LANGUAGE TypeOperators #-}

module Cayley where

import Data.Profunctor
import Data.Functor.Contravariant
import Control.Category
import Prelude hiding (id, (.))

newtype Cayley a b = Cayley (forall x. (x -> a) -> x -> b)

instance Category Cayley where
  id = Cayley id
  Cayley f . Cayley g = Cayley $ f . g

instance Functor (Cayley a) where
  fmap f (Cayley g) = Cayley $ (fmap . fmap) f g

instance Profunctor Cayley where
  dimap f g c = liftCayley g . c . liftCayley f

liftCayley :: (a -> b) -> Cayley a b
liftCayley f = Cayley (f .)

lowerCayley :: Cayley a b -> (a -> b)
lowerCayley (Cayley f) = f id

toCayley :: x -> Cayley () x
toCayley x = liftCayley $ const x

fromCayley :: Cayley () a -> a
fromCayley c = lowerCayley c ()

