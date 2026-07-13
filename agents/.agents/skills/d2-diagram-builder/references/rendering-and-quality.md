# Rendering and Quality

## Official documentation

- [D2 language and tour](https://d2lang.com/)
- [Layouts](https://d2lang.com/tour/layouts)
- [ELK layout](https://d2lang.com/tour/elk)
- [D2 source and CLI documentation](https://github.com/terrastruct/d2)

Consult the official documentation for version-specific language features not covered by this skill.

## Tool policy

Check availability with `command -v d2`. **Never install D2.** If it is unavailable, ask the user to install it and explain that source can be drafted but cannot be rendered or CLI-validated until it is available.

Use the installed CLI's help to confirm themes, layouts, and version-specific behavior:

```bash
d2 --version
d2 themes
d2 layout
```

D2 0.7.1 provides light themes including Neutral Default (0), Neutral Grey (1), Flagship Terrastruct (3), Cool Classics (4), Mixed Berry Blue (5), Grape Soda (6), Aubergine (7), Colorblind Clear (8), Vanilla Nitro Cola (100), Orange Creamsicle (101), Shirley Temple (102), Earth Tones (103), Everglade Green (104), Buttered Toast (105), Terminal (300), Terminal Grayscale (301), Origami (302), and C4 (303). Use a light theme only as a base; the bundled [DESIGN.md](../DESIGN.md) establishes the diagram's semantic styling.

## Format, validate, render

Run commands from the repository root and always use explicit paired paths:

```bash
d2 fmt docs/diagrams/d2/<name>.d2
d2 validate docs/diagrams/d2/<name>.d2
d2 docs/diagrams/d2/<name>.d2 docs/diagrams/d2/<name>.svg
```

Use `--layout elk` only when its routing materially improves the diagram. Request non-SVG formats explicitly:

```bash
d2 docs/diagrams/d2/<name>.d2 docs/diagrams/d2/<name>.png
```

Do not infer success merely from an output file: D2 can write a partial render on error. Check the command exit status. Avoid sketch mode by default. Do not use a dark theme by default.

## Markdown embedding

Embed the SVG in the Markdown that explains it, using a path relative to that Markdown file, and link the image to its editable source:

```markdown
[![Order processing flow](diagrams/d2/order-processing.svg)](diagrams/d2/order-processing.d2)
```

For a document below `docs/subsystem/`, adjust the relative prefix accordingly. Give the image meaningful alt text. Do not embed a PNG where SVG is available.

## Final review

- Inspect the rendered SVG, not source alone.
- Verify no clipping, overlaps, accidental crossings, empty labels, or invisible low-contrast text.
- Verify arrows and labels accurately represent the source system.
- Confirm the source is formatted and the SVG is regenerated after final source changes.
- Confirm documentation links work from the location of the Markdown file.
