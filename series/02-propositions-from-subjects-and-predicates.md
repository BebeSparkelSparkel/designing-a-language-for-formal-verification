# Designing a Language for Formal Verification: Propositions from Subjects and Predicates

In [Core Elements](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/01-core-elements.md),
I introduced Subjects, Predicates, Propositions, and Tactics as the foundation.
Now, I will explore how to construct expressive Propositions from complex
many-to-many relations of Subjects (program entities) and Predicates (their
properties), and simplifying them with Tactics to logically related
Subject-Predicate Pairs readying them for proofs.
This builds a bridge between complex proposition constructors and
machine-checkable rigor, all while staying flexible for your own designs.

## IRL

Consider a real-world case: Bitcoin's blockchain relies on two key components:

- Transaction Validator ($V$) checks payments
- Consensus Module ($C$) validates the ledger

Developers need to ensure both terminate (complete their tasks)
and stay secure (resist tampering) to keep the network reliable.
I will utilize this scenario to exemplify how a verification language can
handle such demands.

## Recap: Subjects, Predicates, and Subject-Predicate Pairs

Propositions start with basic pieces.
Subjects are program entities,
like Bitcoin's Transaction Validator ($V$) or Consensus Module ($C$).
Predicates are verifiable claims about them,
such as $terminates$ or $is secure$.
Together, they form Subject-Predicate Pairs (SPPs),
the simplest form of Propositions,
with one Subject and one Predicate and neither contain logical operators.

Here is an SPP from our Bitcoin case: $V : terminates$

This says "the Transaction Validator terminates,"
a single, clear unit ready for verification.
SPPs are our goal because they're unambiguous and provable on their own.

## Proposition Syntax

To express Propositions precisely, I introduce a simple syntax.
Subjects (like $V$ or $C$) go on the left,
Predicates (like $terminates$ or $is_secure$) on the right,
separated by a colon `:`.
Logical operators like $\land$ ("and")
and $\lor$ ("or") connect multiples within each side.
Parentheses group Subjects and/or Predicates to show intent.
This keeps complex relationships clear and flexible,
setting the stage for construction and transformation.

## Constructing Propositions from Many-to-Many Relations

Bitcoin developers might want to claim
"the Transaction Validator and Consensus Module terminate and are secure."
That's a proposition with multiple Subjects ($V$, $C$)
and Predicates ($terminates$, $is_secure$), linked logically.
Let's state it in a more precise way:

$(V \land C) : (terminates \land is_secure)$

This captures the full claim.
Subjects $V \land C$ pair with Predicates $terminates \land is_secure$,
using $\land$ for "and."
A simpler case:

- One Subject, multiple Predicates: $V : (terminates \land is_secure)$
- Multiple Subjects, one Predicate: $(V \land C) : terminates$

These reflect natural ways to describe programs
flexible, expressive, and tied to real needs like Bitcoin's reliability.
Logical operators like $\lor$ or $\neg$ could extend this further,
but our scenario sticks with $\land$ for now.

## The Challenge of Ambiguity

Complex propositions can blur intent.
In $(V \land C) : (terminates \land is_secure)$,
does every Subject get every Predicate,
or might the developer mean "$V$ terminates, and $C$ is secure"?
Without clarity, verification could misfire.

If you misread this, V might terminate while C gets hacked, breaking Bitcoin’s trust.
Compare:

- Intended: $(V \lor C) : (terminates \land is_secure)$
- Misread: $(V : terminates) \lor (C : is_secure)$

Grouping with parentheses hints at the difference,
but ambiguity lingers in loose descriptions.
A good language needs structure to lock in one meaning.

## Tactics: Transforming Propositions into SPPs

Tactics are the solution for specifying the steps to transform compound
propositions into SPPs while preserving their meaning.
Take Bitcoin's full claim:

- Input: $(V \land C) : (terminates \land is_secure)$
- Output: $(V : terminates) \land (V : is_secure) \land (C : terminates) \land (C : is_secure)$

Each SPP stands alone, ready to be proven.
Tactics simplify Subjects and Predicates systematically.
For a simpler case:

- Input: $V : (terminates \land is_secure)$
- Output: $(V : terminates) \land (V : is_secure)$

Tactics adapt to structure, splitting where $\land$ appears.
This keeps the process general, you decide how to implement it.

## Formalizing Tactics

I have shown you how:

- The standard-distributive operator ($:$) relates Subjects and Predicates
- Tactics split complex Propositions into SPPs

How do you formalize this?
You need to define three things:

**Subjects Predicates Operators (SPOs)**: There are more ways than just the
standard-distributive operator ($:$) to relate Subjects and Predicates.
In fact there are probably many, and the appendix covers this in detail.
You will have to choose your own set of SPOs.

**Formal Algebra**: Define rules (like: associative, commutative, and
distributive) for how operators ($\land$, $\lor$) work with your chosen SPOs.
This creates a grammar to ensure Subjects (e.g., $V \land C$) distribute over
Predicates (e.g., $terminates \land is_secure$), respecting scoping (like
parentheses) and preserving meaning.

**Tactics Algorithm**: Define an iterative or recursive step-by-step process
utilizing your algebra to reduce complex Proposition to SPPs.

## Connecting to Formal Verification

Bitcoin's network thrives if $V$ and $C$ terminate and stay secure.
Verification uses Tactics to break
$(V \land C) : (terminates \land is_secure)$
into SPPs, which are then ready to be proven.
However, the details of proofs are beyond the scope of this article and will
addressed later in
[Designing a Language for Formal Verification: Tactically Utilizing Theorems in Proofs](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/3-tactics-as-proof.md).

## Design Implications and User Experience

This approach balances two worlds.
Developers write
$(V \land C) : (terminates \land is_secure)$
naturally, reflecting Bitcoin's needs.
Tactics handle the split into SPPs,
ensuring precision without burdening the user.
Grouping (like parentheses) or operators (like $\land$) clarify intent,
while the system simplifies.
Its expressive yet provable, a hybrid design open to your tweaks.

## Conclusion

Bitcoin's Transaction Validator and Consensus Module show how Propositions
capture complex program behaviors of many Subjects and many Predicates woven
together with logic.
Tactics transform these into SPPs, making verification practical.
This framework lets you craft rich claims and prove them rigorously, flexible
to your own tools and designs.

While I've laid the groundwork for constructing expressive propositions and
transforming them into provable Subject-Predicate Pairs, the journey doesn't
end here.
Stay tuned for more: I'll dive deeper into
[crafting robust Subjects](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/13-constructing-subjects.md),
[defining precise Predicates](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/16-constructing-predicates.md),
and
[refining Propositions](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/3-tactics-as-proof.md)
in upcoming articles.
Plus, I'm putting the finishing touches on a piece that ties it all together,
unveiling how
[Tactics harness theorems to power rigorous proofs](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/018-constructing-propositions.md).
The bridge between human intuition and machine-checked verification is just
beginning to take shape!

What do you think so far?
Share your thoughts, critiques, or ideas in the comments.
I'd love to hear how this framework resonates with you and where you'd like it
to go next.

[Source on GitHub](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/2-propositions-from-subjects-and-predicates.md)

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

# Appendix

## The Predicate-Distributive Operator

While the standard-distributive operator ($:$) distributes over both subjects
and predicates,
some verification scenarios require a different distribution pattern.
The predicate-distributive operator ($\triangleright$) provides this
alternative by distributing over predicates but treating logically related
subjects as a cohesive unit.

### Definition and Distribution Rules

The predicate-distributive operator ($\triangleright$) follows these rules:

$(S_1 \land S_2) \triangleright P \neq (S_1 \triangleright P) \land (S_2 \triangleright P)$

$S \triangleright (P_1 \land P_2) \equiv (S \triangleright P_1) \land (S \triangleright P_2)$

This means:
- When multiple subjects are connected to a predicate, they must be treated as
  a whole unit
- When a subject is connected to multiple predicates, each predicate can be
  verified separately

### When to Use the Predicate-Distributive Operator

The predicate-distributive operator is particularly valuable when verifying
emergent properties that arise from component interactions.
Consider these examples from various distributed systems:

1. **Security Through Interaction**:
    $(V \land C) \triangleright is\_secure$
    indicates that the Transaction Validator and Consensus Module together
    create security,
    but neither component alone would be sufficient.
1. **Holistic Performance**:
    $(Network \land Database) \triangleright scalable$
    expresses that scalability emerges from the interaction between these
    components,
    not from either component independently.
1. **Fault Tolerance**:
    $(Primary \land Backup) \triangleright fault\_tolerant$
    captures that fault tolerance is a property of the combined system, not of
    individual components.
1. **Termination Guarantee**:
    $(Process_A \lor Process_B) \triangleright terminates$
    expresses that either of two interdependent processes running in parallel
    will ensure termination,
    but this property emerges from their interaction. Neither process alone can
    guarantee termination,
    as each may depend on results from the other in certain execution paths.
    The logical $\lor$ indicates that at least one process must complete for
    the system to terminate properly.

In each case, breaking down the subjects would lose the essential interaction
being verified.

### Contrast with the Standard-Distributive Operator

To understand the difference,
consider both operators applied to the same statement:

Standard-distributive:

$(V \land C) : is\_secure \equiv (V : is\_secure) \land (C : is\_secure)$

This states that each component independently guarantees security.

Predicate-distributive:

$(V \land C) \triangleright is\_secure \neq (V \triangleright is\_secure) \land (C \triangleright is\_secure)$

This states that security emerges from their interaction and cannot be verified
by examining each component separately.

### Mixed Operators Example

The predicate-distributive operator also clarifies verification when handling
mixed logical connectives in subject composition:

$$
(V \land C) \triangleright (terminates \land is\_secure) \equiv
(V \land C) \triangleright terminates \land (V \land C) \triangleright is\_secure
$$

This states that the combined system must both terminate and be secure,
while preserving the requirement that these properties be verified against the
components acting together.

### Implementation in Tactics

When implementing Tactics for verification, the predicate-distributive operator
requires special handling:

1. Predicates can still be distributed:
    $S \triangleright (P_1 \land P_2)$
    transforms to
    $(S \triangleright P_1) \land (S \triangleright P_2)$
1. Subjects must be kept intact:
    $(S_1 \land S_2) \triangleright P$
    remains as an atomic unit
1. Verification methods must address the interactions between components rather
than verifying each component in isolation

By preserving the logical structure of interdependent subjects while still
allowing predicate distribution,
this operator enables verification of component interactions,
which would otherwise be impossible if each component were verified in
isolation.

## Considered but Rejected Subject-Predicate Operators

I have explored many subject-predicate pairing operators beyond the
standard-distributive operator ($:$).
These operators would have introduced different distributive properties or
specialized verification relationships.
After careful consideration,
I rejected these alternatives for the reasons outlined below.

### Left-Distributive Only Operator ($\triangleleft$)

**Purpose**: This operator would distribute over subjects but not predicates,
allowing statements like:

$$
(S_1 \land S_2) \triangleleft P \equiv
(S_1 \triangleleft P) \land (S_2 \triangleleft P)
$$

$$
S \triangleleft (P_1 \land P_2) \neq
(S \triangleleft P_1) \land (S \triangleleft P_2)
$$

**Rejection Rationale**: Preventing distribution over predicates contradicts
the nature of logical conjunction.
Interdependencies between predicates are better handled through more precise
predicate definitions than by altering distribution rules.

### Non-Distributive Operator ($\oplus$)

**Purpose**: This operator would prevent distribution over both subjects and
predicates,
forcing atomic treatment of subject-predicate pairs:

$(S_1 \land S_2) \oplus P \neq (S_1 \oplus P) \land (S_2 \oplus P)$

$S \oplus (P_1 \land P_2) \neq (S \oplus P_1) \land (S \oplus P_2)$

**Rejection Rationale**: Non-distributive relationships can be expressed
through composition of existing operators.
Cases requiring full non-distribution typically indicate properties that should
be reformulated or belong at a higher logical level.

### Contextual Operator ($\bowtie$)

**Purpose**: This operator would carry dependency information between subjects:

$$
(S_1 \land S_2) \bowtie P \equiv
(S_1 \bowtie P) \land (S_2 \bowtie P[S_1])
$$

Where $P[S_1]$ means "P in the context established by $S_1$".

**Rejection Rationale**: This operator primarily acts as a scoping mechanism.
Contextual dependencies can be more clearly expressed within predicates,
maintaining separation between composition and predicate content.

### Temporal Operator ($\vdash$)

**Purpose**: This operator would express temporal properties:

$S \vdash P$

Where P is a property that must hold at some point during S's execution.

**Rejection Rationale**: Temporal aspects are better encoded within predicates
(e.g., "eventually_terminates") rather than in the composition mechanism.
This separates temporal logic from basic subject-predicate composition.

### Probabilistic Operator ($\approx$)

**Purpose**: This operator would express stochastic properties:

$S \approx P$

Meaning S satisfies P with some probability.

**Rejection Rationale**: Probabilistic verification belongs to a different
logical system than our core framework.
These aspects are better handled through probabilistic predicates or a separate
verification layer.

### Resource-Aware Operator ($\multimap$)

**Purpose**: This operator would incorporate resource consumption semantics:

$S_1 \multimap P_1, S_2 \multimap P_2 \vdash (S_1 \otimes S_2) \multimap (P_1
\otimes P_2)$

Where $\otimes$ represents resource composition.
For example, a memory allocator might satisfy "uses at most 100KB" while a
cache satisfies "uses at most 50KB",
but their composition might need to satisfy "uses at most 140KB" (due to
sharing) rather than simply "uses at most 150KB".

**Rejection Rationale**: Resource awareness is better expressed within
predicates (e.g., "uses_at_most_memory(x)") rather than in the composition
mechanism.
This maintains a clear distinction between subject-predicate relationships and
resource semantics.

### Permission-Based Operator ($\Join$)

**Purpose**: This operator would incorporate access control information:

$(S \text{ with permission } A) \Join P$

**Rejection Rationale**: Permissions are better modeled as attributes of
subjects rather than as specialized verification relationships.
This treats permissions as properties of the entities being verified.

### Refinement Operator ($\sqsubseteq$)

**Purpose**: This operator would express implementation relationships:

$S \sqsubseteq P$

Indicating that S refines or implements P.

**Rejection Rationale**: Refinement is a specialized concept from type theory.
Rather than baking this into our core operators, refinement relationships can
be expressed through our more general mechanisms when needed.

### Modal Operators ($\square$, $\diamond$)

**Purpose**: These operators would express necessity and possibility:

$S \square P$ (S necessarily satisfies P)

$S \diamond P$ (S possibly satisfies P)

With distribution properties from modal logic:

$(S_1 \land S_2) \square P \Rightarrow (S_1 \square P) \land (S_2 \square P)$

$(S_1 \lor S_2) \diamond P \Leftarrow (S_1 \diamond P) \lor (S_2 \diamond P)$

**Rejection Rationale**: Modal concepts belong to modal logic, a higher-level
system than our basic framework.
These can be expressed through defined predicates (e.g.,
"necessarily_terminates") or
through a separate modal logic layer.

### Parameterized Verification Operator ($\vdash_p$)

**Purpose**: This operator would make verification parameters explicit:

$S \vdash_p P$

Where p represents parameters affecting verification, with distribution
depending on parameter relationships:

$(S_1 \land S_2) \vdash_p P \equiv (S_1 \vdash_{p_1} P) \land (S_2 \vdash_{p_2} P)$ where p is derived from $p_1$ and $p_2$

For example, verifying that a sorting algorithm is correct might depend on
parameters like input size limits or comparison function properties.

**Rejection Rationale**: Verification parameters are better handled as part of
predicate definitions or as explicit preconditions.
Adding parameters to the core relationship unnecessarily complicates the basic
framework.

### Conditional Verification Operator ($\Rightarrow$)

**Purpose**: This operator would express conditional verification:

$C \Rightarrow (S : P)$

Where C is a condition under which S must satisfy P, with distribution:

$$
C \Rightarrow (S_1 \land S_2) : P \equiv
(C \Rightarrow S_1 : P) \land (C \Rightarrow S_2 : P)
$$

**Rejection Rationale**: This operator functions at the propositional level
rather than the composition level.
Conditional verification is better expressed through standard propositional
logic rather than mixing levels of logical expression.

### Hierarchical Verification Operator ($\triangleleft$)

**Purpose**: This operator would express verification across abstraction layers:

$S \triangleleft P$

For hierarchical decomposition where verification at one level implies
properties at another:

$S \triangleleft P \land (S' \sqsubseteq S) \Rightarrow S' \triangleleft P'$

Where P' is derived from P through the refinement relationship.
This would allow verification of systems with multiple levels of abstraction,
such as verifying a high-level architecture and propagating properties to
implementation components.

**Rejection Rationale**: Hierarchical verification involves abstraction and
refinement concepts that extend beyond basic composition.
These relationships are better handled through a higher-level framework built
on top of our core system.

### Bidirectional Implication Operator ($\leftrightarrow$)

**Purpose**: This operator would express complete characterization:

$S \leftrightarrow P$

Indicating that S satisfies P and P fully characterizes S (P is necessary and
sufficient for S).
Unlike standard subject-predicate relationships,
this would assert that nothing other than S could satisfy P.

**Rejection Rationale**: Complete characterization involves semantics beyond
basic verification,
suggesting a relationship more akin to definition.
This concept belongs more to specification or type theory and can be expressed
through existing logical constructs.

By rejecting these specialized operators,
I maintain a simpler verification framework while preserving the ability to
express complex relationships through composition of a minimal set of operators.
This balances expressiveness with clarity,
making our framework more accessible yet powerful.

#FormalVerification, #Blockchain, #ProgrammingLanguages #Logic
