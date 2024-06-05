variable (A B C : Prop)

theorem S : (A -> B -> C) -> (A -> B) -> A -> C :=
  by intro u
     intro v
     intro w
     apply u
     . apply w
     . apply v
       apply w

theorem K : A -> B -> A :=
  by intro u
     intro _
     apply u

theorem I : A -> A :=
  by intro u
     apply u
