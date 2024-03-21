id = lambda x: x
k  = lambda x: lambda y: x

def repeated(n,f,x):
    if n == 0:
        return x
    else:
        return f(repeated(n - 1, f, x))

def c(n):
    return lambda f: lambda x: repeated(n, f, x)

c0 = c(0)
c1 = c(1)

cs = lambda n: lambda f: lambda x: f(n(f)(x))

css = lambda n: lambda f: lambda x: n(f)(f(x))

def toint(cn):
    return cn(lambda x:x+1)(0)

cplus = lambda m: lambda n: lambda f: lambda x: m(f)(n(f)(x))

cplusplus = lambda m: m(cs)

cmult = lambda m: lambda n: lambda f: m(n(f))

cmultmult = lambda m: lambda n: m(cplus(n))(c0)

cexpexp = lambda m: lambda n: n(cmult(m))(c1)

cexp = lambda m: lambda n: n(m)

cTrue  = k
cFalse = lambda x: id

cif = id

cnot = lambda b: lambda x: lambda y: b(y)(x)

cand = lambda b: lambda c: b(c)(b)
cor  = lambda b: lambda c: b(b)(c)

def tobool(cb):
    return cb(True)(False)

czero = lambda n: n(k(cFalse))(cTrue)

ceven = lambda n: n(cnot)(cTrue)

cpair  = lambda x: lambda y: lambda z: z(x)(y)
cleft  = lambda p: p(cTrue)
cright = lambda p: p(cFalse)

def tointpair(cp):
#    return (toint(cleft(cp)),toint(cright(cp)))
    return cp(lambda x: lambda y: (toint(x), toint(y)))

cp = lambda n: \
        cright(n(lambda p: \
                   cpair(cs(cleft(p)))
                        (cleft(p)))
                (cpair(c0)(c0)))

cfact = lambda n: \
        cright(n(lambda p: \
                   cpair(cs(cleft(p)))
                        (cmult(cs(cleft(p)))(cright(p))))
                (cpair(c0)(c1)))

