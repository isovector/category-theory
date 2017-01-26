## Chapter 2 Excercises

### 2.8.2

> Show that in a poset category, all arrows are both monic and epic.

In a poset category, there is exactly one arrow between any two objects. The
mono and epi laws are thus satisfied trivially.


### 2.8.3

> If an arrow `f : A -> B` has inverses `g, g' : B -> A`, then `g = g'`.

`f` has an inverse, so it is an iso. Every iso is an epi and a mono. Therefore

```
fg = id_B = fg'
```

`f` is mono

Therefore, `g = g'`


### 2.8.4

> With regard to a commutative triangle `A -f> B -g> C` given `h = gf`, show:

#### if `f` and `g` are isos, so is `h`

`f` and `g` being isos means we have `f^-1` and `g^-1`. Let `h^-1 = f^-1 g^-1`.
This forms an inverse with `h`, so `h` is an iso.


#### if `h` is monic, so is `f`

Given some `x, y : X -> A` if `fx = fy` then via commutivity `gfx = gfy`. Since
`h = gf`, we have `hx = hy`. But `h` is monic, so `x = y`.

Because we have proven `x = y` from `fx = fy`, `f` is monic.


#### if `h` is epi, so is `g`

Dual to above.


#### if `h` is monic, `g` need not be

By example.  In `Hask`:

```haskell
f :: Int -> Int
f = (* 2)

g :: Int -> Int
g x = floor (fromIntegral x / 2)

h :: Int -> Int
h = g . f
```

`h` is injective (monic), but only because `f` limits the domain of `g` (which
is not injective).



### 2.8.5

> Show that the following are equivalent for an arrow `f : A -> B` in any
> category:

By reduction to an isomorphism with `g` as the inverse to `f`:

#### `f` is an iso

`f` is an iso. Duh.


#### `f` is both a mono and a split epi

The split epicness of `f` means we have some `g : B -> a` such that `fg = 1_B`.

This is the first half of the isomorphism. Need to show `gf = 1_A`:

1. `fg = 1_B` (definition of split epi)
2. `fgf = 1_B f` (right compose with `f`)
3. `fgf = 1_B f 1_A` (make identity explicit)
4. `fgf = f 1_A` (hide explicit identity)
5. `gf = 1_A` (`f` is monic)

Therefore `f` being a mono and split epi implies `f` is an iso.

**Other direction:**

`f` is an iso. All isos are mono and epi, so `f` is a mono.

To be a split epi, `f` must have a right inverse such that `fg = 1_B`, but this
is just `g`.


#### `f` is both a split mono and an epi

Dual to above.


#### `f` is both a split mono and a split epi

`f` being a split mono and a split epi means it has both left and right inverses
equal to `1_A` and `1_B` respectively. But these are both just `g`.


### 2.8.6

> Show that a homomorphism `h : G -> H` of graphs is monic just if it is
> injective on both edges and vertices.

Because a graph `G = (V, E)`, for sets `V : Set`, `E : VxV`, it can be modeled
as a product of the form `(V, VxV) : Set`. A graph homomorphism is thus some `f
: (V, VxV) -> (V', V'xV')` in Set.

Graphs are products in the category `Set`, so we can construct a pointwise
product diagram over them:

<pre>
       (V ,  VxV)
   f /    | &lt;f,g&gt;  \ g
   .      v          .
V' <- (V' ,  V'xV') -> V'xV'
</pre>

By 2.8.4, we know that if `f` is monic, the first half of the pointwise `h =
<f,g>` is monic. Likewise for `g`. Therefore `h` is monic only if `f` and `g`
are monic.

TODO: Other direction.



### 2.8.13

> Any any category with binary products, show directly that `Ax(BxC) ~ (AxB)xC`.

By diagram chasing:

<pre>
         Ax(BxC)
</pre>

<pre>
 A &lt;- Ax(BxC) -&gt; BxC
</pre>

<pre>
 A &lt;- Ax(BxC) -&gt; BxC -&gt; C
                  |
                  v
                  B
</pre>

<pre>
 A &lt;- Ax(BxC) -&gt; BxC -&gt; C
   .              |
     \            v
        AxB  -&gt;   B
</pre>

<pre>
 A &lt;- Ax(BxC) -&gt; BxC -&gt; C
   .     :        |
     \   v        v
        AxB  -&gt;   B
</pre>

Eliding intermediate parts of the diagram, we now have:

<pre>
         Ax(BxC) -&gt; C
         |
         v
        AxB
</pre>

And therefore because we have binary products, we get the product diagram:

<pre>
       Ax(BxC)
     /    :    \
   .      v      .
AxB &lt;- (AxB)xC -&gt; C
</pre>

The other side of the iso is similar.


### 2.8.15

> Given a category `C` with objects `A` and `B`, define the category `C_{A,B}`
> to have objects `{(X, x1, x2) | x1 : X -> A, x2 : X -> B}` and arrows
> `f : (X, x1, x2) -> (Y, y1, y2)` for `f : X -> Y` with `y1 f = x1` and
> `y2 f = x2`.
>
> Show that `C_{A,B}` has a terminal object just in case `A` and `B` have a
> product in `C`.

We can draw the image of `f : C_{A,B}` in `C`:

<pre>
       X
    /  |  \
  x1   f   x2
 .     v     .
A &lt;y1- Y -y2&gt; B
</pre>

This looks suspiciously like a product diagram. Assume there exists a terminal
object `(Z, z1, z2)` in `C_{A,B}`. In `C`, it looks like this:

<pre>
A &lt;z1- Z -z2&gt; B
</pre>

Additionally, if `Z` is terminal in `C_{A,B}`, there must be a unique arrow
`! : X -> Z` for all `X : C_{A,B}` (definition of terminal object). In `C` this
is exactly equivalent to the product diagram:

<pre>
     X
  /  :  \
 .   v   .
A &lt;- Z -&gt; B
</pre>

which is the definition of the product `AxB`.


### 2.8.16

> In the category of types `C(λ)` of the λ-calculus, determine the product
> functor `A,B |-> AxB` explicitly. Also show that, for any fixed type `A`,
> there is a functor `A -> (-) : C(λ) -> C(λ)` taking any type `X` to `A -> X`.

Boring. In `Hask` (`C(λ)`):

```haskell
data Pair a b = Pair a b

instance Bifunctor Pair where
  dimap :: (a -> c) -> (b -> d) -> Pair a b -> Pair c d
  dimap f g (Pair a b) = Pair (f a) (g b)

toPair :: Pair a b -> (a, b)
toPair (Pair a b) = (a, b)
```

Also:

```haskell
instance Functor ((->) a) where
  fmap :: (x -> y) -> (->) a x -> (->) a y
  fmap xy ax = \a -> xy (ax a)
```


### 2.8.18

> Show that the forgetful functor `U : Mon -> Sets` from monoids to sets is
> representable.

From wikipedia:

> A functor `F : C -> Set` is said to be representable if it is naturally
> isomorphic to Hom(A,–) for some object A of C.

With this in mind, we can set up the `Representable` machinery:

```haskell
class Representable f where
  type Repr f :: *
  fromFunctor :: forall x. f x -> Repr f -> x
  toFunctor   :: forall x. (Repr f -> x) -> f x
```

and a `Forgetful` functor over monoids:

```haskell
data Forgetful a where
  Forget :: Monoid m => m -> Forgetful m

-- notice there is no 'Monoid' instance for 'Forgetful' :)
```

The only distinguished monoid I can think of is the free monoid `[a]`. But over
what generator `a`?

`a` is some set. So what distinguished sets do we have? We have an initial
object `{}` (the empty set). But there is no non-trivial monoid over this.

We also have the terminal object in the category of sets, which is any singleton
set. Let's try that.

Notice that `[()] ~ Nat`, so let's use `Nat` instead,

```haskell
instance Representable Forgetful where
  type Repr Forgetful = Nat
  fromFunctor (Forget _) 0 = mempty
  fromFunctor (Forget m) n = mconcat $ replicate n m
  toFunctor f = f 1
```

