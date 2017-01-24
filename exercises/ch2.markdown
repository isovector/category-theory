## Chapter 2 Excercises

### 2.8.1

> Show that a function between sets is an epimorphism if and only if it is
> surjective.

TODO


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

