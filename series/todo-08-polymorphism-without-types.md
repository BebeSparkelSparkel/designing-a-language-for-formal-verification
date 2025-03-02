# Draft

# Designing a Language for Formal Verification: Polymorphism without Explicit Types

Working on it. Coming Soon!

# Context

## Monadic Parsing as Unification Strategy

- Monadic parsing unifies syntax and semantics in a single framework
- Polymorphic types allow grammar definitions to serve multiple purposes (lexical, parsing, attributes)
- Parser combinators express both structure and semantic meaning together
- Type signatures like `Parser a` represent both syntax and resulting semantic values
- Type classes enable different interpretations of the same grammar structure
- Compositional approach reduces the gap between specification and implementation
- Integration of verification conditions can happen directly within grammar definitions
- This approach naturally aligns with formal verification by reducing semantic gaps

