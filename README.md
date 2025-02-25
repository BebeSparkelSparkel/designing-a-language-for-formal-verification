# designing-a-language-for-formal-verification

Series of articles that explain the aspects of designing a programming language
that includes formal verification.

## File Naming Scheme for Series Articles

Articles in the `series/` directory follow this naming convention:
`[0-9]{2}[0-9]*-[a-z-]*.md`

### Breakdown

- `[0-9]{2}`: Exactly two digits (e.g., `01`, `02`, `99`) that start the
  articles sequence number, ensuring a consistent base for sorting.
- `[0-9]*`: Zero or more additional digits (e.g., nothing, `5`, `55`) that
  extend the sequence number for insertions, providing flexibility.
- `-`: A dash separates the number from the title slug.
- `[a-z-]*`: An optional slug with lowercase letters and hyphens (e.g.,
  `intro`, `key-concepts`) for readability.
- `.md`: Standard Markdown extension.

### Examples

- `01-intro.md`
- `02-key-concepts.md`
- `03-main-argument.md`

### Purpose

This scheme ensures articles sort lexically in the correct order
(e.g., `01 < 02 < 03`) while allowing new articles to be inserted or appended
without renaming existing files.

### Adding or Appending the Next Article

For the next article in the series, increment the two-digit base number by 1
and use no additional digits.

Start with `01` and proceed sequentially (`02`, `03`, etc.) for the main
sequence.

For example:

- After `01-intro.md`, add `02-key-concepts.md`.
- After `02-key-concepts.md`, add `03-main-argument.md`.

### Inserting New Articles

To insert an article between two existing ones:

- Add a single digit `5` to the number of the earlier article.
  - Between `02-key-concepts.md` and `03-main-argument.md`, add
    `025-new-insertion.md`.
- If an insertion already exists and theres room between it and the next
  number, use the halfway digit (rounded down if needed):
  - Between `025-new-insertion.md` and `03-main-argument.md`, add
    `027-extra-point.md` (halfway between `5` and `10` is `7.5`, rounded to `7`).
- Resulting order: `01-intro.md`, `02-key-concepts.md`, `025-new-insertion.md`,
  `027-extra-point.md`, `03-main-argument.md`.
- Numbers can grow as needed (e.g., `0255`, `0257`) for further insertions.

### Notes

**Capacity**: The two-digit base (`01` to `99`) allows up to 99 articles in the
main sequence, with unlimited insertions possible by adding digits (e.g.,
`015`, `0155`).

**Consistency**: Start with two-digit numbers (`01`, `02`) for the main series;
additional digits are for insertions only.

**Adjunct Articles**: Related but non-series articles live in a separate
`adjunct/` directory and dont follow this scheme.

This approach keeps the series organized, scalable, and easy to maintain!

## Rendering Articles for Publication on X

To render GitHub-flavored Markdown (GFM) articles from this repository for
publication on X, use the following command pipeline.
This pipeline handles all contingencies, including converting GFM to HTML,
escaping special characters (like curly braces), and ensuring proper formatting
(e.g., removing problematic line breaks after HTML elements).

### Explanation

**Input**: Assumes your article is in GFM format (e.g., `article.md`).

**Pandoc**: Converts GFM to HTML with ASCII escapes for compatibility with X's
post editor.

**Sed**: Fixes incompatibilities with curly braces `{}` by removing unnecessary
double escapes (common in GFM math blocks).

**Tr**: Removes line breaks directly after HTML elements to prevent formatting
issues (e.g., no space between text and math spans).

**Output**: Pipes the final HTML to your clipboard for easy pasting into X's
Post or Article editor.

### Command

```sh
cat article.md | sed 's/\\\(\\[{}]\)/\1/g' | pandoc --ascii -f gfm -t html | tr '\n' ' ' | xclip -selection clipboard
```

`| xclip -selection clipboard` can be replaced with `> article.html` if you
want to create a file instead of copying to clipboard.

### Notes

Replace `article.md` with the path to your specific Markdown file.

Ensure `pandoc`, `sed`, `tr`, and `xclip` are installed on your system. On
Ubuntu/Debian, install with `sudo apt install pandoc xclip`. On macOS, use
`brew install pandoc xclip`.

After running the command, paste the HTML directly into X's Post or Article
editor and verify the formatting.

This pipeline is optimized for GFM articles in this repository and accounts for
the issues discussed in the thread (e.g., math blocks, line breaks).

## Formatting Guidelines

All articles in this repository must adhere to a unified GitHub-flavored
Markdown (GFM) format that is also fully compatible with Pandoc for rendering
to HTML for publication on X. These guidelines ensure consistent composition
for contributors, editors, and maintainers.

### Standard GFM Features

For the baseline syntax and features of GFM (e.g., headings, lists, code
blocks, links, emphasis), refer to the official GitHub documentation:

- [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)

### Document Structure and Formatting

#### Element Separation

Markdown elements require proper newline separation to prevent Pandoc from
concatenating them into a single line. Always include blank lines between
different elements:

```markdown
This is a paragraph.

- This is a list item
- Another list item

This is another paragraph.
```

Not:

```markdown
This is a paragraph.
- This is a list item
- Another list item
This is another paragraph.
```

#### Colons and Line Continuation

GitHub has specific formatting behavior where lines ending with a colon prevent
concatenation with the following line. This is particularly important for term
definitions:

```markdown
Definition term:
This is the definition that will appear on a new line in GitHub rendering.
```

### Math Expression Formatting

#### Inline and Block Math

Use single-dollar signs for inline math (`$...$`) and avoid display math blocks
when possible:

```markdown
Inline math example: $E = mc^2$
```

#### Multi-line Math Expressions

For multi-line math expressions, use standalone newline-separated inline math
for each line:

```markdown
$\int_a^b f(x) dx$

$= F(b) - F(a)$
```

Rather than trying to use backslash line breaks in a display math block:

```markdown
$$
\int_a^b f(x) dx \\
= F(b) - F(a)
$$
```

#### Curly Braces in Math

If your article includes math expressions using curly braces, use double
backslashes (`\\{` or `\\}`) to escape them:

```markdown
$T(n) = aT(n/b) + \\{f(n)\\}$
```

Note: The `sed` command in the rendering pipeline will remove the extra
backslashes when publishing to X.

### Character and Text Handling

#### ASCII Characters Only

Articles should only use ASCII characters. Avoid non-ASCII characters like
curly quotes, em-dashes, or accented letters. The `--ascii` option in the
rendering pipeline will convert these, but it's better to avoid them from the
start.

#### Line Width

For better readability in source files, we recommend limiting line widths to 80
characters. This improves the readability of raw markdown files and makes git
diffs more meaningful by showing changes at a word level.

The Unix `fold -s` command can be helpful for this purpose, as it wraps lines
at word boundaries. However, `fold -s` often leaves trailing whitespace at the
end of wrapped lines. To address this, you can pipe the output through `sed` to
remove trailing whitespace:

```sh
fold -s -w 80 input.md | sed 's/[[:space:]]*$//' > output.md
```

Be cautious when using automated tools like `fold` with code blocks or other
formatted content, as they may disrupt the intended formatting. Manual line
wrapping is preferred in these cases.

### Publishing and Verification

#### Testing Your Markdown

- Test your Markdown in a GFM viewer (e.g., GitHub's preview) before submission
- For a final check, use the rendering pipeline described in the "Rendering
  Articles for Publication on X" section

#### Rendering Pipeline Notes

The rendering pipeline handles certain format conversions (like double escapes
for curly braces and line breaks after HTML elements), but writing correctly
formatted source markdown makes maintenance easier.

Remember to follow these guidelines strictly to ensure articles render
correctly on both GitHub and X via Pandoc.

## License Information

All articles in this repository are licensed under the Creative Commons
Attribution-ShareAlike 4.0 International Public License (CC BY-SA 4.0). Each
article must include a license notice using the following format:

```markdown
[Article content here...]

---

**License**: This article is licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)
(CC BY-SA 4.0). You are free to share and adapt this material, provided you
give appropriate credit, provide a link to the license, and indicate if changes
were made. If you remix, transform, or build upon the material, you must
distribute your contributions under the same license as the original.

#X #Hashtags #Go #Below #License
EOF
```

`EOF`: End of File and should not actually be included in the document.

### X Articles Compatibility

Articles will be published to X Articles using the rendering pipeline, follow this content
structure for compatibility:

1. **Article Content**: The main body of your article
2. **Call to Action**: Include an engaging question or prompt before the
    license notice to encourage reader interaction (e.g., "What do you think
    about this approach to formal verification? Share your thoughts below!")
3. **License Notice**: The full CC BY-SA 4.0 license text as specified in the
    License Information section
4. **Hashtags**: Place below the license notice
  - Separate multiple hashtags with spaces `#Tag1 #Tag2 #Tag3`
  - Include both specific article topics and broader categories
    `#FormalVerification #ProgrammingLanguage`
