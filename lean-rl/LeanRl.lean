-- Nov 4th 2024.
-- Author: Sushma Akoju*****************SAkoju
-- This module serves as the root of the `LeanRl` library.
-- Import modules here that should be built as part of the library.
import LeanRL.Basic
import Mathlib
import Mathlib.Probability.ProbabilityMassFunction.Constructions
import Mathlib.Probability.ProbabilityMassFunction.Binomial
import Mathlib.Probability.Notation
import LeanRL
-- import LeanRL.DeterministicDP

open MeasureTheory ProbabilityTheory
open scoped ENNReal

-- define randome variable
variable {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ } (hX : Measurable X)
-- assigning a Gaussian distribution to Random variable X
-- example (P : Measure ℝ ) (s : Set ℝ) : ℝ≥0∞ := P s
-- P.map X = gaussianReal 0 1
#check MeasurableSpace
#check Measure
#check Set
#check Measurable
#check gaussianReal
#check NNReal
#check ℝ
-- ProbabilityMeasure Ω space, toFiniteMeasure will convert any ProbabilityMeasure to "disccrete"
-- FiniteMeasure is a discrete space
-- ProbabilityMeasure.map f : Ω → Ω  -> is the distribution
#check ProbabilityMeasure
#check condexp_indep_eq

-- bernoulli itself is the PMF defined inside ProbabilityMassFunction.Constructions
#check bernoulli
-- the expectation is noncomputable so lean will not generate bytecode.
-- noncomputable is allowed which means

-- here it does generate bytecode
noncomputable def foo := 42
#check foo

noncomputable
def E p h (f : Bool → ℝ ) :=
    ∫ i, (f i) ∂ ((PMF.bernoulli p h).toMeasure)

#check E

-- E is noncomputable since in real, if an integral needs to be computed, we do so over the data. but since this is theoretical,
-- although for binomial we can actually compute as it finite and countable, but for Expectations, due to integrals and continuous spaces, we leave it noncomputable.
-- real.hasPow is noncomputable since lean cannot calculate e^e but can calculate 2^2 = 4.
-- we could theretically call recursive operations, so lean is going to compute something like (a^n)^k where a has some recursive function, then lean would be like a SymPy.
#check bernoulli

-- PMF or discrete probability measure (i.e. "FINITE")
-- function from α → ℝ0∞ basically closed interval [0,∞]
-- to say PMF is probability measure that it has to be positive i.e between 0 and ∞
-- where probabilities sum to 1.
-- I was hoping this should have been defined by the axioms of the probability, but I dunno PMF is defined by itself.
-- Basically a function mapping α → ℝ0∞ such that Σf = 1.
-- But HasSum is a monoid -> a monoid is like a stack operation which always takes 2 elements (n = 2), thats stacks on top of each other.
-- The order matters, so stack operation is also assosiative. so it allows for n > 2 i.e. each time two elements are combined to give one element, so you can combine more than 2 elements over sequence of operations.
--  when number of elements is 1, then monoid allows a neutral element (empty element i.e. n = 0) to stack on top of one element, which gives original element.
-- monoid results in one element. n = 1
def PMF1.{u} (α : Type u) : Type u :=
  { f : α → ℝ≥0∞ // HasSum f 1 }

#check PMF1

-- def fxy x y (f : ℝ → ℝ ) :=

--     ∫ (f x y) ∂(y)

-- def marginal (µ : measure α) (F : Π i : ι, α → (β i)) (mv : set ι) :
--     measure (Π i : mv, β i) :=
--     joint µ (mv.restrict F)

-- #check marginal

-- noncomputable
-- def fy y (f : ℝ → ℝ ) := by
--     ∫ x,y (f x y) ∂(x)

#check E
#check condexp_indep_eq
-- #check condexp_ind_L1_fin

variable {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ } (hX : Measurable X)

variable {Ω : Type*} [MeasurableSpace Ω] {Y : Ω → ℝ } (hY : Measurable Y)

-- noncomputable

-- def E1 p h (f : Bool → ℝ ) :=

--     ∫ i, (f i) ∂((PMF1 p h).toMeasure)



-- def fy y (f : ℝ → ℝ ) :=

--     ∫ (fxy x y) ∂((PMF1 x y).toMeasure)

-- def fxgiveny xy (h : Ω → ℝ ) :=

--     -- fxy dividedby fy

--     sorry

-- END
-- Nov 4th 2024
