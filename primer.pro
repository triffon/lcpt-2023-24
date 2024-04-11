man(john).
woman(mary).

loves(john, mary).
loves(john, wine).
loves(mary, wine).
loves(john, X) :- loves(X, wine).

add(o, X, X).
add(s(X), Y, s(Z)) :- add(X, Y, Z).
