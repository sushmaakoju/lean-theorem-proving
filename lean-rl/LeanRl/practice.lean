
import Mathlib
structure MDP (α : Type*) where
mk :: (s : α) (a : α) (s0 : α) (r : ℚ) (T : ℕ)
-- s is set of states
-- a is set of actions

#check MDP              -- a Type
#check @MDP.rec       -- the eliminator
-- #check MDP.induction_on -- recursor to Prop
#check @MDP.s           -- a projection / field accessor
#check @MDP.a            -- a projection / field accessor
#check @MDP.s0            -- a projection / field accessor
#check @MDP.r            -- a projection / field accessor
#check @MDP.T            -- a projection / field accessor

#print prefix MDP
#check @MDP.mk
#reduce MDP.s (MDP.mk 0 0 0 1.2 100)
#reduce MDP.a (MDP.mk 10 20 0 1.3 100)

open MDP

-- following will not work now, coz example does strict type checks - why??
-- example (α : Type*) (s a s0 r T : α) : (mk s a s0 r T) = α :=
-- rfl  ---> basically saying its reflexive (tactic) : https://lovettsoftware.com/NaturalNumbers/Tactics/rfl.lean.html

-- example (α : Type*) (a b : α) : y (mk a b) = b :=
-- rfl

structure MDP1 where
mk :: (s : Type) (a : Type) (s0 : Type) (r : ℚ) (T : ℕ)

#check MDP1              -- a Type
-- #check MDP1.rec_on       -- the eliminator
-- #check MDP1.induction_on -- recursor to Prop
#check MDP1.s           -- a projection / field accessor
#check MDP1.a            -- a projection / field accessor
#check MDP1.s0            -- a projection / field accessor
#check MDP1.r            -- a projection / field accessor
#check MDP1.T            -- a projection / field accessor

#print prefix MDP1


-- Using default constructor mk
structure MDP2 where
s : Type
a : Type
s0 : Type
r : ℚ
T : ℕ

#check MDP2              -- a Type
#check @MDP2.rec       -- the eliminator
-- #check MDP.induction_on -- recursor to Prop
#check @MDP2.s           -- a projection / field accessor
#check @MDP2.a            -- a projection / field accessor
#check @MDP2.s0            -- a projection / field accessor
#check @MDP2.r            -- a projection / field accessor
#check @MDP2.T            -- a projection / field accessor

#print prefix MDP2
#check @MDP2.mk
#reduce MDP2.s (MDP2.mk 0 0 0 1.2 100)
#reduce MDP2.a (MDP2.mk 10 20 0 1.3 100)
