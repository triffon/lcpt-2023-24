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

% прости типове

% α,β
% α ⇒ β

:- op(140, xfy, ⇒).

ti(α⇒α).
tk(α⇒β⇒α).
ts((α⇒β⇒γ)⇒(α⇒β)⇒α⇒γ).

% типови съждения
% M:τ
% M:(α⇒(β⇒γ))

:- op(150, xfx, :).

% member(?X, ?L).

% контексти
% [x:α, y:β⇒α]

% релация на типизиране
% Γ ⊢ (M:τ)
% ⊢ M:τ

:- op(160, xfx, ⊢).
:- op(170, fx, ⊢).

Γ ⊢ X : Τ           :- isvar(X), member(X : Τ, Γ).
Γ ⊢ app(M1,M2) : Σ  :- Γ ⊢ M1 : Ρ ⇒ Σ, Γ ⊢ M2 : Ρ.
Γ ⊢ λ(X,N) : Ρ ⇒ Σ  :- [X : Ρ | Γ] ⊢ N : Σ.

⊢ M : Τ             :- [] ⊢ M : Τ.
