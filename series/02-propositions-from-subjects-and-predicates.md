# Designing a Language for Formal Verification: Propositions from Subjects and Predicates

In Core Elements, I introduced Subjects, Predicates, Propositions, and Tactics as the foundation.
Now, I will explore how to construct expressive Propositions from complex many-to-many relations of Subjects (program entities) and Predicates (their properties),
and simplifying them with Tactics to logically related Subject-Predicate Pairs readying them for proofs.
This builds a bridge between human-readable descriptions and machine-checkable rigor, all while staying flexible for your own designs.

## IRL

Consider a real-world case: Bitcoins blockchain relies on two key components:

- Transaction Validator ($V$) checks payments
- Consensus Module ($C$) validates the ledger

Developers need to ensure both terminate (complete their tasks) and stay secure (resist tampering) to keep the network reliable.
I will utilize this scenario to exemplify how a verification language can handle such demands.

## Recap: Subjects, Predicates, and Subject-Predicate Pairs

Propositions start with basic pieces.
Subjects are program entities, like Bitcoins Transaction Validator ($V$) or Consensus Module ($C$).
Predicates are verifiable claims about them, such as $terminates$ or $is secure$.
Together, they form Subject-Predicate Pairs (SPPs) the simplest form of Propostions with one Subject and one Predicate and neither contain logical operators.

Heres an SPP from our Bitcoin case: $V : terminates$

This says "the Transaction Validator terminates," a single, clear unit ready for verification.
SPPs are our goal because theyre unambiguous and provable on their own.

## Proposition Syntax

WHAT DOES NOT MEAN WHEN ATTACHED TO SUBJECTS, PREDICATES, AND PROPOSITIONS


To express Propositions precisely, I introduce a simple syntax.
Subjects (like $V$ or $C$) go on the left,
Predicates (like $terminates$ or $is_secure$) on the right,
separated by a colon `:`.
Logical operators like $\wedge$ ("and"), $\vee$ ("or"), or $\not$ ("not") connect multiples within each side.
Parentheses group Subjects and/or Predicates to show intent.
This keeps complex relationships clear and flexible,
setting the stage for construction and transformation.

## Constructing Propositions from Many-to-Many Relations

Bitcoins developers might want to claim "the Transaction Validator and Consensus Module terminate and are secure."
Thats a proposition with multiple Subjects ($V$, $C$) and Predicates ($terminates$, $is_secure$), linked logically.
Let's state it in a more precise way:

$(V \wedge C) : (terminates \wedge is_secure)$

This captures the full claim.
Subjects $V \wedge C$ pair with Predicates $terminates \wedge is_secure$, using $\wedge$ for "and."
A simpler case:

- One Subject, multiple Predicates: $V : (terminates \wedge is_secure)$
- Multiple Subjects, one Predicate: $(V \wedge C) : terminates$

These reflect natural ways to describe programs flexible, expressive, and tied to real needs like Bitcoins reliability.
Logical operators like $\vee$ or $\neg$ could extend this further, but our scenario sticks with $\wedge$ for now.

## The Challenge of Ambiguity

Complex propositions can blur intent.
In $(V \wedge C) : (terminates \wedge is_secure)$,
does every Subject get every Predicate,
or might the developer mean "$V$ terminates, and $C$ is secure"?
Without clarity, verification could misfire.

If you misread this, V might terminate while C gets hacked, breaking Bitcoin’s trust.
Compare:

- Intended: $(V \vee C) : (terminates \wedge is_secure)$
- Misread: $(V : terminates) \vee (C : is_secure)$

Grouping with parentheses hints at the difference,
but ambiguity lingers in loose descriptions.
A good language needs structure to lock in one meaning.

## Tactics: Transforming Propositions into SPPs

Tactics are the solution: logical steps that turn compound propositions into SPPs, preserving meaning.
Take Bitcoins full claim:

- Input: $(V \wedge C) : (terminates \wedge is_secure)$
- Output: $(V : terminates) \wedge (V : is_secure) \wedge (C : terminates) \wedge (C : is_secure)$

Each SPP stands alone, ready to be proven.
Tactics simplify Subjects and Predicates systematically.
For a simpler case:

- Input: $V : (terminates \wedge is_secure)$
- Output: $(V : terminates) \wedge (V : is_secure)$

Tactics adapt to structure, splitting where $\wedge$ appears.
This keeps the process generalyou decide how to implement it.

## Next Steps: Formalizing Tactics

I have shown you how Tactics split complex Propositions into SPPs,
but how do your formalize this?
You need to define two things a:

- formal algebra
- defined algorithm

To turn this into an algebra,
you would define rules (Associative, Commutative, and Distributive) for how operators like $\wedge$, $\vee$, and $\not$ interact with the colon $:$.
Think of it as a grammar defining how Subjects (e.g., $V \wedge C$) distribute over Predicates (e.g., $terminates \wedge is_secure$), handling scoping (like parentheses), and ensuring equivalence.
For Bitcoin, this means guaranteeing $(V \wedge C) : (terminates \wedge is_secure)$ always breaks the same way.

For a Tactics algorithm, you define an iterative or a recursive step-by-step algorithm that utilizes your algebra to reduce complex Propositions to SPPs.

## Next Steps: Formalizing Tactics

Weve seen Tactics split complex Propositions into SPPs, but how do you formalize this? Two pieces are needed:

I have shown you how
- Subjects and Predicates can be composed to form Propositions
MISSING ONE ITEM
- Tactics split complex Propositions into SPPs,

EXPLAIN HOW TO COMPOSE THE SUBJECTS AND PREDICATES

**Formal Algebra**: Define ruleslike associative, commutative, or distributivefor how operators ($$, $$, $¬$) work with the colon $:$. Its a grammar to ensure Subjects (e.g., $V  C$) distribute over Predicates (e.g., $terminates  is_secure$), respecting scoping (like parentheses) and preserving meaning. For Bitcoin, this locks in how $(V  C) : (terminates  is_secure)$ breaks down consistently.

**Tactics Algorithm**: Craft an iterative or recursive step-by-step process using the algebra to reduce any Proposition to SPPs. Itd handle varied structures, ensuring $V$ and $C$s claims split reliably every time.

These steps turn a flexible idea into a precise toolready for bigger challenges.


## Connecting to Formal Verification

Bitcoin's network thrives if $V$ and $C$ terminate and stay secure.
Verification uses Tactics to break $(V \wedge C) : (terminates \wedge is_secure)$ into SPPs,
which are then ready to be proven.
However, the details of proofs are beyond the scope of theis article and will addressed later.

## Design Implications and User Experience

This approach balances two worlds.
Developers write $(V \wedge C) : (terminates \wedge is_secure)$ naturally, reflecting Bitcoins needs.
Tactics handle the split into SPPs, ensuring precision without burdening the user.
Grouping (like parentheses) or operators (like $\wedge$) clarify intent, while the system simplifies.
Its expressive yet provable, a hybrid design open to your tweaks.

## Conclusion

Bitcoins Transaction Validator and Consensus Module show how Propositions capture complex program behaviors of many Subjects and many Predicates woven together with logic.
Tactics transform these into SPPs, making verification practical.
This framework lets you craft rich claims and prove them rigorously, flexible to your own tools and designs.

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

#Add #Some #Hashtags
