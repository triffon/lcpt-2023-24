Import Coq.Init.Nat.
Require Import Lia.

Section Example.
  Check 0.
  Check 5.
  Check nat.
  Check Set.
  Check Type.
  Variable n : nat.
  Check n.
  Check n + 2.
  Check fun n => n + 2.
  Check (fun n => n + 2) 4.
  Check n > 2.
  Check Prop.
  Check gt.
  Check forall n, n > 2.
  Check 5 > 2.
  Check bool.
  Check true.
  Check false.
  Check lt.
  Check ltb.
  Compute 2 + 3.
  Compute (fun n => n + 2) 4.
  Compute 5 > 2.
  Compute 2 <= 5.
  Compute 2 <? 5.
  Compute ltb 2 5.
  Lemma five_greater_than_two : 5 > 2.
    auto.
  Qed.
  Print five_greater_than_two.
  Print le_n.
End Example.

Section PropMinLog.
  Variable A : Prop.
  Goal A -> A.
    intro u.
    apply u.
  Save I.
  Check I.
  Print I.
  Compute I.
  Definition I2 : A -> A := fun u : A => u.
  Print I2.

  Variable B : Prop.

  Lemma K : A -> B -> A.
    intro u.
    intro.
    apply u.
  Qed.

  Variable C : Prop.

  Lemma S : (A -> B -> C) -> (A -> B) -> A -> C.
    intros u v w; apply u; [ assumption | apply v; assumption ].
  Qed.

  Print S.

  Lemma swap : A /\ B -> B /\ A.
    intro u.
    split.
    apply u.
    apply u.
  Qed.

  Print swap.

  Lemma demorgan : (~A \/ ~B) -> ~(A /\ B).
    intros u v.
    elim u.
      (* Goal 1 *)
      intro a.
      apply a.
      apply v.
      (* Goal 2 *)
      intro b.
      apply b.
      apply v.
  Qed.

  Print demorgan.

  Goal A -> ~~A.
    intro u.
    intro v.
    apply v.
    apply u.
    Show Proof.
  Qed.

  Goal ~~~A -> ~A.
    intros u v.
    apply u.
    intro w.
    apply w.
    apply v.
    Show Proof.
  Qed.
End PropMinLog.

Section PropClassLog.
  Hypothesis Stab : forall (A : Prop), ~~A -> A.

  Variable A : Prop.
  Lemma LEM : A \/ ~A.
    apply Stab.
    intro u.
    apply u.
    right.
    intro v.
    apply u.
    left.
    apply v.
  Qed.

  Variable B : Prop.
  Lemma Peirce : ((A -> B) -> A) -> A.
    intro u.
    apply Stab.
    intro v.
    apply v.
    apply u.
    intro w.
    exfalso.
    apply v.
    apply w.
  Qed.

  Print Peirce.
End PropClassLog.

Section PredMinLog.
  
  Variable alpha : Set.
  Variable p : alpha -> Prop.
  Variable x y : alpha.

  (*
  Variable p : nat -> Prop.
  Variable x y : nat.
  *)

  Goal (forall x, p x) -> exists x, p x.
    intro u.
    exists y.
    apply u.
    Show Proof.
  Qed.

  Goal (exists x, ~p x) -> ~ forall x, p x.
    intro u.
    intro v.
    elim u.
    intros z w.
    apply w.
    apply v.
    Show Proof.
  Qed.

End PredMinLog.

Section PredClassLog.
  Variable bar : Set.
  Variable drunkard : bar.
  Variable drinks : bar -> Prop.
  Hypothesis Stab : forall (A : Prop), ~~A -> A.

  Theorem drinkers_theorem :
    exists x, drinks x -> forall y, drinks y.
    apply Stab.
    intro not_drinkers_theorem.
    apply not_drinkers_theorem.
    exists drunkard.
    intro drinks_drunkard.
    intro guy.
    apply Stab.
    intro not_drinks_guy.
    apply not_drinkers_theorem.
    exists guy.
    intro drinks_guy.
    exfalso.
    apply not_drinks_guy.
    apply drinks_guy.
    Show Proof.
  Qed.



End PredClassLog.

Section WeakSymbols.
  Definition weak_or (A B : Prop) := ~A -> ~B -> False.
  Variable A B : Prop.
  Compute weak_or A B.
  Infix "~\/" := weak_or (at level 60, right associativity).
  Hypothesis Stab : forall (A : Prop), ~~A -> A.

  Goal A ~\/ B -> A \/ B.
    intro u.
    apply Stab.
    intro v.
    apply u.
    (* Goal ~A *)
      intro a.
      apply v.
      left.
      apply a.
    (* Goal ~B *)
      intro b.
      apply v.
      right.
      apply b.
   Qed.

   Goal A -> A.
     intro u.
     (*
     apply Stab.
     intro v.
     apply v.
     *)
     apply u.
   Qed.
End WeakSymbols.