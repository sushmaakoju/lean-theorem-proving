# lean-theorem-proving
# lean-rl
This is part of Lean meeting RLLab at University of New Hampshire, Fall 2024 under the supervision of Prof. Marek Petrik. Presently active members there Prof. Marek Petrik and myself are working on this.

## Notes
The following contains weekly summaries from Oct 1st 2024.
Presently this covers from Nov 4th 2024, work-in-progress to update from Oct 1st 2024. Please click on corresponding time-wise options to see the respective statuses. 

The following notes with `MM-DD-YYYY` format is my notes of my own study that I included here.

### 10/8/2024

I previously studied about Proof systems, Theory of Computation, Linguistics, First Order Logic, Second Order Logic, Decidability, Godel's theorem, Symbolic Logic, Semiotics, etc. My powerpoint slides attempt to depict how proof theory and systems intersect with each one of these theoretical topics and can help with assimilating the information for better understanding:

<a href="https://docs.google.com/presentation/d/e/2PACX-1vTmE7POHvRJoTksgRH9r9rWEnAx9iQX_wpJIDsP1SWn2CnYALeOd5X8Pcc0XtjkzQ/pub?start=false&loop=false&delayms=3000">Proof Systems </a>

The list of topics covered in <a href="https://docs.google.com/presentation/d/e/2PACX-1vTmE7POHvRJoTksgRH9r9rWEnAx9iQX_wpJIDsP1SWn2CnYALeOd5X8Pcc0XtjkzQ/pub?start=false&loop=false&delayms=300&slide=id.g3098b16f33b_0_156">this presentation</a> are as follows: 

- What is a proof
- What is a derivation
- Logic as a Formal System
- Propositional Logic and First Order Logic
- Second Order Logic & Comparison
- Semantic Decomposition & Parsers for Natural Language 
- Semiotics & Symbolic Logic
- Natural Logic
- Decidability, Completeness and Soundness
- Turing Machines
- Natural Deduction
- Tableau Method
- Sequent Calculus
- Axiomatic Derivations
- Lean Proof Systems
- References

### The meeting minutes

The actual weekly meeting minutes and discussions are noted here:

<a href="https://docs.google.com/document/d/1Vm-D0o6iOOY54qCFt8eCXqNrHPj-K-ntufAe5ebiPig/edit?usp=sharing">lean-meeting-notes</a>
The tabs in this document provide information of weekly meetings and <a href="https://docs.google.com/document/d/1Vm-D0o6iOOY54qCFt8eCXqNrHPj-K-ntufAe5ebiPig/edit?tab=t.ckkww86uzld">the zulip chats</a>.

<!-- 
<details open>
<summary> Click to expand/collapse: 11/4/2024</summary> -->

### 11/4/2024

To understand the implementation of Mathlib.MeasureTheory.Function.ConditionalExpectation.Basic, I completed two MIT courses: "Introduction of Functional Analysis" and "MeasureTheory". Both are available on MIT Opencourseware. After completing this course, understanding MeasureTheory implementation on LeanProver - helped to make sense why the Lean developers implemented it the way they did. These two courses are each 8 - 10 hours duration along with pausing to understand some additional stuff. MIT Opencourseware has a 100+ page lecture notes for each one of this. 

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
<!-- </details>

<details open>
<summary>Click to expand/collapse 11/7/2024</summary> -->

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

#### Missing theorems, proofs for proving E[E[x|y]] = E[x]

It may be easier to prove using Omega notations (measure theory implementations that already exist in Lean4).

##### Discrete case

- Conditional expectation for discrete random variables.
- law of marginal probability: p(X) = ΣP(X, Y ) where X,Y are discrete random variables
- E [ Σx∈X x . P(X = x | Y = y) ] . P(Y = y)
- Σy∈Y Σx∈X x . P(X = x | Y = y) . P(Y = y)
- Σx∈X Σy∈Y x . P(X = x, Y = y)
- Σx∈X xP(X = x) = E[x]

##### Continuous case

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

<!-- </details>


<details open>
<summary> Click to expand or collapse 11/8/2024</summary> -->

### Tactics

#### RFL - Reflexive

- <a href="https://lovettsoftware.com/NaturalNumbers/Tactics/rfl.lean.html">Tactic reflexive applied on any type no matter how complex the type maybe<a>

- Reference: <a href="https://lovettsoftware.com/NaturalNumbers/Tactics.lean.html"> Tactics in Lean</a>

<!-- </details> -->

<!-- <details open>
<summary> Click to expand/collapse: 11/12/2024</summary> -->

### 11/12/2024

Review comments from Marek for <a href="https://github.com/sushmaakoju/lean-theorem-proving/blob/main/lean-rl/LeanRl/DeterministicDP.lean">DeterministicDP.lean</a>

- Check Finset since it has Sum, range and Product functions defined
- N -> N -> N -> R is same as N x N -> 
- BigSum or Finset.Sum
- Theoretically 