# Draft

# Designing a Language for Formal Verification: Constructing Predicates

introduction

definition of subject from 01

note examples of predicates from 013

## Thoughts

Predicates, not subjects, are responsible for some level of subject manipulation.
For example, specifying the maximum allowed memory utilization of a function requires that the subject, probably the function name, be resoved to form that the memory requirements can be calculated from.
This basically means that predicates are funcions on subjects.

## Notes for Article 016: Constructing Predicates

### Predicate as Subject Manipulator

**Core Insight**: Predicates are functions on subjects that handle subject resolution and transformation, not just evaluation

**Memory Analysis Example:**
- Predicate `uses_memory(X)` must resolve subject to a form where memory calculation is possible
- Requires subject expansion, branching logic analysis, function application tracking

**Domain Analysis Example:**
- Predicate `defined_for_all(Integers)` needs recursive expansion to inspect every utilization of the domain variable
- Must handle conditional logic that creates domain subsets

**Termination Analysis:**
- May depend entirely on language entity composition OR include resulting machine code analysis
- **Design Decision**: Predicates specify their own representation level requirements

### Smart Predicate Architecture

**Embedded Tactics Structure**: `P = ⟨pre_tactics, core_predicate, post_tactics⟩`
- **Pre-tactics**: Subject transformation and preparation (context resolution, aliasing expansion)
- **Core**: Domain-specific verification logic
- **Post-tactics**: Result combination and formatting

**Architectural Impact**: This fundamentally changes predicate design - they become active subject manipulators rather than passive evaluators

**Context-Dependent Subject Analysis**:
- Function invocation analysis: `invocations(Π, f)` - all invocation locations of function `f` in program `Π`
- Parameter analysis: `parameters(f, l)` - parameter set for function `f` at location `l`
- Error detection: `parameterErrors(Π, f) = {l | ∀l ∈ invocations(Π, f) : parameters(f, l) ⊄ domain(f)}`

### Predicate Composition Complexity

**Compound Predicate Challenges:**
- How do `(P₁ ∧ P₂)` handle conflicting subject transformation requirements?
- Example: `terminates` wants subject decomposition, `is_secure` wants subject treated as emergent system
- **Resolution Strategy**: Need composition rules for tactical conflicts

**Cross-Proposition Coordination**: The mutual dependency discussion revealed that predicates may need to coordinate across proposition boundaries, requiring more sophisticated internal architecture than simple evaluation functions

**Subject Preparation Coordination**: When multiple predicates need different subject forms, how does the system resolve conflicts and ensure all predicates get appropriate subject representations?

### Implementation Considerations

**Representation Level Handling**: Predicates specify their own representation level requirements and must handle cross-level consistency when analyzing subjects that exist across compilation stages

**Predicate Responsibility Scope**: Predicates must take responsibility for complex subject analysis, resolution, and transformation - shifting significant complexity from the structural system into domain-specific predicate implementations

