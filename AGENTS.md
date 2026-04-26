# BeamerThemeEsplanade — Project Guidelines

## Code Style

- Use `\NewDocumentCommand` / `\NewDocumentEnvironment` (xparse / LaTeX kernel ≥ 2020) instead of `\def` or `\newcommand`.
- Use expl3 (`\ExplSyntaxOn` … `\ExplSyntaxOff`) for conditional logic and option parsing.
- Use `pgfkeys` or expl3 property lists for structured key-value options; avoid low-level `\DeclareOption` / `\ProcessOptions`.

## Architecture

- Prefer native Beamer mechanisms — `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont` — over patching internals with `\patchcmd` or redefining internal macros directly.
- **Never use `remember picture` or any technique that requires multiple compilations.** All element positioning must be achieved in a single pass using Beamer's template coordinate system and TikZ dimensions relative to `\paperwidth` / `\paperheight`.
- Logo graphics are defined as TikZ paths embedded in the `.sty` file (no external PDF dependencies).
- Faculty-specific color variants are mapped via `\str_case:nnF` in the expl3 option handler — add new faculties there, not ad-hoc elsewhere.

## Conventions

- All measurements must be relative: fractions of `\paperwidth` / `\paperheight`, or font-relative units (`em`, `ex`). Never use hardcoded `pt` or `cm` values that silently break at different base font sizes (10pt, 11pt, 12pt).
- Dead or commented-out code blocks must not accumulate — remove or open a TODO comment with a GitHub issue reference instead.

## Build and Test

```
latexmk -pdf <file>
```

- Test files live in `test/`. Run every affected test after changing any template, color, or font definition.
- Every change must produce a correct PDF in a **single compilation pass** — no multi-run hacks.
