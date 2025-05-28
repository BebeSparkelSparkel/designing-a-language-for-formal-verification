# Designing a Language for Formal Verification: Core Elements

When designing a programming language with formal verification capabilities,
the fundamental building blocks must first be established. Through careful
analysis, the following essential components and their relationships emerge as
the foundation for expressing and verifying program properties.

### Primitive Elements

The most fundamental components from which all other elements in the formal
verification system are derived, serving as the basic building blocks for
expressing and verifying program properties.

**Subject**:  One or more nouns or entities (e.g., a function, variable, or
module) about which a claim, called a Predicate, can be made to form a
Proposition. If multiple, they must be logically related (e.g., "Function F and
Module M").

**Predicate**:  One or more verifiable claims about a Subject, such as a
property or behavior (e.g., "terminates"), each determinable as true or false.
If multiple, they are logically related when applied to the Subject (e.g.,
"terminates and is secure").

**Tactic**:  A transformation of a Proposition, guided by equivalences
from Definitions, Theorems, and Axioms, which, when composed, can prove a
Theorems truth.

### Basic Compositions

Structured combinations of Primitive Elements that enable the expression of
verifiable claims and the logical transformations needed to prove them.

**Subject-Predicate-Pair (SPP)**:  A pairing of a singular Subject with a
singular Predicate, representing the smallest, atomic form of a Proposition.
"Singular" means no logical conjunctions or relations within itself. Example:
"Function F terminates."

**Proposition**:  A declarative statement that is either true or false,
expressing a verifiable claim about one or more Subjects and their one or more
associated Predicates, related by logical operators. It ranges from a single
SPP (e.g., "Function F terminates") to a compound structure (e.g., "Function F
and Module M terminate and are secure"), transformable into logically related
SPPs using Tactics.

**Proof**:  A composition of Tactics that transforms a Proposition into
equivalent Theorems or Axioms, establishing its truth as a Theorem or falsehood
as a Refutation.

### Verification Structures

The products and states of formal verification processes, representing
different stages of proof development and the established relationships between
Propositions.

**Definition**:  A declaration of logically equivalent Propositions,
introducing new terms or relations (e.g., "x is even means x is divisible by
2").

**Axiom**:  A Proposition accepted as true without Proof, serving as a
foundational truth.

**Theorem**:  A Proposition with a Proof confirming its truth.

**Incomplete**:  A Proposition lacking a Proof of its truth or falsehood,
awaiting further development.

**Refutation**:  A Proposition proven false. If the Law of Excluded Middle
holds, its negation may become a Theorem; otherwise, a separate Proof is
required.

**Conjecture**:  A Proposition assumed true by human assertion, serving as a
placeholder for future Proof.

## Design Implications

Primitive Elements (Subject, Predicate, Tactic) and Basic Compositions (SPP,
Proposition, Proof) form the building blocks of Verification Structures
(Definition, Axiom, Theorem, etc.). Their principled combination ensures the
language can express and verify program properties with certaintye.g., proving
"Function F terminates" or "Module M is secure."

## Next Steps

With these Core Elements established, subsequent articles will explore:

- Constructing Propositions from complex many-to-many relations of Subjects and
  Predicates, and how Tactics transform them into simple, logically related SPPs.
- Defining how Tactics use Definitions, Axioms, and Theorems to manipulate
  Propositions.
- Establishing Proofs for a Theory by composing Tactics to verify its
  Proposition.

How would you design Subjects, Predicates, and Tactics? Share your thoughts below!

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

#FormalVerification #ProgrammingLanguages #ProofAssistants #TypeTheory #CompSci
