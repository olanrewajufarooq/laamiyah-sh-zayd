# Introduction

This is a sample text with a footnote.[^1] It demonstrates the baseline prose styling, the rhythm of paragraphs, and how the translation-focused components sit inside an ordinary chapter flow.

[^1]: Example footnote.

## Reading Pattern

The layout is intended to separate ordinary commentary from source citations. Arabic-only passages should read as distinct blocks, while paired Qur'anic and Hadith citations should present the Arabic and English together as a single centered unit.

::: quran
::: quran-arabic
بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
:::

::: quran-english
In the name of Allah, the Most Merciful, the Especially Merciful.
:::
:::

The citation above should feel visually set apart from the body text rather than simply indented. That separation matters because readers often scan first for structure, then for wording.

::: hadith
::: hadith-arabic
إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ
:::

::: hadith-english
Actions are judged only by intentions.
:::
:::

## Arabic-Only Block

::: arabic
وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ
:::

## Translator Guidance

When a term does not map neatly into English, the translation should aim for readability first, then explain the remaining tension in a short note. This keeps the page readable while still signaling where interpretive choices were made.

::: translator-note
This is a translator's note explaining a nuance in the Arabic.
:::

## Longer Example

This additional paragraph is here to test spacing across multiple sections. It also helps verify that the table of contents has more than one target and that second-level headings are reflected correctly in the generated outline.

Another paragraph gives the page enough density to show how prose, quotations, notes, and footnotes sit together. That mix is what usually exposes weak defaults in a book template, so it is better to stress the template now than after real content has been added.
