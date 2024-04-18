type B = Bool
type N = Int

s :: N -> N
s = (+1)

split :: (a, b) -> (a -> b -> c) -> c
split (s,t) f = f s t

cases :: B -> a -> a -> a
cases True  s t = s
cases False s t = t


r :: N -> a -> (N -> a -> a) -> a
r 0 s t = s
r n s t = t n' (r n' s t)
  where n' = n - 1

plus :: N -> N -> N
-- n' ~ n - 1
-- p ~ plus m (n - 1)
-- plus m n = r m n (\_ p -> s p)
plus m n = r m n (const s)

-- f n = _r_n_s_t_ ~
-- f n = if (n == 0) then s else t (n-1) (f (n-1))

mult :: N -> N -> N
-- n' ~ n - 1
-- p ~ mult m (n - 1)
--mult m n = r m 0 (\n' p -> plus n p)
mult m n = r m 0 (const (plus n))

-- eq :: N -> N -> B
-- eq = ?
