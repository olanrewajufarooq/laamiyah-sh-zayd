# XeLaTeX Book Template Repo

This repository is a XeLaTeX-first book template centered on [bookish.sty](./bookish.sty).
It provides:

- theme-based colors via [bookish-colors.sty](./bookish-colors.sty)
- swappable frontmatter/backmatter styles via [bookish-frontpage.sty](./bookish-frontpage.sty)
- a single metadata API through `\booksetup{...}`

## Quick Start

The example entrypoint is [main.tex](./main.tex):

```latex
\documentclass[11pt,fleqn,oneside]{book}
\usepackage[
  theme=default,
  paper=a5,
  frontpage=star,
  backmatter=true,
  chapternumbering=roman,
  coverstyle=auto,
  runningheader=none,
  toc=true
]{bookish}

\booksetup{
  title={Explanation of Laamiyyah},
  subtitle={of Shaykhul-Islam Ibn Taymiyyah},
  subtitleposition={below},
  author={Zayd ibn Hadi Al-Madkhali},
  authoraddress={Shaykh Al-Allamah},
  translator={Abu Al-Abbas Moosaa Richardson},
  imprint={Salafi Press},
  publisherlogo={assets/images/publisher-white.png},
  publishstatus={review},
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

`bookish.sty` supports:

- `theme=default|purple|black|sepia|ocean|forest`
- `paper=6x9|a5|a4|letter`
- `frontpage=star|flower|circle`
- `backmatter=true|false`
- `chapternumbering=roman|roman-lower|arabic`
- `coverstyle=auto|classic|band|frame`
- `runningheader=book|minimal|none`
- `toc=true|false`

## Metadata API

Use `\booksetup{...}` with:

- `title`
- `subtitle`
- `subtitleposition=above|below`
- `author`
- `authoraddress`
- `translator`
- `imprint`
- `publisherlogo`
- `publishstatus=demo|review|published`
- `year`
- `backtext`

Notes:

- `subtitle`, `authoraddress`, `translator`, `publisherlogo`, and `backtext` are optional.
- `publishstatus=published` hides the front-cover status tag.
- `year` is retained as metadata, but the current frontmatter system does not print it on the front cover.

## Frontmatter Styles

- `star`
  Right-aligned title block with a left footer publisher block.
- `flower`
  Floral central motif with right-aligned title and author stacks.
- `circle`
  Circular band composition with right-aligned title and author stacks.

When `backmatter=true`, `\bookmakebackmatter` uses the back cover style associated with the selected frontpage style.

With `theme=default`, the package currently maps:

- `star` -> `black`
- `flower` -> `purple`
- `circle` -> `sepia`

## Helper Commands

- `\bookmaketitlepage`
- `\booktableofcontents`
- `\bookmakebackmatter`
- `\bookfrontmattersection{...}`
- `\bookbackmattersection{...}`
- `\bookepigraph{quote}{attribution}`
- `\arabictext{...}`

The package also provides a `bookcallout` environment.

## Fonts

The package currently loads local fonts from [assets/fonts](./assets/fonts):

- `NotoSerif`
- `NeueHaasText`
- `Amiri`

XeLaTeX is required because the package depends on `fontspec` and local font loading.

## Project Structure

- [bookish.sty](./bookish.sty): main package and document-level options
- [bookish-colors.sty](./bookish-colors.sty): theme palette definitions
- [bookish-frontpage.sty](./bookish-frontpage.sty): frontmatter and backmatter renderers
- [main.tex](./main.tex): example entrypoint
- [content](./content): example chapter files
- [frontmatter](./frontmatter): example front/backmatter content
- [assets/fonts](./assets/fonts): bundled fonts
- [assets/images](./assets/images): image assets such as publisher logos
- [latex templates](./latex%20templates): reference material from the source template exploration

## Build

### Windows

```powershell
build.bat
```

### macOS / Linux

```bash
./build.sh
```

Both scripts:

- compile `main.tex` with XeLaTeX
- write the PDF to `build/main.pdf`
- clean common LaTeX byproducts from the repo root and `build/`
- prepend the repo root to `TEXINPUTS` so subdirectory TeX files can still resolve local `.sty` files
