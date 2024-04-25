# App('x','y')
# Abs('x','x')

class App:
    def __init__(self, func, arg):
        self.func = func
        self.arg  = arg
    def __repr__(self):
        return '{0}({1})'.format(self.func,self.arg)

class Abs:
    def __init__(self, var, body):
        self.var = var
        self.body = body
    def __repr__(self):
        return 'lambda {0}: {1}'.format(self.var,self.body)

class Arrow:
    def __init__(self, arg, result):
        self.arg = arg
        self.result = result
    def __repr__(self):
        if isinstance(self.arg, Arrow):
            return '({0}) ⇒ {1}'.format(self.arg, self.result)
        else:
            return '{0} ⇒ {1}'.format(self.arg, self.result)

lastid = 0

# генериране на свежа променлива
def gensym(var):
    global lastid
    lastid += 1
    return var + str(lastid)

def modify(ξ, x, a):
    return lambda y: a if x == y else ξ(y)

def evaluate(M, ξ):
    if isinstance(M, App):
        return evaluate(M.func, ξ)(evaluate(M.arg, ξ))
    if isinstance(M, Abs):
        return lambda a: evaluate(M.body, modify(ξ, M.var, a))
    else:
        return ξ(M)

def reflect(τ, M):
    if isinstance(τ, Arrow):
        return lambda a: reflect(τ.result, App(M, reify(τ.arg, a)))
    else:
        return M

def reify(τ, a):
    if isinstance(τ, Arrow):
        x = gensym('x')
        return Abs(x, reify(τ.result, a(reflect(τ.arg, x))))
    else:
        return a

def nbe(τ, M):
    return reify(τ, evaluate(M, lambda x: None))

id = Abs('x', 'x')

print(nbe(Arrow('α', 'α'), id))
print(nbe(Arrow(Arrow('α', 'α'),Arrow('α', 'α')), id))

print(nbe(Arrow('α', 'α'), Abs('x', App(id, 'x'))))

def repeated(f, x, n):
    if n == 0:
        return x
    return repeated(f, App(f, x), n-1)

def c(n):
    return Abs('f', Abs('x', repeated('f', 'x', n)))

# cplus = lambda m: lambda n: lambda f: lambda x: m(f)(n(f)(x))
plus = Abs('m', Abs('n', Abs('f', Abs('x', App( App('m', 'f'), App(App('n', 'f'), 'x'))))))
tn = Arrow(Arrow('α', 'α'),Arrow('α', 'α'))

print(nbe(tn, App(App(plus, c(5)), c(8))))
