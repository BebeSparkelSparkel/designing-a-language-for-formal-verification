# Draft

# Designing a Language for Formal Verification: Tactically Utilizing Theorems in Proofs

Working on it. Coming Soon!

That's a compelling conjecture. So the structure would be:

# Article 03 Structure: Tactics as Proof

1. **The Tactical Goal**
   - Transform propositions through equivalence-preserving operations
   - Target: match known true structures (Theorems/Axioms)

2. **Knowledge Base as Reference**
   - Existing Theorems/Axioms as patterns of truth
   - Not modifiers of propositions, but targets for matching

3. **Proof by Structural Equivalence**
   - Success: proposition transforms to match known truth
   - Failure: proposition transforms to match known falsehood (Refutation)

4. **Tactical Operations**
   - Equivalence transformations that preserve truth value
   - Systematic approach to reaching recognizable patterns

This would make Article 04's function verification work by transforming the proposition about source code until it matches established patterns that define "being a function."

# Notes for Article 03: Tactically Utilizing Theorems in Proofs

Consider these notes highly speculative and unreliable.

## Tactical Architecture Findings

**Tactic Responsibility vs. Predicate Responsibility:**
- **Key Decision**: Whether tactics manipulate structure before predicate evaluation, or predicates handle their own complexity internally
- **Power vs. Responsibility Trade-off**: Structural representation gives tactics more power but puts more logical responsibility on them
- **Hybrid Approach**: Tactics handle syntactic transformation (operator distribution), predicates handle semantic requirements (subject decomposition)

**Predicate-Embedded Tactics:**
- **Smart Predicates**: Predicates can contain `⟨pre_tactics, core_predicate, post_tactics⟩`
- **User Interface Benefit**: Users write simple propositions, predicates handle tactical complexity internally
- **System Role**: Proposition-predicate system acts as facilitator, executing tactical pipelines reliably
- **System Responsibilities**: Execute tactic sequences, provide composition rules, maintain structural integrity
- **NOT System Responsibilities**: Predicate design quality, user comprehension, debugging ease

**Functional vs. Structural Representation:**
- **Isomorphism Challenge**: `T(P(S))` requires `P(S)` to be isomorphic with `⟨S, P(x)⟩` for tactics to manipulate both components
- **Alternative**: `T'(s, p)` avoids isomorphism but complicates proposition construction
- **Delayed Application**: Keep propositions as structures that tactics manipulate before evaluation happens

## Mutual Dependencies in Verification

**Cross-Proposition Dependencies:**
- Functions with mutual termination dependencies
- Bidirectional implications (A ↔ B)
- Proof steps that reference each other cyclically

**Critical Question**: Can mutual dependencies be entirely encapsulated in predicates, or do they require structural representation?

**Practical Constraint**: If predicates must handle cycles internally, they need their own cyclic data structures, creating architectural inconsistency with tree-based main structure


## Implementation Notes (Technical)

### Data Structure Strategy

**Type Aliasing Approach**: 
- Use `type Tree<N, E> = Graph<N, E>` with restricted operations for proposition structure
- Allow full `Graph<N, E>` access for predicates requiring cyclic logic
- Maintains architectural consistency while enforcing usage constraints

**Key Insight**: Implementation details (graph vs tree) are separate from conceptual design - the system can support both tree-like structural manipulation and graph-like predicate internals using the same underlying infrastructure

These findings should inform the design decisions in each article while keeping implementation concerns separate from conceptual framework development.

# Equivalence in Theorem Prover Tactics: A Comprehensive Technical Analysis

Major computer theorem provers have converged on remarkably similar fundamental approaches to handling equivalence in proof construction, despite their diverse logical foundations. This convergence reveals universal principles that can inform the design of new verification languages, with **definitional equality serving as the computational core** while tactical transformations provide flexible proof automation through sophisticated unification and pattern matching mechanisms.

## Foundational approaches to equivalence preservation

Theorem provers operate with a **hierarchical understanding of equivalence** that determines which transformations preserve truth during tactical proof construction. At the foundation lies **definitional equality**, implemented through reduction rules (, , , , -conversion) that establish when terms are computationally identical. Coq's Calculus of Inductive Constructions and Lean's dependent type theory both rely on this convertibility relation as their core mechanism, automatically recognizing when expressions reduce to structurally identical forms.

**Propositional equality** forms the next layer, requiring explicit proof objects to establish relationships between terms. This distinction enables systems to handle both automatic computational steps and user-directed logical reasoning. Agda's approach through Martin-Löf type theory exemplifies this pattern, where definitional equality drives unification while propositional equality (the identity type `__`) enables proof transport and transformation.

Higher-order systems like Isabelle/HOL extend this foundation with **logical equivalence** based on classical logic, supporting proof by contradiction and extensive automation. The system's higher-order unification handles both syntactic and semantic matching, integrating with external automated theorem provers through sophisticated translation mechanisms.

**Semantic equivalence** emerges through **setoid rewriting** and generalized equivalence relations, allowing systems to work with mathematical structures that have non-trivial equality definitions. All major systems support this through rewrite tactics that can operate modulo arbitrary equivalence relations, not just syntactic equality.

## Recognition mechanisms for theorem matching

The **unification and pattern matching infrastructure** forms the core of how theorem provers recognize when transformed propositions match established results. Modern systems employ **higher-order pattern unification** with careful restrictions to maintain decidability while providing sufficient power for practical proof automation.

**Coq and Lean** implement sophisticated elaboration engines that generate unification constraints during type checking, resolving metavariables through constraint solving. Coq's canonical structures and Lean's type class resolution provide additional mechanisms for automatic theorem selection based on type-directed search. The systems maintain **hint databases** that organize theorems by topic and application strategy, enabling tactics like `auto` to systematically explore relevant lemmas.

**Agda's approach** centers on dependent pattern matching, where unification of indices forces equality constraints during elaboration. The system's termination and coverage checkers ensure that all pattern matching is exhaustive and terminating, providing strong guarantees about proof construction. **Rewrite rules** extend definitional equality with user-defined computation rules, integrated through a confluence checker that ensures consistency.

**Isabelle/HOL** employs extensive automation through its simplifier and classical reasoner, combined with **Sledgehammer** integration that interfaces with external first-order theorem provers. The system's resolution-based approach combines forward and backward reasoning, with **higher-order resolution** providing flexible theorem matching against large libraries.

**Type-directed search** emerges as a universal pattern, where systems use type signatures to narrow the space of potentially applicable theorems. This approach scales effectively to large libraries while maintaining relevance to current proof goals.

## Core tactical transformation mechanisms

**Backward reasoning through goal decomposition** represents the fundamental tactical approach across all systems. Tactics transform complex goals into simpler subgoals through systematic application of logical rules. The **LCF heritage** provides the architectural foundation: tactics as programs that transform goal states while maintaining soundness through a trusted kernel.

**Rewrite tactics** form the core of equational reasoning, implementing **term rewriting systems** with confluence and termination properties. Systems provide both basic rewriting (`rewrite`, `rw`) and sophisticated automation (`simp`, `ring`, `field`) that handles domain-specific algebraic structures. **Conditional rewriting** extends this capability to handle premises and context-dependent transformations.

**Unification-based substitution** drives the tactical machinery, where higher-order pattern matching enables flexible application of theorems to goals. The systems must balance **power and predictability**: more sophisticated unification provides greater automation but potentially less predictable behavior. Lean 4's elaboration engine exemplifies this trade-off, providing aggressive automation while maintaining user control through explicit tactic specification.

**Proof search strategies** combine tactical primitives into powerful automation. **Resolution-based approaches** (particularly in Isabelle) systematically explore proof spaces through goal decomposition and hypothesis application. **Simplification engines** provide ordered rewriting with sophisticated control mechanisms for managing large sets of simplification rules.

**Meta-programming capabilities** enable users to construct domain-specific tactics, extending the systems' automation capabilities. Coq's Ltac, Lean's tactic programming, and Isabelle's ML interface provide increasingly sophisticated meta-theoretic reasoning capabilities.

## Proposition-tactic-theorem relationships

The **architectural separation** between propositions, tactics, and established theorems follows consistent patterns across systems. **Propositions** exist as types in the system's type theory, with **proof terms** as inhabitants of these types. **Tactics** manipulate proof terms indirectly through goal-directed construction, while **theorems** serve as reusable proof components stored in organized libraries.

**Library organization** follows hierarchical principles: foundational logic, basic data types, mathematical structures, and domain-specific theories. **Naming conventions** have converged across systems (e.g., `add_comm`, `mul_assoc`) reflecting the mathematical content rather than system-specific implementation details.

**Theorem databases** provide sophisticated indexing mechanisms supporting multiple search strategies: type-based search, pattern matching, and semantic content analysis. **Hint systems** organize theorems by application strategy rather than just mathematical content, enabling effective automation in specific domains.

**Module systems** provide namespace management and theory instantiation, enabling **generic programming** with mathematical structures. Type classes (Lean, Coq) and canonical structures provide additional organization principles that combine mathematical content with computational behavior.

The **proof state management** maintains clear separation between current goals, available hypotheses, and accessible theorems. **Context-sensitive resolution** ensures that local hypotheses take precedence over library results while maintaining access to the full mathematical development.

## Universal patterns in tactical theorem proving

**Convergent evolution** has produced remarkably similar tactical primitives across different systems despite diverse foundational commitments. **Goal decomposition tactics** (`intros`, `split`, `left`/`right`) reflect the natural structure of logical reasoning. **Hypothesis management** (`assumption`, `apply`) provides backward reasoning capabilities that mirror mathematical practice.

**Automation hierarchies** emerge consistently: basic tactics for manual proof construction, mid-level automation for routine reasoning, and high-level automation for complex search. The **hammer pattern** (external ATP integration) has become standard across systems, providing powerful proof search while maintaining soundness guarantees.

**Performance optimization** follows similar patterns: **incremental compilation** for large developments, **parallel processing** for concurrent proof checking, and **proof compression** to manage memory overhead. These optimizations reflect the common computational challenges of interactive theorem proving.

**User interface convergence** includes goal-oriented display, syntax highlighting for mathematical notation, and interactive development environments. **Error reporting** has evolved toward type-directed messages that guide users toward valid proof constructions.

**Interoperability** represents an emerging convergence trend, with systems developing translation mechanisms and shared library formats. The **Archive of Formal Proofs** model (pioneered by Isabelle) influences library development across multiple systems.

## Design implications for new verification languages

The **foundational architecture** should separate definitional equality (computational core) from propositional equality (proof-directed reasoning) while providing unified tactical interfaces. **Higher-order pattern unification** with careful decidability restrictions provides the optimal balance between automation power and predictable behavior.

**Library organization** should prioritize mathematical content over implementation details, with **type-directed search** and **semantic indexing** for theorem discovery. **Hint systems** should organize automation by proof strategy rather than mathematical topic alone.

**Tactical design** should provide clear **automation hierarchies** from basic primitives to sophisticated proof search, with **meta-programming capabilities** for domain-specific extension. **External tool integration** through the hammer pattern provides scalable automation while maintaining system soundness.

The **convergent evolution** observed across theorem provers provides strong evidence for these design principles, suggesting that certain approaches represent fundamental solutions to the challenges of interactive theorem proving. Future verification languages can leverage these insights to provide both powerful automation and predictable behavior for practical formal verification applications.

