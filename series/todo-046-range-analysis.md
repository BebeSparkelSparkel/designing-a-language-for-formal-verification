## Title
**"Designing a Language for Formal Verification: Range Analysis"**

## Introduction

In [Is it a Function?](link-to-04), we established how to verify function identity across representation levels. In [Reference Resolution](link-to-4.5), we examined the atomic elements within function definitions - ensuring all variables and function calls refer to defined entities. Now we turn to a crucial bridge between structural verification and behavioral analysis: understanding how subsets of a function's input domain relate to subsets of its output range.

Traditional function analysis treats the entire domain-to-codomain mapping as a single relationship. But for verification purposes, we often need more granular analysis. Consider a function that behaves differently for positive versus negative inputs, or one that produces different output types based on conditional logic. **Range analysis** examines how restricting the input domain affects the possible outputs, providing essential groundwork for the totality verification we'll explore in subsequent articles.

This analysis bridges our progression from identifying function components to proving function behavior by introducing **conditional domain-range relationships** - the foundation needed to reason about how functions behave across their entire input space. We'll demonstrate how to verify that for a given subset of inputs, a function produces a predictable subset of outputs, setting the stage for proving complete domain coverage and termination properties.

By working through examples across different representation levels - from source code conditional logic to parse tree analysis to IR optimization effects - we'll show how range analysis maintains our multi-level verification approach while adding the relational reasoning necessary for behavioral verification.

## Context Notes for Article 4.7

### Multi-Level Range Analysis

**Source Code Level:**
- Analyzing conditional statements (if/else, switch) to determine output ranges for different input conditions
- Tracking how variable assignments affect possible return values
- Understanding how loop bounds and conditions constrain outputs
- Examining exception handling paths and their effect on possible returns

**Parse Tree Level:**
- AST traversal to identify conditional branches and their associated value ranges
- Type inference and constraint propagation through expression trees
- Analysis of literal values and constant expressions
- Structural analysis of control flow constructs

**IR Level:**
- Basic block analysis to determine value ranges through different execution paths
- SSA (Static Single Assignment) form analysis for precise value tracking
- Optimization-preserved range information
- Phi node analysis for value merging at control flow joins

**Machine Code Level:**
- Register value range analysis through conditional branches
- Jump target analysis and associated value constraints
- Hardware-specific value representation limits
- Runtime constraint verification where applicable

### Range Analysis Techniques

**Interval Analysis:**
- Tracking minimum and maximum possible values for numeric types
- Handling arithmetic operations on intervals
- Overflow and underflow detection
- Precision loss analysis in floating-point operations

**Symbolic Range Analysis:**
- Tracking ranges in terms of input parameters
- Constraint satisfaction for complex conditional logic
- Parametric bounds analysis
- Relationship preservation between variables

**Type-Based Range Analysis:**
- Enum value analysis (all possible enum values for given conditions)
- Boolean condition analysis (true/false ranges)
- Pointer analysis (null/non-null, valid memory ranges)
- String length and content constraints

**Conditional Constraint Propagation:**
- Forward propagation: how input constraints affect output ranges
- Backward propagation: what input constraints are needed for desired output ranges
- Path sensitivity: different ranges for different execution paths
- Context sensitivity: ranges dependent on calling context

### Input Domain Subdivision

**Natural Domain Partitions:**
- Positive/negative/zero partitions for numeric inputs
- Empty/non-empty partitions for collections
- Null/non-null partitions for reference types
- Valid/invalid partitions for constrained types

**Conditional-Based Partitions:**
- Partitions created by if-statements and guard conditions
- Switch statement case partitions
- Exception condition partitions
- Loop entry/exit condition partitions

**Boundary Value Analysis:**
- Edge cases at domain boundaries
- Off-by-one error detection
- Overflow/underflow boundary conditions
- Type limit boundaries (max int, precision limits)

### Output Range Characterization

**Value Set Analysis:**
- Discrete sets of possible output values
- Enumeration of all possible returns for finite domains
- Probability distributions for stochastic outputs
- Worst-case vs average-case output analysis

**Range Relationships:**
- Monotonic relationships (input increase  output increase)
- Inverse relationships (input increase  output decrease)
- Piecewise relationships (different behaviors in different ranges)
- Non-deterministic relationships (same input  multiple possible outputs)

**Output Constraints:**
- Type constraints on return values
- Business logic constraints (e.g., positive monetary values)
- Physical constraints (e.g., valid coordinates)
- Performance constraints (e.g., bounded execution time)

### Verification Targets

**Range Completeness:**
- Verify that all possible input values produce some output value
- Identify input values that produce no output (potentially infinite loops)
- Check for undefined behavior regions

**Range Consistency:**
- Verify output ranges match function specification
- Check that declared return types can accommodate actual output ranges
- Ensure range analysis is consistent across representation levels

**Range Preservation:**
- Verify that optimizations preserve semantic output ranges
- Check that compilation doesn't introduce range violations
- Ensure debug/release builds have consistent ranges

### Integration with Previous Articles

**Building on Article 4.5 (Reference Resolution):**
- Use resolved function calls to analyze ranges through call chains
- Track variable assignments and their effect on output ranges
- Leverage type information from resolved references

**Building on Article 04 (Function Structure):**
- Apply range analysis to identified function parameters and returns
- Use structural information to guide range analysis scope
- Maintain multi-level verification consistency

**Preparing for Article 4.8 (Dead Code Elimination):**
- Identify impossible value ranges that indicate unreachable code
- Use range analysis to prove certain conditions are always true/false
- Establish reachability constraints based on input value ranges

### Advanced Range Analysis

**Interprocedural Analysis:**
- Range propagation through function call chains
- Context-sensitive range analysis for called functions
- Return value range composition

**Loop Range Analysis:**
- Induction variable analysis
- Loop bound computation
- Fixed-point analysis for convergence
- Widening and narrowing operations for infinite ranges

**Pointer and Reference Range Analysis:**
- Memory location ranges
- Alias analysis integration
- Buffer bound analysis
- Null pointer range tracking


