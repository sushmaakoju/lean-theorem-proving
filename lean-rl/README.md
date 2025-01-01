# lean-rl
## Sep 10 2024 - Dec 5th 2024

I started initially as a volunteer participant for giving knowledge transfer and as a courtesy participation, for the CS department, UNH. Thanks for the invite to participate and RLLab organized by Prof. Marek Petrik for Fall 2024.

## Notes
The following contains weekly summaries from Oct 1st 2024.
Presently this covers from Nov 4th 2024, work-in-progress to update from Oct 1st 2024. Please click on corresponding time-wise options to see the respective statuses.

<details open>
<summary> Click to expand/collapse: 11/4/2024</summary>

### 11/4/2024

To understand the implementation of Mathlib.MeasureTheory.Function.ConditionalExpectation.Basic, I completed two MIT courses: "Introduction of Functional Analysis" and "MeasureTheory". Both are available on MIT Opencourseware. After completing this course, understanding MeasureTheory implementation on LeanProver - helped to make sense why the Lean developers implemented it the way they did. These two courses are each 8 - 10 hours duration along with pausing to understand some additional stuff. MIT Opencourseware has a 100+ page lecture notes for each one of this. But I found youtube videos for this MIT open courseware better.

YouTube playlist, lectures 1, 2,4,6,7,8,9, and 10 are sufficient. <a href="https://youtube.com/playlist?list=PLUl4u3cNGP63micsJp_--fRAjZXPrQzW_&si=AyvFCQERdrNjy_Gh">Introduction to Functional Analysis</a>

The LeanProver's implementation is bottom up - for example, to build a theorem on conditional expectation, define sigma-algebras, measures, function maps in Measurespace, define probability as a Measure space, define random variable as a map to probability to generate a measurespace.

My proof for E[E[x|y]] = E[x] in one of homework questions also contains one proof using Omega notations i.e. Measure theoretic but its not as deep as that of LeanProver. But then I thought, I could create my own functions, theorems, axioms but in reverse direction - create something abstract like E as a function, P as a probability as a function, define axioms involving probability, just that which is required for Conditional Expectation. But as per Marek's suggestion on Nov 4th 2024's meeting, I understand why this direction of top to-bottom approach i.e. abstract implementation to specific is more work and possibly re-work.

After completing the MIT courses, I went over the implementation of Mathlib.MeasureTheory.Function.ConditionalExpectation.Basic.


##### Random Variable in Lean

- a random variable is a measurable function from measurableSpace to another, which here is Real number space
- X becomes a MeasurableSpace instance
- We can define a Random Variable as follows:

```
variable {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ } (hX : Measurable X)
```
- Ω is written \Omega in Lean (like latex)

##### Keyword Noncomputable

There is one keyword called as noncomputable which is interesting which explains a lot why lean is not SymPy or NumPy.


- A function such as Expectation i.e. E[x] is noncomputable since in real, if an integral needs to be computed, we compute over the data. But since this is theoretical, we do not necessarily need to implement algorithms that calculate the integral since Integral itself is over a theoretical and symbolic functions.

- Although for binomial we can actually compute as it finite and countable, but for Expectations, due to integrals and continuous spaces, we leave it noncomputable.

- Real.hasPow is noncomputable since lean cannot calculate e^e but can calculate 2^2 = 4.

- We could theoretically call recursive operations, so Lean is going to compute something like (a^n)^k where a has some recursive function, but then lean would be like a SymPy but it is not.

##### Probability Mass Function (PMF) in LEAN

- PMF or discrete probability measure (i.e. "FINITE")
- function from α → ℝ0∞ basically closed interval [0,∞]
- to say PMF is probability measure that it has to be positive i.e between 0 and ∞ where probabilities sum to 1.

-- I was hoping this should have been defined by the axioms of the probability, but I dont know PMF is defined by itself as a standalone function that can be overwritten or extended.

-- Basically a function mapping α → ℝ0∞ such that Σf = 1.

##### HasSum is a Topological Monoid

- HasSum is a Topological Monoid, since we do not actually compute the probabilities, but only need a condition that verifies sum is equal to 1 but theoretically in Measure Theory and Algebraic notations.

- HasSum is a monoid.
- A monoid is like a stack operation which always takes 2 elements (n = 2), thats stacks on top of each other.
- The order matters, so stack operation is also associative. This property allows for n > 2 i.e. each time two elements are combined to give one element, so you can combine more than 2 elements over sequence of operations.
- When number of elements is 1, then monoid allows a neutral element (empty element i.e. n = 0) to stack on top of one element, which gives original element.
- Monoid results in one element. n = 1
</details>

<details open>
<summary>Click to expand/collapse 11/7/2024</summary>

### 11/7/2024

#### Drafting steps to follow for designing proofs in LeanProver

1. Write down the original proof of theorem/claim/lemma.
2. Write down relevant lemmas, axioms required for written proof.
3. Check Lean Prover documentation to find out what axioms, lemmas, proofs are available.
4. In my experience, what we want to prove, and the proof we write might be different from what Lean Prover provides. 
5. Alternative to 4, would be to write all required axioms, proofs from the scratch in Lean Prover, which may be reinventing the wheel.
6. Tactics is an important part of proof. For some claims, we want to prove LHS = RHS and RHS = LHS. 

#### Proof Planning
- Handwritten proof
- Steps require <a href="https://observablehq.com/d/742fa8cd27bad42e">Proof Viewer</a> on Lean
- Using tactics in Lean versus tactics in Symbolic Computation
- Based on available "theory" in LeanProver, what additional theory can be derived?
- Based on missing "theory" in LeanProver, what new implementations are required?
- Not sure but maybe Marginal, Joint PDFs is missing even using Omega notations??
- No idea how to use Omega notation, MeasureTheory to define and distinguish between "Finite" and "Continuous" distributions of Random Variables.

#### Missing functions for proving E[E[x|y]] = E[x]
- Joint Probability Density Function f_X,Y(x,y)
- Marginal Probability Density Function f_Y(y)
- Conditional Probability Density Function f_X|Y(x,y)
- E[g(y)] = ∫ g(y) f_Y(y) dy
- E[E[x|y]] = ∫ E[x|y] f_Y(y) dy 
- E[x|y] = ∫ x f_X|Y(x,y) dx
- E[x] = ∫ x f_X(x) dx
- f_X|Y (x,y) = f_X,Y (x,y) / f_Y(y)
- f_X(x) = ∫_x f_X,Y (x,y) dy

### Research work

- <a href="https://escholarship.org/uc/item/8hb1w6js"> Formalizing the Beginnings of Bayesian Probability Theory in the Lean Theorem Prover </a>
From UC San Diego Vaishnav, Rishikesh HirenduAdvisor(s): Gao, Sicun.

</details>

<details open>
<summary> Click to expand or collapse 11/8/2024</summary>

### Tactics

#### RFL - Reflexive

- <a href="https://lovettsoftware.com/NaturalNumbers/Tactics/rfl.lean.html">Tactic reflexive applied on any type no matter how complex the type maybe<a>

- Reference: <a href="https://lovettsoftware.com/NaturalNumbers/Tactics.lean.html"> Tactics in Lean</a>

</details>

