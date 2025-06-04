# Draft

# Designing a Language for Formal Verification: Tactically Utilizing Theorems in Proofs

Working on it. Coming Soon!

## Notes for Article 03: Tactically Utilizing Theorems in Proofs

### Tactical Architecture Findings

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

### Mutual Dependencies in Verification

**Cross-Proposition Dependencies:**
- Functions with mutual termination dependencies
- Bidirectional implications (A ↔ B)
- Proof steps that reference each other cyclically

**Critical Question**: Can mutual dependencies be entirely encapsulated in predicates, or do they require structural representation?

**Practical Constraint**: If predicates must handle cycles internally, they need their own cyclic data structures, creating architectural inconsistency with tree-based main structure


### Implementation Notes (Technical)

#### Data Structure Strategy

**Type Aliasing Approach**: 
- Use `type Tree<N, E> = Graph<N, E>` with restricted operations for proposition structure
- Allow full `Graph<N, E>` access for predicates requiring cyclic logic
- Maintains architectural consistency while enforcing usage constraints

**Key Insight**: Implementation details (graph vs tree) are separate from conceptual design - the system can support both tree-like structural manipulation and graph-like predicate internals using the same underlying infrastructure

These findings should inform the design decisions in each article while keeping implementation concerns separate from conceptual framework development.

