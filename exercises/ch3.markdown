# Chapter 3 Exercises

## 3.5.1

> In any category `C`, show that
>
> `A -c1> C <c2- B`
>
> is a coproduct diagram just if for every object Z, the map
>
> ```
> Hom(C,Z) -> Hom(A,Z) x Hom(B,Z)
> f |-> <f o c1, f o c2>
> ```
>
> is an isomorphism. Do this by using duality, taking the corresponding fact
> about products as given.


A product diagram `A <p1- X -p2> B` in `C` corresponds to an isomorphism:

```
Hom(Z,C) -> Hom(Z,A) x Hom(Z,B)
f |-> <p1.f, p2.f>
```

which in Haskell is:

```haskell
there :: (z -> (a, b)) -> (z -> a, z -> b)
there f = (fst . f, f . snd)

back :: (z -> a, z -> b) -> (z -> (a, b))
back (f, g) z = (f z, g z)
```

We can get a corresponding claim about coproducts by reversing all of our
arrows:

A *co-*product diagram `A -i1> X <i2- B` in `C` corresponds to an isomorphism:

```
Hom(C,Z) <- Hom(A,Z) x Hom(B,Z)
```

Recall that hom-sets are sets of morphisms in `C`, so they must be flipped as
well.

Isomorphisms by definition are in both directions, so we can reclaim our
original iso by flipping its arrow:

```
Hom(C,Z) ->  Hom(A,Z) x Hom(B,Z)
```

and by flipping our composition (by definition of the duality construction):

`f |-> <f . i1, f . i2>`



## 3.5.2

> Show in detail, the free monoid functor M preserves coproducts: for any sets
> `A`, `B`,
>
> ```
> M(A) + M(B) ~ M(A + B)
> ```
>
> Do this as indicated in the text by using the UMPs of the coproduct `A+B` and
> `M(A) + M(B)` and of free monoids.

```haskell
newtype FreeM a = FreeM { foldM :: forall m. Monoid m => (a -> m) -> m }

instance Monoid (FreeM a) where
  mempty = FreeM $ const mempty
  mappend (FreeM a) (FreeM b) = FreeM $ liftA2 mappend a b

lift :: a -> FreeM a
lift a = FreeM ($ a)
```

Functors preserve coproducts, and `FreeM` is a functor:

```haskell
instance Functor FreeM where
  fmap f = FreeM . lmap (lmap f) . foldM
```




