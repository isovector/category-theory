{-# LANGUAGE ConstraintKinds   #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE KindSignatures    #-}
{-# LANGUAGE PolyKinds         #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TypeApplications  #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeInType        #-}

module Functor where

import Control.Category
import Data.Functor.Compose
import Data.Kind (Type)
import Prelude hiding (Functor (..), id, (.))


type family Cat k :: k -> k -> Type

type Catty a = Category (Cat a)

class (Catty j, Catty k) => Functor (f :: j -> k) where
  fmap :: Cat j a b -> Cat k (f a) (f b)

type instance Cat Type = (->)

instance Functor Maybe where
  fmap _ Nothing  = Nothing
  fmap f (Just a) = Just (f a)

instance Functor ((,) a) where
  fmap f (a, b) = (a, f b)

instance Functor [] where
  fmap = map

instance Functor (Either a) where
  fmap _ (Left a)  = Left a
  fmap f (Right b) = Right $ f b

instance Functor ((->) a) where
  fmap = (.)

instance (Functor f, Functor g) => Functor (Compose f g) where
  fmap f = Compose . fmap (fmap f) . getCompose



newtype Natural (cat :: k -> k -> Type) (f :: j -> k) (g :: j -> k) = Natural
  { runNatural :: forall x. cat (f x) (g x)
  }

type instance Cat (j -> k) = Natural (Cat k)

instance Category k => Category (Natural k) where
  id = Natural id
  Natural f . Natural g = Natural (f . g)


instance Functor (,) where
  fmap f = Natural $ \(a, x) -> (f a, x)

instance Functor Either where
  fmap f = Natural $ either (Left . f) Right

instance Functor f => Functor (Compose f) where
  fmap f = Natural $ Compose . fmap (runNatural f) . getCompose

fmap1 :: (Catty j, Catty k, Functor f) => Cat j a b -> Cat k (f a x) (f b x)
fmap1 = runNatural . fmap


instance Functor Compose where
  fmap f = Natural $ Natural $ Compose . runNatural f . getCompose

fmap2 :: (Catty j, Catty k, Functor f) => Cat j a b -> Cat k (f a x y) (f b x y)
fmap2 = runNatural . runNatural . fmap


class (Catty j, Catty k) => Contravariant (f :: j -> k) where
  contramap :: Cat j a b -> Cat k (f b) (f a)

instance Contravariant (->) where
  contramap g = Natural (. g)

instance (Catty k, cat ~ Cat k) => Contravariant (Natural cat) where
  contramap g = Natural (. g)


