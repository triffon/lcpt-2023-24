:- set_prolog_flag(occurs_check, true).

% λ-термове

% x,y,z...
% λ(x,x)
% app(x,y)

isvar(X) :- atom(X).

i(λ(x,x)).
k(λ(x,λ(y,x))).
s(λ(x,λ(y,λ(z,app(app(x,z),app(y,z)))))).
ω(λ(x,app(x,x))).
o(app(W,W)) :- ω(W).
c(0,λ(f,λ(x,x))).
c(N,λ(f,λ(x,app(f,FN1X)))) :- N1 is N - 1, c(N1, λ(f,λ(x,FN1X))).

% прости типове

% α,β
% α ⇒ β

:- op(140, xfy, ⇒).

ti(α⇒α).
tk(α⇒β⇒α).
ts((α⇒β⇒γ)⇒(α⇒β)⇒α⇒γ).
nat((α⇒α)⇒α⇒α).
tab(α⇒β).
ty((α⇒α)⇒α).

% типови съждения
% M:τ
% M:(α⇒(β⇒γ))

:- op(150, xfx, :).
:- op(150, xfx, @).

% member(?X, ?L).

% контексти
% [x:α, y:β⇒α]

% релация на типизиране
% Γ ⊢ (M:τ)
% ⊢ M:τ

:- op(160, xfx, ⊢).
:- op(170, fx, ⊢).

% deconstruct(-Ρs, ?Τ, +Σ)    ↔      (Ρs ⇒ Τ) ≡ Σ

deconstruct([], T, T).
deconstruct([Ρ | Ρs], Τ, Ρ ⇒ Σ) :- deconstruct(Ρs, Τ, Σ).

% construct(+X, +Ms, -N)      ↔      N ≡ app(...app(app(X,M₁),M₂),...,Mₙ)

construct(X, [], X).
construct(X, [M | Ms], N) :- construct(app(X, M), Ms, N).

_ @ _ ⊢ [] : [].
V @ Γ ⊢ [M | Ms] : [Τ | Τs] :- V @ Γ ⊢ M : Τ, V @ Γ ⊢ Ms : Τs.

V @ Γ ⊢ λ(X,N) : Ρ ⇒ Σ  :- not(member(Ρ ⇒ Σ, V)), [Ρ ⇒ Σ | V] @ [X : Ρ | Γ] ⊢ N : Σ.
V @ Γ ⊢ N : Τ           :- not(member(Τ, V)), atom(Τ),
% 1. търсим в Γ типова декларация X : Σ, чиито тип Σ завършва на Τ
                           member(X : Σ, Γ),
% 2. разглобяваме Σ до Ρ₁ ⇒ Ρ₂ ⇒ ... ⇒ Ρₙ ⇒ Τ
                           deconstruct(Ρs, Τ, Σ),
% 3. за всяко Ρₖ търсим Mₖ
                           [Τ | V] @ Γ ⊢ Ms : Ρs,
% 4. построяваме апликацията app(...app(app(X,M₁),M₂),...,Mₙ)
                           construct(X, Ms, N).

⊢ M : Τ             :- [] @ [] ⊢ M : Τ.
