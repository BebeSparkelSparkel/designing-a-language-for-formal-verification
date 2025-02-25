# The Origins and Nature of Logical Assignment

In formal logic and computer science,
two notational conventions express relationships between logical expressions:
logical assignment ($:=$) and logical equivalence ($\leftrightarrow$).
Understanding their relationship reveals how practical implementation needs
shaped mathematical notation.

## The Programming Era View

The explanation that emerged in the mid-20th century distinguishes these
operators based on their roles in computational systems:

- Logical assignment ($:=$) is described as a definitional operation that gives meaning to symbols
- Logical equivalence ($\leftrightarrow$) is characterized as a statement about truth values

Consider the expressions:

$A := B \wedge C$

$X \leftrightarrow Y \wedge Z$

This interpretation, which arose from programming language design,
suggests that the first expression defines what $A$ means,
while the second asserts that $X$ and $Y \wedge Z$ share the same truth value.

## Challenging the Programming Era Distinction

However, this distinction warrants closer examination.
Consider how these expressions operate in logical reasoning:

$A := B \wedge C$

$A \wedge D$

Through substitution, $A \wedge D$ becomes $(B \wedge C) \wedge D$.
Compare this to:

$X \leftrightarrow Y \wedge Z$

$X \wedge W$

Here, $X \leftrightarrow Y \wedge Z$ establishes that $X$ and $Y \wedge Z$
share truth values,
so $X \wedge W$ is equivalent to $(Y \wedge Z) \wedge W$.

While assignment represents an operational step (a state change) and
equivalence expresses a declarative relationship,
both constructs lead to the same truth values in subsequent logical reasoning.
The distinction lies not in their logical outcomes but in their mechanical interpretation.
Furthermore, both operators can introduce new symbols into a logical system.
While some argue that logical equivalence cannot define new terms,
this restriction appears arbitrary.
Consider the expression:

$\exists x (x \leftrightarrow p \wedge q)$

This validly introduces a new symbol $x$ through equivalence rather than assignment,
as seen in early formal logic [@frege1879; @russell1910].
Indeed, examining pre-1950s mathematical notation reveals that both definition
and equivalence were traditionally handled through $=$ and natural language
constructs like "let" and "define",
with no need for a distinct assignment operator [@cajori1928].

## Mathematical and Logical Foundations

Before computers, mathematics and logic used the equality symbol ($=$) along
with natural language constructs to establish relationships between terms.
Introduced by @recorde1557 in "The Whetstone of Witte",
the equality symbol served both definitional and equivalence purposes in
expressions like "let $x = 5$" or $f(x) = x^2$ [@euler1748].
This bidirectional usage persisted from early mathematicians like Leibniz
through to the early 20th century,
with no need for directional notation [@cajori1928].

In propositional logic, the biconditional ($\leftrightarrow$) emerged as a
specialized equality for truth values in a truth-functional sense [@frege1879; @russell1910].
While $=$ is a predicate asserting identity between terms,
$\leftrightarrow$ is a logical connective ensuring identical truth values between propositions.
When mathematicians write "let $P = Q$",
this definitional use of equality implies $P \leftrightarrow Q$ in the propositional context,
demonstrating the deep connection between these notations.

## The Emergence of Assignment Notation

The logical assignment operator originated in early computing efforts with
Rutishauser's Superplan (1949-1951),
which introduced the $:=$ notation [@rutishauser1951].
Fortran (1957) then popularized a different approach,
using $=$ for assignment while employing `.EQ.` for equality comparison [@ibm1956].
The International Algorithmic Language (ALGOL 58) initially used $=>$ for
assignment [@perlis1958],
but this was refined to $:=$ in ALGOL 60,
which standardized this notation and distinguished it clearly from equality
comparisons using $=$ [@naur1960].
This non-linear evolution reflects the early experimentation in notation as
programming languages developed.

## Implementation Influences

The adoption of directional assignment notation was likely driven by practical
compilation needs.
Early computers with limited memory and processing power benefited from clear,
unambiguous translation of high-level code to machine instructions [@ibm704manual1954].
Assignment operators provided this clarity by explicitly indicating the
direction of value storage,
mapping directly to hardware operations.
Circumstantial evidence for this influence appears in early compiler
developmentfor example,
@backus1978 emphasized the need for efficient compilation on the IBM 704 when
developing Fortran.

This choice of notation was not about computational limitations preventing
bidirectional relationships.
LISP (1958) demonstrated that more complex evaluation models,
such as symbolic computation, were possible on the same hardware,
such as the IBM 704 [@mccarthy1960; @lisp1958memo].
Rather, assignment notation offered a pragmatic balance between expressive
power and straightforward compilation paths.
The simplicity of translating assignment operations to machine code made them
an attractive choice for general-purpose programming languages.

## Modern Understanding

Contemporary programming paradigms, including functional and logic programming,
have demonstrated various ways to express these relationships [@hudak2007; @clocksin1981].
The persistence of assignment notation in many languages reflects its utility
in clarifying code intent and compilation paths,
not a fundamental logical necessity.

Formal methods and program verification systems now routinely treat assignment
and equivalence as notational variants expressing the same underlying logical relationships.
This understanding reveals that the historical distinction between assignment
and equivalence was primarily about implementation clarity rather than logical semantics.

## Implications for Language Design

Modern programming language design continues to benefit from this historical insight.
While some languages maintain explicit assignment notation for clarity and compilation simplicity,
others explore more declarative approaches that reveal the underlying logical relationships.

Consider how different languages handle the relationship between names and values.
Python maintains traditional assignment with $=$ for explicit state changes,
prioritizing imperative clarity [@vanrossum1991].
Haskell, by contrast, primarily uses immutable bindings (e.g., `let x = 5`),
yet introduces focused assignment-like notation where practically needed:
the `<-` operator in monadic contexts and function parameters as fixed bindings [@haskell2010].
These mechanisms preserve logical purity while addressing implementation requirements.

The success of these diverse approaches confirms that the choice between
assignment and equivalence notation reflects practical considerations rather
than logical constraints.
Language designers can select notation that serves their specific needs while
understanding the underlying logical equivalence of these relationships.
The evolution from early assignment operators to modern binding mechanisms
demonstrates how notation can adapt to changing paradigms while maintaining
clear paths to implementation.

## Conclusion

The development of logical assignment notation represents a pragmatic
adaptation of mathematical and logical relationships to the needs of computer implementation.
Rather than reflecting a fundamental logical distinction,
assignment operators provided a clear path from high-level code to machine instructions.
This history offers valuable insights into how practical constraints shape the
notation and expression of logical concepts in computing systems.

Understanding this relationship between notation and implementation helps
inform modern language design choices while clarifying the true nature of
logical relationships in computing.
Future developments in programming languages can build on this knowledge,
choosing notation that best serves their specific needs while remaining
grounded in the underlying logical equivalence of these relationships.

---
references:
- id: backus1978
  type: article-journal
  author:
  - family: Backus
    given: John
  issued:
    date-parts:
    - - 1978
      - 8
  title: "The history of FORTRAN I, II, and III"
  container-title: "ACM SIGPLAN Notices"
  volume: "13"
  issue: "8"
  page: "165-180"
  DOI: "10.1145/800025.808384"
  publisher: "ACM"

- id: mccarthy1960
  type: article-journal
  author:
  - family: McCarthy
    given: John
  issued:
    date-parts:
    - - 1960
      - 4
  title: "Recursive functions of symbolic expressions and their computation by machine, Part I"
  container-title: "Communications of the ACM"
  volume: "3"
  issue: "4"
  page: "184-195"
  DOI: "10.1145/321033.321034"
  publisher: "ACM"

- id: rutishauser1951
  type: article-journal
  author:
  - family: Rutishauser
    given: Heinz
  issued:
    date-parts:
    - - 1951
  title: "Über die Programmierung von Rechenmaschinen"
  container-title: "Zeitschrift für angewandte Mathematik und Physik"
  volume: "2"
  page: "1-10"

- id: naur1963
  type: report
  editor:
  - family: Naur
    given: Peter
  issued:
    date-parts:
    - - 1963
  title: "Revised report on the algorithmic language ALGOL 60"
  publisher: "International Federation for Information Processing"

- id: leibniz1679
  type: article-journal
  author:
  - family: Leibniz
    given: Gottfried Wilhelm
  issued:
    date-parts:
    - - 1679
  title: "Nova methodus pro maximis et minimis"
  container-title: "Acta Eruditorum"

- id: ibm704manual1954
  type: book
  issued:
    date-parts:
    - - 1954
  title: "IBM 704 Electronic Data-Processing Machine: Manual of Operation"
  publisher: "International Business Machines Corporation"

- id: hudak2007
  type: paper-conference
  author:
  - family: Hudak
    given: Paul
  - family: Peyton Jones
    given: Simon
  - family: Wadler
    given: Philip
  issued:
    date-parts:
    - - 2007
  title: "A history of Haskell: Being lazy with class"
  container-title: "Proceedings of the Third ACM SIGPLAN History of Programming Languages Conference"
  page: "1-55"

- id: clocksin1981
  type: book
  author:
  - family: Clocksin
    given: William F.
  - family: Mellish
    given: Christopher S.
  issued:
    date-parts:
    - - 1981
  title: "Programming in Prolog"
  publisher: "Springer-Verlag"

- id: vanrossum1991
  type: software
  author:
  - family: Van Rossum
    given: Guido
  issued:
    date-parts:
    - - 1991
  title: "Python"
  version: "0.9.0"

- id: russell1910
  type: book
  author:
  - family: Russell
    given: Bertrand
  - family: Whitehead
    given: Alfred North
  issued:
    date-parts:
    - - 1910
  title: "Principia Mathematica"
  publisher: "Cambridge University Press"
  volume: "1-3"
  note: "Published 1910-1913"

- id: frege1879
  type: book
  author:
  - family: Frege
    given: Gottlob
  issued:
    date-parts:
    - - 1879
  title: "Begriffsschrift, eine der arithmetischen nachgebildete Formelsprache des reinen Denkens"
  publisher: "Louis Nebert"

- id: recorde1557
  type: book
  author:
  - family: Recorde
    given: Robert
  issued:
    date-parts:
    - - 1557
  title: "The Whetstone of Witte"
  publisher: "John Kingston"

- id: euler1748
  type: book
  author:
  - family: Euler
    given: Leonhard
  issued:
    date-parts:
    - - 1748
  title: "Introductio in analysin infinitorum"
  publisher: "Marcum-Michaelem Bousquet"

- id: perlis1958
  type: article-journal
  author:
  - family: Perlis
    given: Alan J.
  - family: Samelson
    given: Klaus
  issued:
    date-parts:
    - - 1958
      - 12
  title: "Preliminary reportInternational Algebraic Language"
  container-title: "Communications of the ACM"
  volume: "1"
  issue: "12"
  page: "8-22"
  DOI: "10.1145/377937.377948"
  publisher: "ACM"

- id: naur1960
  type: report
  editor:
  - family: Naur
    given: Peter
  issued:
    date-parts:
    - - 1960
  title: "Report on the algorithmic language ALGOL 60"
  publisher: "International Federation for Information Processing"

- id: ibm1956
  type: book
  issued:
    date-parts:
    - - 1956
  title: "Programmer's Reference Manual: Fortran Automatic Coding System for the IBM 704"
  publisher: "International Business Machines Corporation"

- id: lisp1958memo
  type: report
  author:
  - family: McCarthy
    given: John
  issued:
    date-parts:
    - - 1958
      - 8
      - 25
  title: "LISP - Programmer's Manual (Memo)"
  publisher: "MIT Artificial Intelligence Laboratory"

- id: haskell2010
  type: report
  editor:
  - family: Marlow
    given: Simon
  issued:
    date-parts:
    - - 2010
  title: "Haskell 2010 Language Report"
  publisher: "Haskell.org"

- id: cajori1928
  type: book
  author:
  - family: Cajori
    given: Florian
  issued:
    date-parts:
    - - 1928
  title: "A History of Mathematical Notations"
  publisher: "Open Court Publishing Company"
  volume: "1-2"
  note: "Published 1928-1929"
...
