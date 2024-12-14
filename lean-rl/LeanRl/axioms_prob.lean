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
variable (A : Finset Ω)
variable (a b : Ω)

-- structure FiniteProbability (Ω : Finset τ ) where
--   p : τ → ℝ
--   axiom nonneg : ∀ (ω : Ω ), p ω ≥ 0
--   axiom totalprob : (∑ ω ∈ Ω, p ω) = 1
--   axiom countableaddivty (A : Finset Ω) : (∀ a b : Ω), a∈A ∧ b∈A ⇒ a = b → P(⋃ (a: A), a) = Σ (a : A ), P(a)


structure FiniteProbability (Ω : Finset τ ) where
  p : τ → ℝ
  nonneg : ∀ (ω : Ω ), p ω ≥ 0
  totalprob : (∑ ω ∈ Ω, p ω) = 1
  countableaddivty : ∀ ( A : Finset Ω),
  (∀ a b : Ω, (a ∈ A ∧ b∈A) → a = b) →
   ∑ a ∈ A, p a = p(Finset.fold (⋃) ∅ A {})


variable (Ω : Finset τ)
variable (p : τ → ℝ)
variable (h₁ : ∀ (ω : Ω), p ω ≥ 0)
variable (h₂ : (∑ ω ∈ Ω, p ω) = 1)
-- variable (h₃ : ∀ A : Finset Ω, (∀ a b : Ω, a ∈ A ∧ b ∈ A → a = b) → P(⋃ a ∈ A, a) = ∑ a ∈ A, P a)

variable P : FiniteProbability Ω p h₁ h₂ h₃
def cointoss : FiniteProbability ["H", "T"].toFinset := {
  p := λ ω => if ω = "H" then 0.5 else 0.5,
  nonneg := by{
    intro ω
    split <;> norm_num
  }
  totalprob := by simp; norm_num
  countableadditivity := by {
    intros A h
    simp [p]
  }
}

#eval cointoss.p "H"
#eval cointoss.p "T"
