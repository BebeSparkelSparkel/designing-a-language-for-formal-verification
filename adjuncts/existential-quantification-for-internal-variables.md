# Using Existential Quantification for Internal Variables

One of the most elegant features of mathematical logic is how it handles internal variables - those temporary objects we need while building larger mathematical structures.
Understanding how to properly use existential quantification for these variables is useful when writing precise mathematical definitions.

## The Problem of Internal Variables

Consider a simple example: how do we formally define function composition?
Intuitively, when we compose two functions $f$ and $g$, we need some intermediate set where the output of $f$ becomes the input of $g$.
But how do we capture this in formal logic?

Let's start with a basic definition of a total function:

$$
TotalFunction(f,A,B) \leftrightarrow \forall x \in A \exists y \in B : f(x) = y
$$

Now, for composition, we need three sets:

- the domain of $f$
- some intermediate set
- the codomain of $g$

The intermediate set must serve as both the codomain of $f$ and the domain of $g$.

## The Power of Existential Quantification

Here's where existential quantification shines.
Instead of trying to explicitly construct the intermediate set,
we can assert its existence:

$$
TotalComposition(f,g,A,B) \leftrightarrow \exists C : TotalFunction(f,A,C) \wedge TotalFunction(g,C,B)
$$

Meaning "a composition is total is the same as there exists a middle set C where f is total from A to C and g is total from C to B."

This definition elegantly captures several key ideas:

- There must be some set $C$ that works as our intermediate set
- $C$ is bound within the scope of the composition
- We don't need to specify exactly what $C$ is

## Why This Works

Existential quantification is perfect for internal variables because it:

- Binds the variable to a specific scope
- Asserts existence without over specifying
- Maintains mathematical rigor
- Preserves flexibility in implementation

Consider the alternative: trying to explicitly define the intermediate set as $\{f(x) | x \in A\}$.
This approach leads to a more complicated and restrictive definition:

$$
TotalComposition(f,g,A,B) \leftrightarrow (TotalFunction(f,A,\{f(x) | x \in A\}) \wedge TotalFunction(g,\{f(x) | x \in A\},B))
$$

While this works, it's unnecessarily restrictive.
We're forcing $C$ to be exactly the range of $f$,
when any superset of the range would work just as well.
Our existential quantification approach allows $C$ to be any set that makes the composition work,
leading to a more general and flexible definition.

For mathematicians,
consider f mapping to positive numbers and g defined over all reals.
With explicit construction, C must be exactly f's positive outputs,
but g might be well-defined on all reals (like g(x) = x + 1).
The existential approach naturally allows C to be the real numbers.

For programmers, imagine f returning integers 0-100 (percentages) and g computing averages.
Instead of forcing C to be exactly {0,1,2,...,100},
the existential approach allows C to be float or double,
matching how we'd actually implement these functions and avoiding unnecessary type conversions.

In both cases, allowing C to be a superset matches how we naturally work with functions, avoids artificial restrictions, and leads to cleaner implementations while preserving the essential meaning.

## Conclusion

Existential quantification solves the problem of internal variables by asserting their existence without constraining their exact form.
This is simpler and more general than explicitly constructing them.
As we've seen with function composition,
letting $\exists$ do the work often leads to cleaner definitions than trying to specify exactly what our internal variables should be.

Have you found other examples where existential quantification simplifies definitions? Share your insights!

#MathematicalLogic #ProgrammingLanguages #TypeTheory #FormalMethods #CompSci
