{-# LANGUAGE RankNTypes #-}

module FreeM where

import Control.Monad
import Data.Profunctor

newtype FreeM a = FreeM { foldM :: forall m. Monoid m => (a -> m) -> m }

instance Monoid (FreeM a) where
  mempty = FreeM $ const mempty
  mappend (FreeM a) (FreeM b) = FreeM $ liftM2 mappend a b

lift :: a -> FreeM a
lift a = FreeM ($ a)

instance Functor FreeM where
  fmap f (FreeM fm) = FreeM $ lmap (lmap f) fm

