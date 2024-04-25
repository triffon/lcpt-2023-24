type B = Bool
type N = Int

s :: N -> N
s = (+1)

tt = True
ff = False

split :: (a, b) -> (a -> b -> c) -> c
split (s,t) f = f s t

cases :: B -> a -> a -> a
cases True s t = s
cases False s t = t

r :: N -> a -> (N -> a -> a) -> a
r 0 s t = s
r n s t = t n' (r n' s t)
  where n' = n - 1

----------------------------------------

plus :: N -> N -> N
-- n' ~ n - 1
-- p ~ plus (m - 1) n
-- plus m n = r m n (\_ p -> s p)
plus m n = r m n (const s)

plus' :: N -> N -> N
-- n' ~ n - 1
-- p ~ plus (m - 1)
-- plus m n = r m n (\_ p -> s p)
plus' m = r m id (\_ p n -> s (p n))


-- f n = _r_n_s_t_ ~
-- f n = if (n == 0) then s else t (n-1) (f (n-1))

mult :: N -> N -> N
-- n' ~ n - 1
-- p ~ mult (m - 1) n
--mult m n = r m 0 (\n' p -> plus n p)
mult m n = r m 0 (const (plus n))

mult' :: N -> N -> N
-- p ~ mult (m - 1)
mult' m = r m (const 0) (\_ p n -> plus n (p n))

ifzero :: N -> a -> a -> a
ifzero n s t = r n s (\_ _ -> t) 

eq :: N -> N -> B
-- p ~ eq (m - 1) n 
-- eq m n = r m (ifzero n tt ff) (\m' p -> ...)

-- p ~ eq (m - 1)
-- q ~ eq m (n - 1)
eq m = r m (\n -> ifzero n tt ff)
           (\m' p n -> r n ff (\n' _ -> p n'))

{-
eq 0 0 = tt
eq 0 m = ff
eq n m = eq (n-1) (m-1)
-}
