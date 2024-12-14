import Mathlib.Data.Real.Basic

import Mathlib
open MeasureTheory ProbabilityTheory
open scoped ENNReal
open Function
open Set

variable {σ α : Type}
variable [Inhabited σ] [Inhabited α]

variable (Ω : Finset τ)
variable (p : τ → ℝ)

structure FiniteProbability (Ω : Finset τ ) where
  p : τ → ℝ
  axiom nonneg : ∀ (ω : Ω ), p ω ≥ 0
  axiom totalprob : (∑ ω ∈ Ω, p ω) = 1
  axiom countableaddivty (A : Finset Ω) : (∀ a b : Ω), a∈A ∧ b∈A ⇒ a = b → P(⋃ (a: A), a) = Σ (a : A ), P(a)

-- let FiniteProbability := P

structure MDP  (σ α : Type) : Type where
  S : Finset σ
  A : Finset α
  s_0 : σ
  T : ℕ
  r : S → A → ℝ
  f : S → A → S

variable (m : MDP)

-- definitions
noncomputable
def f (s : σ ) (a : α ) (s' : σ ) : σ   :=
  match s,a with
  | s_t, a_t => s_i
  | _, _  => s

def r_t ( s : ℕ ) (a : ℕ ) : ℝ :=
  match s, a with
  |s, a_t => ℝ

-- terminal reward
r_T (s_T : σ ) : ℝ :=
  match s_T with
  | s_j := ℝ

-- value function v_t
def valuefun_t (s : σ ) : ℝ :=
  if f(s,_,_) == s
    return 0
  else
    v_t(s, ∀ a_k ∈ Finset α ) = ∑_{ k := t}^T r_k(s_k, a_k) + r_T(s_T)

-- value function expansion to include (t+1)th value function
def value_fun_t_r (s: σ) : ℝ :=
    v_t(s, ∀ a_k ∈ Finset α ) = r_t (s, a_t ) + ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T)

-- value function at t+1
def valuefun_{t+1} (s: σ) : ℝ :=
    v_{t+1}(s, ∀ a_k ∈ Finset α ) =  ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T)

-- optimal value function v_star_t
def optimalvaluefn (s : σ ) (A : Finset α ) : ℝ :=
  v_star_t(s) = max( ∀ a : A, ∑_{ k := t}^T r_k(s_k, a_k) + r_T(s_T))

-- optimal value function v_star_{t+1}
def optimalvaluefn_next (s : σ ) (A : Finset α ) : ℝ :=
  v_star_{t+1}(s) = max( ∀ a : A, ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T))

-- optimal value function without reward function
def optimalvaluefn_t (s : σ ) (A : Finset α ) : ℝ :=
  v_star_t(s_t) = max_{∀ a_t : A}^T, v_t(s_t, a_t, ...a_T)

-- optimal value function without reward function at t+1
def optimalvaluefn_next_t (s : σ ) (A : Finset α ) : ℝ :=
  v_star_{t+1}(s_{t+1}) = max_{∀ a_{t+1} : A}^T, v_{t+1}(f(s_t, a_t), a_{t+1}, ...a_T)

-- max function
def max (t : Finset τ ) (A : Finset α) (T : m.T) (v → m.S → m.A → ℝ ) :=
  -- base case k = 0 or 1 and k
  | Nat.0 => v_0(f(s_0, a_0), a_{0})
  | Nat.succ t => max_{∀ a_{k} : A}^T, v_{k}(f(s_k, a_k), ∀ a_k ∈ {a_k, ...a_T})

-- This is only rough draft and the following proof is giving errors.
    example principle_of_optimality : v__star_t(s) = max_{a_t : A } r_t(s, a_t) + v_star_{t+1}(f_t(s, a_t)):= by
    rfl valuefun_t := by
    rfl value_fun_t_r := by
    rfl valuefun_{t+1} := by

def mdp1 : MDP ℕ := {
  states := {1,2},
  actions := {1,2},
  s_0 := 1,
  r_t := λ x y x : x+y+x = 2,
  T := 100,
  f := λ x y : x+1
}
  {f := fun x y ⇒ x + y}


let result := addMap.f 2 3



#check MDP
#check @MDP.S
#check @MDP.A
#check @MDP.s_0
#check @MDP.r_t
#check @MDP.T
#check @MDP.f
#check @MDP.mk


#reduce MDP.states (MDP.mk 0 0 0 0 100 0)

structure MDP  (σ α : Type) : Type where
  S : Finset σ
  A : Finset α
  s_0 : σ
  T : ℕ
  r : S → A → ℝ
  f : S → A → S

variable (m : MDP)

-- definitions
noncomputable
def f (s : σ ) (a : α ) (s' : σ ) : σ   :=
  match s,a with
  | s_t, a_t => s_i
  | _, _  => s

def r_t ( s : ℕ ) (a : ℕ ) : ℝ :=
  match s, a with
  |s, a_t => ℝ

-- terminal reward
r_T (s_T : σ ) : ℝ :=
  match s_T with
  | s_j := ℝ

-- value function v_t
def valuefun_t (s : σ ) : ℝ :=
  if f(s,_,_) == s
    return 0
  else
    v_t(s, ∀ a_k ∈ Finset α ) = ∑_{ k := t}^T r_k(s_k, a_k) + r_T(s_T)

-- value function expansion to include (t+1)th value function
def value_fun_t_r (s: σ) : ℝ :=
    v_t(s, ∀ a_k ∈ Finset α ) = r_t (s, a_t ) + ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T)

-- value function at t+1
def valuefun_{t+1} (s: σ) : ℝ :=
    v_{t+1}(s, ∀ a_k ∈ Finset α ) =  ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T)

-- optimal value function v_star_t
def optimalvaluefn (s : σ ) (A : Finset α ) : ℝ :=
  v_star_t(s) = max( ∀ a : A, ∑_{ k := t}^T r_k(s_k, a_k) + r_T(s_T))

-- optimal value function v_star_{t+1}
def optimalvaluefn_next (s : σ ) (A : Finset α ) : ℝ :=
  v_star_{t+1}(s) = max( ∀ a : A, ∑_{ k := t+1}^T r_k(s_k, a_k) + r_T(s_T))

-- optimal value function without reward function
def optimalvaluefn_t (s : σ ) (A : Finset α ) : ℝ :=
  v_star_t(s_t) = max_{∀ a_t : A}^T, v_t(s_t, a_t, ...a_T)

-- optimal value function without reward function at t+1
def optimalvaluefn_next_t (s : σ ) (A : Finset α ) : ℝ :=
  v_star_{t+1}(s_{t+1}) = max_{∀ a_{t+1} : A}^T, v_{t+1}(f(s_t, a_t), a_{t+1}, ...a_T)

-- max function
def max (t : Finset τ ) (A : Finset α) (T : m.T) (v → m.S → m.A → ℝ ) :=
  -- base case k = 0 or 1 and k
  | Nat.0 => v_0(f(s_0, a_0), a_{0})
  | Nat.succ t => max_{∀ a_{k} : A}^T, v_{k}(f(s_k, a_k), ∀ a_k ∈ {a_k, ...a_T})

example principle_of_optimality : v__star_t(s) = max_{a_t : A } r_t(s, a_t) + v_star_{t+1}(f_t(s, a_t)):= by
  apply refl



def mdp1 : MDP ℕ := {
  states := {1,2},
  actions := {1,2},
  s_0 := 1,
  r_t := λ x y x : x+y+x = 2,
  T := 100,
  f := λ x y : x+1
}
  {f := fun x y ⇒ x + y}


let result := addMap.f 2 3

let FiniteProbability := P


#check MDP
#check @MDP.S
#check @MDP.A
#check @MDP.s_0
#check @MDP.r
#check @MDP.T
#check @MDP.f
#check @MDP.mk


-- #reduce MDP.S (MDP.mk 0 0 0 0 100 0)

-- Change all def to variable types - definition instances
