# Diagram Design System: Field Notes

## 1. Visual theme and atmosphere

Create light, editorial technical diagrams: calm, precise, and tactile rather than a wall of standard flowchart boxes. Favor a warm paper canvas, dark ink, modest color, rounded containers, and generous whitespace. Make structural meaning obvious before adding decoration.

Use this system as the default only when the repository has no established diagram or brand system. It is original guidance, not a reproduction of any referenced product or brand.

## 2. Color palette and roles

| Token | Hex | Use |
|---|---:|---|
| Paper | `#FCFBF8` | Diagram canvas and open space |
| Ink | `#24313D` | Text, primary borders, and primary edges |
| Slate | `#64748B` | Supporting labels and secondary edges |
| Service blue | `#2F6B9A` | Application/service nodes |
| Service blue tint | `#E8F1F7` | Application/service fill |
| Data teal | `#0F766E` | Databases, stores, and durable data paths |
| Data teal tint | `#E4F5F1` | Data node fill |
| Event amber | `#A16207` | Queues, topics, events, and asynchronous paths |
| Event amber tint | `#FFF3D6` | Event node fill |
| Control violet | `#6D4AA2` | Identity, policy, orchestration, and control-plane nodes |
| Control violet tint | `#F1EAFE` | Control-plane node fill |
| External coral | `#B4534B` | External systems, warnings, and trust-boundary crossings |
| External coral tint | `#FCEAE7` | External system fill |
| Boundary mist | `#F4F6F8` | Containers and low-emphasis grouping |

Use a tinted fill with its corresponding dark border/text color for semantic nodes. Use Ink for ordinary relationships and Slate for secondary relationships. Do not use color alone to communicate state: use an edge label, shape, or line treatment too.

## 3. Typography and labels

- Use the renderer's default sans-serif family unless a project supplies licensed fonts.
- Make node names short noun phrases; put protocol, command, or event detail on edges.
- Use sentence case, not title case, except for product names and acronyms.
- Use monospaced text only for identifiers, table fields, topics, APIs, and code-like labels.
- Avoid paragraphs inside nodes. Put context in nearby Markdown or a concise note.

## 4. Component styling

- **Service:** rounded rectangle; Service blue tint/fill pairing.
- **Data store:** `cylinder` or `sql_table`; Data teal pairing.
- **Queue/topic:** `queue`; Event amber pairing.
- **Actor/client:** person, browser/device image, or a labeled rounded node; Ink or Service blue pairing.
- **External dependency:** distinctive descriptive shape or approved icon; External coral pairing.
- **Identity/control:** shield/key-like descriptive shape or labeled node; Control violet pairing.
- **Boundary:** rounded container with Boundary mist fill, Ink/Slate border, and a meaningful label.
- **Decision:** diamond only for a real branch. Label outgoing branches with conditions.

Prefer D2's descriptive native shapes to generic boxes. Use approved local SVG icons only where they accelerate recognition; retain a text label and preserve a sensible fallback shape.

## 5. Layout principles

- Use one dominant reading direction and leave at least one node-width of visual breathing room between groups.
- Keep primary paths visually direct. Route exceptional/error paths away from the main path and use a label or dashed line.
- Group by domain or boundary before grouping by implementation detail.
- Avoid crossings. If crossings remain, change ordering, simplify the view, or use ELK.
- Avoid gratuitous shadows, gradients, hand-drawn/sketch treatment, and decorative emoji.

## 6. Depth and emphasis

Use emphasis sparingly:

1. Main path: Ink edge and normal-weight label.
2. Secondary/supporting path: Slate edge.
3. Asynchronous/event path: Event amber edge plus an explicit label.
4. Exceptional/error path: External coral, dashed edge, and concise condition label.

Do not use more than five semantic colors in a single small diagram. Make the main path readable in grayscale through placement, shape, and edge treatment.

## 7. Do and don't

**Do**
- Use light backgrounds, high text contrast, short labels, and semantic color roles.
- Encode trust, ownership, environment, and runtime boundaries with labeled containers.
- Prefer multiple focused diagrams over one exhaustive map.
- Render and inspect every changed SVG.

**Don't**
- Default to a dark theme, generic rainbow nodes, or vendor logos as decoration.
- Depend on a remote URL for required icon rendering without explicit approval.
- Shrink font sizes or pack nodes tightly to avoid splitting a diagram.
- Use icons without labels or color as the only semantic signal.
