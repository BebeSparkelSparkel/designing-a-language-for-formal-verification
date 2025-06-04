# Draft

# Designing a Language for Formal Verification: Constructing Propositions

Propositions are just predicate functions applied to subjects.

Quantification is just wrapping a predicate $P(x)$ with another predicate
$P'(X) = \forall x \in X : P(x)$ or $forall(P, X) = \forall x \in X : P(x)$

## Notes for Article 018: Constructing Propositions

### Simplified Proposition Construction

**Core Insight**: Propositions are predicate functions applied to subjects: `P(S)`

**Quantification as Predicate Wrapping:**
- `∀x ∈ X : P(x)` becomes `P'(X) = ∀x ∈ X : P(x)`
- Alternative functional form: `forall(P, X) = ∀x ∈ X : P(x)`
- **Implication**: Universal/existential quantification handled through predicate composition rather than special structural forms

**Embedded Tactics Integration:**
- Proposition construction becomes: subject selection + predicate selection + tactical pipeline execution
- **Simplification**: Users don't manage tactical complexity directly - predicates handle their own requirements

### Proposition Evaluation Pipeline

**Structure → Tactics → Evaluation:**
1. Proposition structure (with embedded predicate tactics)
2. Tactical transformation (subject preparation, logical distribution)
3. Predicate evaluation (domain-specific verification)

**Key Design Decision**: Keep proposition construction syntax simple while allowing complex verification through sophisticated predicates

