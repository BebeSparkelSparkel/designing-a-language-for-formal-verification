# Draft

# Designing a Language for Formal Verification: Constructing Subjects

introduction

definition of subject from 01

<!--
The "construction" of subjects is a select specificaiton of language elements/entities (LE).

It is important that the subject selection sub-components are themselves LEs so that they can made into subjects and associated with a predicate to create propositions so that properties about them can be proven.

Many LEs are actually aliases for groups of related LEs. If a LE is an aliase, then it must be expanded (probably with tactics).

When examining useful predicates like terminiates, uses less than X memory, is defined for all x in the Integers, etc. the subject becomse much more complex.

For terminates:
- it could mean base entirely on the composition of the language endities or it could also include the resulting machine code as well

For uses less than X memory, the subject now must be able to specify:
- branching logic
- function application
- sum expressions
- deallocation (but I'm not sure if this a subject or something else)

For is defined for all x in the Integers, support recursive expansion to inspect every utilization of x in its context (may be a sub-set due to conditional logic).

Further thoughts:

Subjects are first specified with  a language entity selector (may be context aware). Then a context (source text, parse tree, intermediate representation (IR) production, final target production, etc.) must be specified so the predicate can be applied to the correct target. Once the correct target is resolved, it becomes the new subject.

Beyond the target specification, other subject transforms will be required and should be definable.
-->

## Examples

### Terminates

$terminates(f) = \forall x \in domain(f) : \bot \not = f(x)$ states that $f$ must terminate.

$f = \\{f_s, f_p, f_i, f_m, ...\\}$
exists at multiple levels of compilation:

- Source text ($f_s$)
- Parse tree ($f_p$)  
- Intermediate representation ($f_i$)
- Machine code or other final target ($f_m$)

Without a representation specifier, $f$ encompasses all levels:
$f = \\{f_s, f_p, f_i, f_m, ...\\}$

For example if $f(x) = g(x) + h(x)$, then $f$ is an alias requiring recursive de-aliasing.

1. $f(x)$
2. $g(x) + h(x)$ or $add(g(x), h(x))$
3. ... (recursively de-alias)

This next part is subject predicate algebra not strictly subject related.

1. $terminates(add(g(x), h(x)))$
2. $\forall x \in domain(f) : \bot \not = add(g(x), h(x))$
3. $\forall x \in domain(f) \exists y = g(x), z = h(x) : \bot \not = g(x) \land \bot \not = h(x) \land \bot \not = and(y, z)$

<!--
$P = \forall x \in X : \bot \not = f(x)$

For all values in set $X$, function $f$ will terminate.
$f$ exists at multiple levels of compilation
- source text
- parse tree
- IR
- machine code or other final target
without a specifier $f$ encompasses all of these as $f = { f_s, f_i, f_m, ...}$

$f$, $X$ is the subject the rest is the predicate.

If $f(x) = g(x) + h(x) = add(g(x), f(x))$, then $f$ is an alias and the proposition needs to be applied to each of the aliased functions with recurseive de-aliasing like $(\forall x \in X : \bot \not = g(x) \land \bot \not = h(x)) \land (\forall x, y = g(x), x = h(x) : \bot \not = add(y, z))$.

### Terminates Example

**Proposition**: $\Pi = \forall x \in X : \bot \neq f(x)$

For all values in set $X$, function $f$ will terminate.

**Multi-Level Subject Reality**: Function $f$ exists at multiple compilation
stages:

Without a representation specifier, $f$ encompasses all levels:
$f = \\{f_s, f_p, f_i, f_m, ...\\}$

In this proposition, $f$ and $X$ constitute the subject, while the rest forms the predicate.

If $f(x) = g(x) + h(x)$, then $f$ is an alias requiring recursive de-aliasing.
The proposition transforms through tactics to address each constituent function:
$(\forall x \in X : \bot \neq g(x) \land \bot \neq h(x)) \land (\forall x, y = g(x), z = h(x) : \bot \neq add(y, z))$
This expansion ensures that termination verification covers all computational components involved in $f$'s execution, not just the high-level alias.
Expansion will have to be recursively evaluated until all aliasing has been removed.
It may be possible to cache results for aliases if the predicate has already been proven for its expanded form.
-->

### Function Invocation

As with type checking and refinement types, values passed to functions as parameters should be allowed to be constrained/limited to a defined set.
I am not sure what the best approch to defining this constraining set. Perhaps by:
- explicit logical constraints
- implicit darivation from the function
- explicitly specified exclusion

$\bar{G} = { f \mid \forall f \in \Pi : g \in \bar{f} }$
The set of functions/contexts contained in program $\Pi$ that contain the function g in the definition of $\bar{f}.
$\bar{f}$ is the set of functions and variables defining $f$.

$X = { x \mid \forall f \in \Pi, x \in \bar{f} : g(x) \in \bar{f} }$
$X$ is the set of all possible values passed to $g$ in program $\Pi$ with in function/context $f$.

$E = { f \mid \forall f \in \Pi, x \in \bar{f}, : x \not \in G }$
$E$ is the set of contexts where a value is given to $g$ that does not reside in its valid input set $G$.

### Function Invocation

Values passed to functions should be proven to be contained in the domain (valid set of values for that parameter.

$invocations(\Pi, f)$ specifies all the invocation/utilization locations $\\{l_0, l_1, ...\\}$ of $f$ in program $\Pi$.

$parameters(f, l)$ is parameter set $\langle x_0, x_1, ..., x_{arity(f)} \rangle$ for function $f$ at location $l$.
Note this does not specify how to determine the parameter set, which will be presented later.

$parameterErrors(\Pi, f) = \\{ l \mid \forall l \in invocations(\Pi, f) : parameters(f, l) \not \subseteq domain(f) \\}$
is the set of locations in program $\Pi$ that function $f$ has a parameter error.

<!--
Propostions $P$ must be able to express this, so the subject $S$ needs to be able to represent all the locations $L$ of function $f$ invocation $I$ and the context $c$ of that location $l$ for evaluation of the possible values $X$ of the parameter $x$.

The the location and context pairs $I = \\{ \langle l_0, c_0 \rangle, ... \\}$ can be found with
$I(f) = \\{ \langle l, c \rangle \mid \forall g \in \Pi, l = |g| , c : \bar{g}

$ invocations(f) = \\{ g \mid \forall g \in \Pi : f \in definition(g) \\} $

$ X(f) = \\{ x \mid \forall x : x \in domain(f) \\} $

$ domain_i(f) = \\{ x_i \mid \forall \langle x_0, x_1, ..., x_{arity(f)} \rangle \in domain(f) \\} $

$ \\{ g \mid \forall g \in invocations(f) \exists x : x \not \in domain(f) \\}

- Explicit inclusion and exclusion set descriptions/builders.
- Implicit derivation from function analysis

**Function Context Analysis**: 

$\bar{G} = \\{f \mid \forall f \in \Pi : g \in \bar{f}\\}$

The set of functions/contexts in program $\Pi$ that contain function $g$
in their definition. Here, $\bar{f}$ represents the set of functions and
variables that define $f$.

**Input Value Derivation**:

$X = \\{x \mid \forall f \in \Pi, x \in \bar{f} : g(x) \in \bar{f}\\}$

The set of all possible values passed to $g$ within program $\Pi$ across
all function contexts $f$.

**Invalid Context Detection**:

$E = \\{f \mid \forall f \in \Pi, x \in \bar{f} : x \notin G\\}$

The set of contexts where a value is passed to $g$ that does not reside in its
valid input set $G$.

**Subject Construction Implication**: The subject for verifying "function $g$
handles all inputs safely" must encompass not just $g$ itself, but the derived
constraint sets $X$ and validation contexts $E$. This demonstrates how subjects
expand beyond simple function references to include **data flow relationships**
across the entire program.
-->

### Valid Array Indexing

$index(a, i)$ is the function that gets element $e_i$ at index $i$ from array $a$.

What is interesting about the $index$ function is that it has a dependent domain where the array $a$ defines the valid indices, but I guess this does not invalidate the $parameters(f, l) from the previous function invocation example since it is possible to express this as
$parameters(index) = \\{ \langle a, i \rangle \mid \forall a, i : 0 \lteq i \lteq |a| \\}$

<!--
Arrays can be statically or dynamically defined but I am only considering the dynamic case due to its increased complexity and that the methods are also valid for the static case.

There are two cases of index value generation, static and IO.
Static, the iniitalization, increment, and finial values are known.
IO, requires validation.
All of this means that the compiler and in some cases the runtime must associate a valid array bounds expression with the array.

This also seems very similar to pointer validity and memory initialization.
-->

## Subject Set

To be able to operate on Subjects the set of a possible subjects must be known.

- $S_C$: General function calls to be resolved to a subject, like:
  - `parseTree(l)` resolves to the parse tree root for the language entity l
  - `llvm(l)` resolves to the llvm product by compiling language entity l
  - `heapSize(x)` resolves to the heap size of the input, which may not be a number but rather a function
- $S_L \subset S_C$: Logical relations between subjects.
  - Example: $s_0 \land (s_1 \lor s_2)$ or a more functional style of $and(s_0, or(s_1, s_2))$
- $S_E \subset S_C$: General expressions. Since general expressions can be represented as functions they are categorized as such. Examples:
  - $1 + 2$ from the following resolution series:
    1. $heapSize(x)$
    2. $heapSize(y) + heapSize(z)$
    3. $1 + heapSize(z)$
    3. $1 + 2$
- $S_V$: General Values
  - true/false
  - $5$
  - values/types that the language supports
- $S_PP$: Predicate and Propositions
  - $text{first-class verification} \implies S_PP \subset $S_V$ meaning $S_PP$ may be a subset of $S_V$ if verificaion constructs are first-class language types.

$S = S_L \cup S_C \cup S_V \cup S_PP$

### Excluded

- $S_F$: Open General functions cannot be a subject since they are cannot be resolved or evaluated since the function parameters are undefined.

$S_F \not \subset S$

## Conclusion

up next

licence

hashtags
