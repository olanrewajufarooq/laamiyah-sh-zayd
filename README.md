# XeLaTeX Book Template Repo

This repository is now a LaTeX-first template built around a single style file:
[bookish.sty](./bookish.sty).

The intended workflow is:

1. Pick package options in `\usepackage[...]`.
2. Set book metadata with `\booksetup{...}`.
3. Write the rest of the document in normal LaTeX.
4. Compile with `xelatex`.

## Quick Start

The example entrypoint is [main.tex](./main.tex):

```latex
\documentclass[12pt,openany]{book}
\usepackage[
  theme=purple,
  frontpage=flower,
  backmatter=true,
  paper=6x9,
  chapternumbering=roman,
  coverstyle=auto,
  runningheader=book,
  toc=true
]{bookish}

  \booksetup{
  title={My Book},
  subtitle={A reusable XeLaTeX template},
  subtitleposition={below},
  author={Author Name},
  imprint={My Press},
  year={2026},
  backtext={Short back cover copy goes here.}
}
```

Then in the document body:

```latex
\frontmatter
\bookmaketitlepage
\booktableofcontents

\mainmatter
\chapter{Opening Chapter}
Text goes here.

\backmatter
\bookmakebackmatter
```

## Package Options

`bookish.sty` currently supports:

- `theme=purple|black|sepia|ocean|forest`
- `paper=6x9|a5|letter`
- `frontpage=hexagon|star|flower|circle`
- `backmatter=true|false`
- `chapternumbering=roman|roman-lower|arabic`
- `coverstyle=auto|classic|band|frame`
- `runningheader=book|minimal|none`
- `toc=true|false`

## Metadata API

Use `\booksetup{...}` with:

- `title`
- `subtitle`
- `subtitleposition`
- `author`
- `authoraddress`
- `imprint`
- `publishstatus`
- `year`
- `backtext`

## Helper Commands

- `\bookmaketitlepage`
- `\booktableofcontents`
- `\bookmakebackmatter`
- `\bookfrontmattersection{...}`
- `\bookbackmattersection{...}`
- `\bookepigraph{quote}{attribution}`
- `\arabictext{...}`

The package also provides a `bookcallout` environment.

## Project Structure

- [bookish.sty](./bookish.sty)
  Main XeLaTeX style package.
- [main.tex](./main.tex)
  Example book entrypoint.
- [content](./content)
  Example chapter files.
- [frontmatter](./frontmatter)
  Example back/front matter files.
- [assets/fonts](./assets/fonts)
  Bundled fonts used by the package.
- [latex templates](./latex%20templates)
  Reference material kept from earlier exploration.

## Build

### Windows

```powershell
build.bat
```

### macOS / Linux

```bash
./build.sh
```

Both scripts compile `main.tex` with XeLaTeX and write the PDF to `build/`.
