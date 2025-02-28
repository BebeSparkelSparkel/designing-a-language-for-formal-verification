# DRAFT

# Designing a Language for Formal Verification: Introduction and Purpose

## The Problem with Current Approaches

Programming language design has long been dominated by type systems. From C's primitive types to Haskell's algebraic data types to Idris's dependent types, the evolution has focused on increasingly sophisticated ways to constrain programs at compile time. Yet despite these advances, bugs persist. Security vulnerabilities multiply. And formal verification—the holy grail of software correctness—remains largely inaccessible to everyday developers.

Why? Because **types are merely poor implementations of proofs**.

Consider TypeScript, a language created by a team of hundreds, spamming nearly a million lines of code across thousands of files. Its type system is powerful but ultimately limited by its fundamental design: types serve as proxies for properties we actually care about. They hint at behavior without directly expressing or verifying it. Even the most advanced dependent type systems struggle to bridge this gap between what we can type and what we need to prove.

## A New Foundation: Burning It Down

This series explores a radical premise: What if we built programming languages around propositions and their proofs instead of types?

Rather than starting with syntax or even with a type system, I propose returning to first principles. The foundation of a verification-oriented language should begin with the core elements of logical reasoning, which will be explored in detail in subsequent articles.

This is not merely academic. By reimagining language design from the ground up, we might create systems where verification isn't a burdensome afterthought but the natural way to program.

## Beyond Coq and Agda: A Different Path

Existing verification systems like Coq and Agda offer powerful capabilities but follow divergent philosophies. Coq emphasizes tactics and proofs but maintains a separation between program construction and verification. Agda unifies proofs and programs through dependent types but often sacrifices flexibility for correctness guarantees.

The approach outlined in this series differs from both:

- Unlike Coq, it seeks to integrate verification directly into the core language rather than as a separate layer
- Unlike Agda, it doesn't force all code through the bottleneck of a type system
- Unlike both, it follows a semantic-first approach that defers syntax decisions until the meaning is clear

By leveraging tactics like Coq while avoiding the constraints of a traditional type system, this approach aims to provide flexibility in when and how verification occurs. Properties can remain dynamic unless explicitly constrained by propositions, which must then be proven.

## Semantics First: Learning from History

Historically, most languages are designed syntax-first. Designers craft keywords, operators, and grammar rules before fully understanding the semantic model they're trying to express. This leads to semantic compromises and resistance to evolution.

Consider Lisp's success: McCarthy didn't start with parentheses; he started with a mathematical model of computation based on lambda calculus and recursive functions. The S-expression syntax followed as a practical notation for representing these abstract concepts.

This series embraces a similar approach:

1. Define the semantic model (propositions, proofs, validation rules)
2. Represent this model in structured formats (JSON Schema, formal notation)
3. Only later design syntax as views into this semantic model

This semantic-first approach enables us to reason more deeply about program properties before getting caught in syntactic debates.

## The Practical Benefits: Working Smarter, Not Larger

A small team cannot hope to match the resources behind a TypeScript or a Rust. But they can work smarter by leveraging formal methods.

By building verification into the core of a language, we can:

1. Catch entire classes of bugs through automated reasoning
2. Reduce test burden by proving properties once rather than testing edge cases repeatedly
3. Enable progressive verification where critical components receive more scrutiny
4. Maintain correctness during evolution and refactoring

The compiler itself becomes an active partner in development rather than a gatekeeper, helping construct proofs that programs behave as intended.

## What This Series Will Cover

This series will explore a comprehensive range of topics necessary for building a verification-oriented language. The initial articles will establish the foundation:

1. **Core Elements**: The fundamental building blocks of a proof-oriented language
2. **Proposition Construction**: How to formulate claims about program properties
3. **Tactics as Proof**: Using transformations to establish truth

As the series progresses, we'll expand into more advanced territory, including but not limited to:

- Function and algorithm verification
- Proof composition and reuse mechanisms
- State and effects within a proof framework
- Concurrency and distributed systems verification
- Module systems and abstraction boundaries
- Practical tooling and development workflows

Each article will build on previous foundations while acknowledging mathematical limitations and practical trade-offs. The series is designed to be open-ended, adapting to discoveries made along the way rather than following a rigid predetermined structure.

## Acknowledging Limitations

No verification approach can escape fundamental mathematical barriers. From Gödel's Incompleteness Theorems to Rice's Theorem on program properties to the undecidability of the Halting Problem, certain limitations constrain what any system can verify automatically.

This series doesn't claim to solve these theoretical challenges. Instead, it proposes a pragmatic approach that:

1. Makes formal verification more accessible without requiring doctoral-level expertise
2. Provides clear escape hatches when automation fails
3. Supports progressive verification where properties are proven as needed
4. Acknowledges where human judgment must supplement machine reasoning

## The Vision: Designing for Practical Verification

The ultimate goal is not to design yet another academic proof assistant, but to explore the architecture of a practical programming language where verification is integrated into everyday development. Where properties that matter can be expressed and proven without switching tools or mental models. Where the gap between specification and implementation narrows.

By rethinking how programs express meaning and how that meaning is verified, we can create better tools for building correct software—tools accessible to more than just verification specialists.

In the next article [Core Elements](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/01-core-elements.md), we'll explore the core elements of this verification system in depth, establishing the foundation upon which everything else will build.

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

#FormalVerification #ProgrammingLanguages #ProofAssistants #LanguageDesign #Semantics
