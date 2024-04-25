type B = Bool
type N = Int

s :: N -> N
s = (+1)

p :: N -> N
p 0 = 0
p n = n - 1

z :: N -> B
z = (==0)

tt = True
ff = False

split :: (a, b) -> (a -> b -> c) -> c
split (s,t) f = f s t

cases :: B -> a -> a -> a
cases True s t = s
cases False s t = t

y :: (a -> a) -> a
y t = t (y t)

----------------------------------------

gammaplus :: (N -> N -> N) -> N -> N -> N
gammaplus plus m n = cases (z m) n (s (plus (p m) n))
{-
plus 0 n = n
plus m n = s (plus (m-1) n)
-}

plus :: N -> N -> N
plus = y gammaplus

gammaplus' :: N -> (N -> N) -> N -> N
gammaplus' m plusm n = cases (z n) m (s (plusm (p n)))
{-
plus' m 0 = m
plus' m n = s (plus' m (n-1))
-}

plus' :: N -> N -> N
plus' m = y (gammaplus' m)
