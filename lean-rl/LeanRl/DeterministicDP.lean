-- This is part of CS 851 Reinforcement Learning class Fall 2024.
-- This is a course project. Attempts to develop proof for
-- Deterministic Dynamic Programming
-- Define Policy, Value function and Principle of Optimality
-- This proof is very likely not complete, as there are many axioms, lemmas, theorems required to support each step.

import Mathlib

-- Declare structure for STATES as a LIST of natural numbers
structure STATES where
st : List ℕ

-- tests for STATES
#check STATES
#check @STATES.st
#check @STATES.mk

-- Declare structure for ACTIONS as a LIST of natural numbers
structure ACTIONS where
actions : List ℕ

-- tests for ACTIONS
#check ACTIONS
#check @ACTIONS.actions
#check @ACTIONS.mk

-- Define MDP structure Using default constructor mk
structure MDP where
states : List  ℕ
actions : List  ℕ
s0 : ℕ
rewards : ℝ
-- rewards : List (ℕ × ℕ → ℝ)
T : ℕ

-- Tests on definitions

#check MDP              -- a Type
#check @MDP.rec       -- the eliminator
-- #check MDP.induction_on -- recursor to Prop
#check @MDP.states           -- a projection / field accessor
#check @MDP.actions            -- a projection / field accessor
#check @MDP.s0            -- a projection / field accessor
#check @MDP.rewards            -- a projection / field accessor
#check @MDP.T            -- a projection / field accessor

#print prefix MDP
#check @MDP.mk

open MDP

def mdp := MDP.mk [0,1] [0,1] 0 1.2 100

#eval mdp.states
#eval mdp.actions
#eval mdp.s0
#eval! mdp.rewards
#eval mdp.T

structure STATE_VALUE where
state : ℕ
value : ℚ

-- START https://lean-lang.org/functional_programming_in_lean/getting-to-know/functions-and-definitions.html
def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n
-- END

-- example terminal reward - should be theoretical constant, to be figured out how
def terminalReward : ℝ := 10.00

-- S x R States * Values, should use maximum - WIP (WORK-IN-PROGRESS)
def values (s : ℕ ) := ℝ

-- open values
#check values

-- Policy returns a sequence of actions (argmax v_0 (s0;a_0, ...a_T-1))
-- argmax to be implemented
-- To implement argmax (was there in lean3 but not in lean 4?)
def policy (actions : ACTIONS) := ACTIONS

#check policy

-- should call Sort.lean from
def argmax ( v : List ℕ) := ℕ

universe u v w r

inductive Policy (α : Sort u) (actions : α ) : α → Prop where

-- Reward function
-- To implement the reward function for theory
def rewards (s : ℕ) ( a : ℕ) (t : ℕ) := ℝ


inductive Rewards (s : Type u) ( a : Type v) (t : Type w) (r : Type r)
  | mk : s → a → t → Rewards s a t r

inductive Reward (s : Type u) ( a : Type v) (t : Type w) → ℝ
