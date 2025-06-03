# Designing a Language for Formal Verification: Is it a Function?

This article sets the stage for performing program verification by answering the question
"How do we prove that a given identifier or code structure actually represents a function?"
This seemingly simple question serves as our entry point into practical verification,
demonstrating the fundamental techniques and patterns that will support more complex verification challenges in subsequent articles.

We'll explore this question deliberately through a simplified lens,
examining the basic verification problem of function identification across representation levels.
By choosing this straightforward verification target,
we can establish clear design methods and patterns without getting lost in complexity.

This approach builds on the theoretical foundation established in
[Core Elements](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/01-core-elements.md) and
[Propositions from Subjects and Predicates](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/02-propositions-from-subjects-and-predicates.md),
providing our first concrete application of the proposition-based verification framework.

## Parse Tree

Parse trees provide a hierarchical representation of the source code structure,
allowing us to verify that the parsed elements actually form a coherent function declaration.
This level bridges the gap between raw syntax and semantic meaning.

The verification principle here is structural integrity:
does the tree structure contain the required components of a function declaration,
properly organized and typed?
We use JSON representations of Abstract Syntax Trees (ASTs) for language-agnostic analysis,
with JSON Schema to define the structural requirements for function verification.

### C Example

The C function declaration creates a structured tree with distinct nodes for each component.
Our verification focuses on ensuring the root node is tagged as a function declaration and contains a non-empty parameter list.
Additional examples for Python and Haskell can be found in [Appendix A](appendix-a-additional-parse-tree-examples).

```c
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
```

This AST representation makes the function structure explicit through node types and hierarchical relationships.
Each component - return type, name, parameters, and body - becomes a distinct, verifiable element.

**JSON AST**:
```json
{
  "type": "FunctionDeclaration",
  "returnType": {"type": "TypeSpecifier", "name": "int"},
  "name": {"type": "Identifier", "value": "factorial"},
  "parameters": [
    {
      "type": "Parameter",
      "paramType": {"type": "TypeSpecifier", "name": "int"},
      "name": {"type": "Identifier", "value": "n"}
    }
  ],
  "body": {...}
}
```

The JSON Schema captures the essential verification requirements:
the node must be typed as a function declaration and must contain at least one parameter.
This minimal schema focuses on the core question of function identity rather than complete structural validation.

**JSON Schema**:
```json
{
  "type": "object",
  "properties": {
    "type": {"const": "FunctionDeclaration"},
    "parameters": {
      "type": "array",
      "minItems": 1
    }
  },
  "required": ["type", "parameters"]
}
```

If the JSON AST passes the JSON Schema verification,
then the AST represents a function.

## Source Text

At the source text level, we utilize tokenizers and grammars to verify that text represents a function definition.
This approach is primarily demonstrational - in practice, function identification would typically be performed on parse trees rather than raw text.
However, examining source text verification serves important pedagogical purposes and illustrates techniques applicable to real verification scenarios.

The concepts presented here apply directly to practical verification tasks such as enforcing coding
style guidelines (function naming conventions, parameter formatting),
implementing domain-specific linting rules,
validating documentation comment patterns,
or performing security audits on code patterns before compilation.
Additionally, these techniques can be utilized when working with incomplete or malformed code that may not parse correctly into standard ASTs.

The key verification principle at this level is syntactic recognition:
does the text structure match the expected patterns for function declarations?
We demonstrate this with two complementary approaches:

- traditional lexer/parser combinations (Flex/Bison)
- integrated parsing with verification (Parsec, a Haskell parser combinator library).

### C Example

C functions follow a clear syntactic pattern:
a return type,
function name,
parameter list in parentheses,
and either a body or semicolon terminator.
Our verification focuses on the presence of parameters,
which distinguishes functions from simple subroutines or variable declarations.
Additional examples for Python and Haskell can be found in [Appendix B](appendix-b-additional-source-text-examples).

```c
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
```

#### Flex/Bison

The Flex/Bison approach separates lexical analysis from syntactic parsing.
The lexer identifies tokens, while the parser recognizes the grammatical structure of function declarations.
This separation makes it easy to handle complex tokenization while maintaining clear grammar rules.

```l
%%
"int"          { return TYPE; /* simplified for example */}
"void"         { return VOID; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[ \t\n]+       { /* ignore whitespace */ }
.              { return yytext[0]; }
%%
```

```y
%%
is_function: TYPE IDENTIFIER '(' parameter_list ')' ('{' | ';')

parameter_list: parameter_list ',' parameter | parameter;

parameter: TYPE IDENTIFIER;
%%
```

#### Parsec

Parsec integrates parsing with verification logic, allowing us to embed function recognition directly into the parsing process.
This approach is particularly powerful for domain-specific languages where verification requirements are built into the language design.

```hs
isFunction :: Parser ()
isFunction = do
    ctype
    identifier
    char '('
    parameterList
    char ')'
    spaces
    oneOf "{;"
    return ()

ctype = string "int" -- simplified for example

identifier = do
    letter <|> char '_'
    many $ alphaNum <|> char '_'

parameterList = sepBy1 parameter do
  char ','
  spaces

parameter = do
  ctype
  spaces
  identifier
```

## Intermediate Representation

At the intermediate representation level,
we find that most IRs maintain enough high-level structure that the verification methods from source text and parse tree analysis remain applicable.
Whether examining:

- LLVM IR
- A-Normal Form (ANF)
- Continuation-Passing Style (CPS)
- or other intermediate forms

function declarations and boundaries typically remain explicit.
LLVM example in [Appendix C](Appendix-C-LLVM-Factorial).

This consistency occurs because intermediate representations are designed to facilitate analysis and transformation while preserving essential program structure.
Functions remain first-class entities with clear boundaries,
parameter lists, and identifiable entry points.
The syntax may change from `int factorial(int n)` in C to `define i32 @factorial(i32 %n)` in LLVM IR but the fundamental structural elements persist.

The verification principle therefore remains unchanged: identify function declaration patterns and verify the presence of parameters or type signatures.
The same tokenization and parsing approaches work, adapted for the specific IR syntax.
This consistency is particularly important for verification systems that must track function properties across compilation stages.

This principle extends to binary representations of IRs as well.
Even when the IR is serialized to binary formats (like LLVM bitcode),
the essential function structure is preserved.
Binary analysis tools can extract the same structural information that textual analysis provides,
maintaining verification continuity across representation formats.

## Machine Code

At the machine code level, we encounter a fundamental shift that requires us to reconsider what we mean by "function verification."
Machine code nor assembly supports explicit function declarations.
There are no function keywords, type signatures, or parameter lists.
Instead, we find labels, instruction sequences, and calling convention patterns.

This absence of explicit function structure means we cannot apply the syntactic and structural verification methods used at higher levels.
While one might argue that machine code does contain 'functions' in the form of labeled instruction sequences with calling conventions,
these are fundamentally different entities than the functions we verify at higher levels.
They represent implementation details and behavioral patterns rather than declared program structures.
A machine code function is simply a sequence of instructions that happens to follow certain behavioral patterns:
proper stack frame management, consistent parameter handling, and appropriate return mechanisms.

The verification question therefore changes from "Does this declare a function?" to "Does this implement function-like behavior?"
This shift represents a move from structural verification to translated behavioral verification.
However, this behavioral verification is fundamentally different from the identity verification that is being addressed in this article.
For comprehensive verification across representation levels, including machine code, see
[Cross Representation Propositions](https://github.com/BebeSparkelSparkel/designing-a-language-for-formal-verification/blob/master/series/09-cross-representation-propositions.md),
which addresses how to establish relationships between high-level function declarations and their low-level implementations.

## Conclusion

This exploration of function verification across representation levels reveals both the consistency and the limits of structural verification approaches.
From source text through intermediate representations, we can apply similar verification strategies based on syntactic recognition and structural analysis.
The methods adapt to different languages and representations, but the core principle remains: identify function declaration patterns and verify the presence of parameters or type signatures.

The machine code boundary is a transition point where verification shifts from structural to behavioral concerns.
This transition highlights the importance of our proposition-based verification framework,
which can accommodate both structural verification (at high levels) and behavioral verification (at low levels) within a unified system.

What verification challenges have you encountered when working across different representation levels?
Share your experiences and questions in the comments below!

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

 #FormalVerification #ProgrammingLanguages #ProofAssistants #LanguageDesign #CompilerVerification

# Appendix A: Additional Parse Tree Examples

## A.1 Python

```py
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)
```

**JSON AST**:
```json
{
  "type": "FunctionDef",
  "name": {"type": "Name", "id": "factorial"},
  "args": {
    "type": "Arguments",
    "args": [{"type": "Arg", "arg": "n", "annotation": null}]
  },
  "body": {...}
}
```

**JSON Schema**:
```json
{
  "type": "object",
  "properties": {
    "type": {"const": "FunctionDef"},
    "args": {
      "properties": {
        "args": {
          "type": "array",
          "minItems": 1
        }
      }
    }
  },
  "required": ["type", "args"]
}
```

## A.2 Haskell

Haskell's mathematical approach to functions creates a more complex AST structure that must accommodate both type signatures and function equations.
This dual nature requires careful consideration in our verification approach.

```hs
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

The Haskell AST combines type information with pattern-matching equations,
creating a rich structure that explicitly represents the mathematical nature of functional programming.
Our verification focuses on the type signature,
which provides clear evidence of function-ness through its domain and codomain structure.

**JSON AST**:
```json
{
  "type": "Module",
  "decls": [
    {
      "type": "TypeSig",
      "name": "factorial",
      "signature": {
        "type": "ArrowType",
        "argType": { "type": "Type", "name": "Int" },
        "resultType": { "type": "Type", "name": "Int" }
      }
    },
    {
      "type": "FunBind",
      "name": "factorial",
      "matches": [
        {
          "type": "Match",
          "patterns": [
            { "type": "LitPat", "value": 0 }
          ],
          "rhs": {...}
        },
        {
          "type": "Match",
          "patterns": [
            { "type": "VarPat", "name": "n" }
          ],
          "rhs": {...}
        }
      ]
    }
  ]
}
```

The schema verification for Haskell leverages the type signature structure,
checking for the presence of `argType` and `resultType` that characterize mathematical functions.

**JSON Schema**:
```json
{
  "type": "object",
  "properties": {
    "type": {"const": "Module"},
    "decls": {
      "type": "array",
      "contains": {
        "type": "object",
        "properties": {
          "type": {"const": "TypeSig"},
          "signature": {
            "properties": {
              "type": {"const": "ArrowType"},
              "argType": {"type": "object"},
              "resultType": {"type": "object"}
            },
            "required": ["argType", "resultType"]
          }
        },
        "required": ["type", "signature"]
      }
    }
  },
  "required": ["type", "decls"]
}
```

# Appendix B: Additional Source Text Examples

## Python

```py
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)
```

### Flex/Bison

```l
%%
"def"          { return DEF; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[ \t]+         { /* ignore spaces and tabs */ }
.              { return yytext[0]; }
%%
```

```y
%%
is_function: DEF IDENTIFIER '(' parameter_list ')' ':' { /* valid function */ };

parameter_list: parameter_list ',' IDENTIFIER | IDENTIFIER;
%%
```

### Parsec

```hs
isFunction :: Parser ()
isFunction = do
    string "def"
    spaces
    identifier
    char '('
    pythonParameterList
    char ')'
    char ':'
    return ()

pythonParameterList = sepBy1 identifier (char ',')

identifier = do
    letter <|> char '_'
    many $ alphaNum <|> char '_'
```

## Haskell

Haskell presents a unique verification challenge with its mathematical function notation.
Functions can be declared through type signatures (`::`) or through pattern-matching equations.
This dual representation requires our verification to handle both forms.

```hs
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

### Flex/Bison

Haskell's grammar accommodates both type signatures and function equations.
The presence of either a type signature with domain/codomain or pattern-matching equations indicates a function declaration.

```l
%%
[a-z_][a-zA-Z0-9_']* { return IDENTIFIER; }
"::"           { return DOUBLE_COLON; }
"->"           { return ARROW; }
"="            { return EQUALS; }
[ \t\n]+       { /* ignore whitespace */ }
.              { return yytext[0]; }
%%
```

```y
%%
is_function
    : IDENTIFIER DOUBLE_COLON function_signature
    | IDENTIFIER pattern_list EQUALS expression
    ;

function_signature: type_signature ARROW type_signature;

type_signature: IDENTIFIER | IDENTIFIER ARROW type_signature;

pattern_list
    : identifier
    | pattern_list IDENTIFIER { free($2); }
    ;
%%
```

### Parsec

The Parsec approach for Haskell handles the complexity of type signatures and pattern matching through alternative parsing strategies.
This flexibility demonstrates how verification can adapt to different language paradigms.

```hs
isFunction :: Parser ()
isFunction = do
    identifier
    spaces
    functionSignature <|> functionParameters

functionSignature = do
    string "::"
    spaces
    sepBy1 type' do -- type specifiers too complex to define here
      spaces 
      string "->"
      spaces

functionParameters = many1 patterns -- patterns too complex to define here

identifier = do
    letter
    many (alphaNum <|> char '\'')
```

# Appendix C: LLVM Factorial

Syntax has explicit function declaration capabilities.

```llvm
define i32 @factorial(i32 %n) {
entry:
  %cmp = icmp sle i32 %n, 1
  br i1 %cmp, label %return_one, label %recurse

return_one:
  ret i32 1

recurse:
  %n_minus_one = sub i32 %n, 1
  %call = call i32 @factorial(i32 %n_minus_one)
  %result = mul i32 %n, %call
  ret i32 %result
}
```
