# Draft

# Designing a Language for Formal Verification: Cross-Representation Propositions

**Core concept**: Propositions that relate subjects across different representation levels.

**Types of cross-representation propositions**:

**Translation correctness**:
- `(factorial, 0x401000) : translation_preserves_semantics`
- Your formula: `factorial : (m = t(factorial) : x  domain(factorial) : factorial(x)  m(t(x)))`

**Compilation properties**:
- `(source_factorial, ast_factorial) : syntactic_correspondence`
- `(ast_factorial, machine_factorial) : semantic_preservation`

**Cross-level consistency**:
- `(factorial_source  factorial_machine) : equivalent_termination`
- `(parse_tree_node  ir_function) : structure_preserved`

**Implementation verification**:
- `(specification, implementation) : correctly_implements`
- `(high_level_algorithm, optimized_machine_code) : behavior_equivalent`

This framework lets you express propositions that bridge representation gaps, which is essential for end-to-end verification from source to machine code.

