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
  Qed.

End PredMinLog.