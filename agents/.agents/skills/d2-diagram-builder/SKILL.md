---
name: d2-diagram-builder
description: Create, edit, render, validate, and review D2 (.d2) diagrams and their SVG documentation artifacts. Use when the user explicitly requests D2, a .d2 file, or a D2-rendered SVG; also use when the user asks to draw, map, visualize, or update an architecture, software system, workflow, process, data flow, sequence, deployment, infrastructure, network, database schema, ERD, class, or UML diagram without specifying D2 or Mermaid, so that you can ask which format they prefer. Do not use for explicitly requested Mermaid work or convert existing Mermaid diagrams.
---

# D2 Diagram Builder

Create one focused, editable D2 diagram that answers the user's question, then render it as an SVG for documentation.

## Format selection

- Use D2 immediately when the user explicitly requests D2 or `.d2`.
- Use Mermaid immediately when the user explicitly requests Mermaid; do not create or change D2 files.
- When a diagram is requested but neither format is named, ask: **“Should this be a D2 diagram or a Mermaid diagram?”** Do not assume either format.
- Preserve existing Mermaid diagrams. Do not migrate them unless the user explicitly asks.

## Workflow

1. Inspect the repository's `docs/`, relevant code, schemas, and existing diagrams. Reuse its terminology and determine the audience and one question the diagram must answer.
2. Select the smallest suitable diagram type. Read the matching reference before authoring.
3. For D2 output, create or update a paired artifact in `docs/diagrams/d2/`:
   - `<name>.d2` — formatted editable source
   - `<name>.svg` — default rendered artifact
   - Create PNG, PDF, or other outputs only when requested.
4. Apply the light visual system in [DESIGN.md](DESIGN.md) and select a layout from **Layouts** below. Use project-specific brand guidance over the bundled visual system.
5. Format, validate, and render. Use the D2 process in [rendering and quality](references/rendering-and-quality.md). Never install D2. If it is unavailable, ask the user to install it; do not render or claim validation succeeded.
6. When documentation describes the diagram, embed the SVG and offer the D2 source as a link. Use paths relative to the Markdown file, for example:

   ```markdown
   [![System context](diagrams/d2/system-context.svg)](diagrams/d2/system-context.d2)
   ```

7. Review the rendered SVG for clipping, crossings, unreadable labels, ambiguous arrow direction, excessive density, and inaccurate domain meaning. Split a diagram by concern instead of shrinking it or adding every dependency.

## Diagram selection

| Intent | Prefer | Reference |
|---|---|---|
| Components, service boundaries, integrations, deployment | Architecture or infrastructure | [architecture and workflows](references/architecture-and-workflows.md) |
| Steps, branches, handoffs, retries, state transitions | Workflow | [architecture and workflows](references/architecture-and-workflows.md) |
| Runtime messages ordered over time | Sequence | [sequence, UML, and shapes](references/sequence-uml-and-shapes.md) |
| Entities, attributes, keys, and cardinality | ERD | [database and ERD](references/database-and-erd.md) |
| Types, inheritance, and associations | Class/UML | [sequence, UML, and shapes](references/sequence-uml-and-shapes.md) |

Ask a focused question when the request supports materially different views, such as component architecture versus runtime sequence. Do not generate all views unless requested or required by the documented scope.

## Layouts

Choose layout before writing nodes. Prefer the bundled `dagre` layout for simple directional graphs and `elk` for nested, dense, or edge-heavy diagrams. Confirm which layout engines are available with `d2 layout`; do not assume optional engines are installed.

| Layout | Direction and composition | Use for |
|---|---|---|
| System landscape | Left-to-right: actor → application/services → data and external systems | Context, component, and integration views |
| Workflow | Top-to-bottom: entry → actions/decisions → outcomes; error branches to the side | Processes, data flows, and runbooks |
| Sequence | Participants left-to-right; interactions descend in time | Requests, events, and protocol behavior |
| ERD | Cluster tables by domain; align relationships and keep key columns legible | Data models and schema boundaries |
| Deployment | Group resources within environment, account, region, or trust-zone containers | Infrastructure and trust boundaries |
| Dependency map | One directional reading flow; omit incidental edges | Only when dependency navigation is the point |

Use containers only for meaningful boundaries. Keep a consistent direction within a diagram; do not mix a hierarchy and a timeline in one view. Use ELK when nested containers or edge routing make Dagre unreadable. See [language and layout](references/language-and-layout.md) for syntax and controls.

## Authoring rules

- Prefer concise labels and stable identifiers. Put explanation in surrounding Markdown rather than inside nodes.
- Make arrow direction meaningful. Label an edge only when its meaning is not obvious.
- Use containers for ownership, runtime, network, or trust boundaries—not decoration.
- Use descriptive D2 shapes and approved icons sparingly. Icons identify a role; they do not replace labels.
- Use only local, repository-approved, license-compatible icon assets by default. Do not introduce remote icon URLs unless the user accepts network-dependent rendering and the source is suitable for redistribution.
- Use the theme and semantic styling in [DESIGN.md](DESIGN.md); do not imitate a third-party brand or make a dark diagram by default.
- Preserve manual style decisions in an existing diagram unless the user requests a visual refresh.

## References

- Read [language and layout](references/language-and-layout.md) for D2 syntax, containers, connections, styling, shapes, and layout controls.
- Read [architecture and workflows](references/architecture-and-workflows.md) for system and process patterns.
- Read [database and ERD](references/database-and-erd.md) for schema modeling.
- Read [sequence, UML, and shapes](references/sequence-uml-and-shapes.md) for interaction and type diagrams.
- Read [rendering and quality](references/rendering-and-quality.md) before rendering or reviewing output.
