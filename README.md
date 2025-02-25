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

