# Laamiyah Template

A Quarto + Pandoc + Typst template for Islamic books and bilingual editions.

The target user experience is simple:

1. Select a theme.
2. Write in Markdown.
3. Build the PDF.

The writer should not need to think about layout rules, front page tuning, color pairing, table of contents styling, or special formatting internals while drafting.

## Product Goal

This template should become a **theme-first, writing-first** system.

That means:

- A user chooses one theme once.
- The theme automatically controls the front page, text colors, headings, table of contents, Qur'an styling, Hadith styling, and general page mood.
- The user writes only content and a small amount of clean metadata.
- The template handles the visual system consistently.

## Core Problems To Fix

The current template already has strong building blocks, but usability is still too tied to implementation details.

Main issues:

- Front page layout is manually tuned per image instead of being designed as a reusable theme system.
- Cover text treatment, body text, headings, and TOC styling are related visually, but they are not yet presented as one coherent theme contract.
- Qur'an and Hadith blocks exist, but their design language is still too close to raw formatting instead of polished, recognizable components.
- Markdown authoring still depends on remembering structural classes and conventions.
- Documentation is setup-heavy and does not yet guide the user into a low-friction writing workflow.

## Clean Direction

The template should be reorganized around two layers only:

### 1. Theme Layer

This is the design system.

It defines:

- front page image
- cover text placement
- text colors
- heading style
- TOC style
- Qur'an style
- Hadith style
- page accents
- optional decorative rules or ornaments

The user should interact with this layer only by selecting a theme name.

### 2. Content Layer

This is what the writer edits.

It should contain only:

- book metadata
- chapter files
- optional translator notes
- Qur'an and Hadith content in very simple Markdown patterns

The writer should not edit Typst layout logic for normal usage.

## Proposed End-State Workflow

The template should feel like this:

1. Duplicate the template.
2. Open one config file.
3. Set:
   - title
   - subtitle
   - author
   - translator
   - theme
4. Write in `src/`.
5. Run `build`.

Nothing else should be required for normal use.

## Implementation Plan

### Phase 1. Define a Real Theme API

Replace image-driven styling with theme-driven styling.

Deliverables:

- Introduce a single metadata field such as `theme: blue-hexagon`.
- Map each theme to:
  - front page image
  - front page text layout
  - body palette
  - heading palette
  - TOC palette
  - Qur'an palette
  - Hadith palette
- Keep image filenames internal to the theme system.

Result:

The user picks a theme name, not an image file plus layout assumptions.

### Phase 2. Redesign the Front Page System

The front page should be treated as a designed composition, not only text placed on top of an image.

Deliverables:

- Group front page designs into a few reusable layout families:
  - centered classic
  - framed vertical
  - lower-third editorial
  - stacked manuscript
- Assign each theme one layout family.
- Add optional overlay treatment where needed:
  - soft tint
  - gradient veil
  - text panel
  - ornamental frame
- Tune title, subtitle, and metadata spacing by layout family rather than one-off per image.

Result:

Each cover image gets a front page treatment that feels intentional and readable.

### Phase 3. Make Typography and Color Coherent

The current template needs one visual language per theme instead of isolated color values.

Deliverables:

- Define semantic tokens:
  - `title`
  - `subtitle`
  - `body`
  - `muted`
  - `accent`
  - `quran`
  - `hadith`
  - `toc-title`
  - `toc-entry`
  - `toc-page`
- Standardize font roles:
  - body serif
  - Arabic font
  - optional display style for cover/title accents
- Ensure heading hierarchy, body text, footnotes, and notes all feel related.

Result:

Each theme feels complete rather than partially styled.

### Phase 4. Redesign the Table of Contents

The TOC should visually belong to the selected theme.

Deliverables:

- Give the TOC its own theme-aware title style.
- Improve entry spacing and indentation.
- Distinguish chapter-level and section-level entries more clearly.
- Style page numbers as part of the design rather than plain output.
- Optionally add a subtle divider or ornament for premium-looking themes.

Result:

The TOC becomes part of the book design instead of a utility page.

### Phase 5. Turn Qur'an and Hadith Into First-Class Components

These should look special immediately, without requiring users to style them manually.

Deliverables:

- Create distinct visual treatment for:
  - Qur'an passages
  - Hadith passages
  - Arabic-only passages
- Differentiate them through spacing, color, weight, and optional borders or ornaments.
- Support theme-aware accents while preserving reverence and readability.
- Ensure the Arabic and translation always read as one intentional unit.

Result:

Sacred citations feel clearly elevated from ordinary prose.

### Phase 6. Simplify Markdown Authoring

The user should not need to memorize internal class structures unless they want advanced control.

Deliverables:

- Support a minimal writing syntax for common content:
  - chapter headings
  - translator notes
  - Qur'an blocks
  - Hadith blocks
  - Arabic-only blocks
- Provide short canonical patterns in the README.
- Keep current Div-based syntax as an advanced fallback if needed.
- If possible, add friendlier aliases or wrappers via filters.

Result:

Writers can stay in Markdown and focus on text.

### Phase 7. Separate User Files From System Files

The repository should clearly show what a normal user edits and what the template owns.

Deliverables:

- Keep user-editable files in:
  - `src/`
  - `metadata/book.yaml`
- Keep template internals in:
  - `templates/`
  - `filters/`
  - `assets/`
- Document this boundary clearly.

Result:

Users stop digging through template internals to do normal writing tasks.

### Phase 8. Rewrite Documentation Around Usage, Not Setup

The README should lead with writing workflow, not installation details.

Deliverables:

- `README.md` should include:
  - what this template is
  - 3-step quick start
  - theme selection
  - writing workflow
  - basic Markdown patterns
  - build command
  - file structure
- Move environment installation details into `SETUP.md`.
- Add screenshots or rendered examples later if available.

Result:

New users understand how to use the template in a minute or two.

## Recommended README Structure

This repository should ultimately document itself in this order:

1. What this template is
2. Quick start
3. Choose a theme
4. Write your book
5. Special Markdown blocks
6. Build the PDF
7. File structure
8. Advanced customization
9. Local installation

`SETUP.md` should hold the installation details that are currently too prominent for first-time users.

## Recommended User-Facing Metadata

The user-facing metadata should be reduced to a small set like this:

```yaml
title: Lamiyyah of Ibn Taymiyyah
subtitle: A bilingual edition with Arabic source text and English translation
author:
  - Shaykh Zayd Al-Madkhali
translator: Abu Maryam Farooq Olanrewaju
theme: blue-hexagon
```

The template should resolve everything else internally.

## Recommended Authoring Principle

For ordinary users, this template should enforce one rule:

**Choose a theme once, then only write.**

That means:

- no manual color editing
- no manual front page tuning
- no per-book layout hacking
- no need to touch Typst unless doing advanced customization

## Priority Order

If this is implemented incrementally, the highest-value order is:

1. Theme API
2. Front page redesign
3. Qur'an and Hadith component polish
4. TOC and heading coherence
5. Markdown simplification
6. README and documentation cleanup

This order improves both design quality and ease of use quickly.

## Definition Of Done

This template is in a strong state when:

- a new user can select a theme in one line
- a new user can add chapters in Markdown without reading internal template code
- Qur'an and Hadith blocks look polished by default
- the front page, TOC, and headings all feel like one designed system
- the README teaches normal usage in under five minutes

