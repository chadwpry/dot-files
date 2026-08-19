# D2 Language and Layout

## Core syntax

Use identifiers for stable references and labels for reader-facing text.

```d2
users: Users
api: Public API
users -> api: HTTPS

platform: Platform {
  api
  worker: Background worker
}
```

Use quoted labels when punctuation or whitespace makes a label ambiguous. Define a container with `{}` and refer to nested nodes with dotted paths. Put properties such as `shape`, `icon`, and `style.*` on the node or edge.

```d2
orders: Orders {
  shape: sql_table
  id: uuid {constraint: primary_key}
  customer_id: uuid {constraint: foreign_key}
}

api -> orders: writes {
  style.stroke: "#0F766E"
}
```

## Direction and relationships

Set global direction near the top when the reading direction matters:

```d2
direction: right
client -> gateway -> service
```

Use `->` for directed flow and `<->` only when bidirectionality is genuinely the message. Keep edge labels short: protocol, command, event, or condition. Style exceptional paths with an explicit label and a dashed edge; do not rely on a color alone.

## Shapes and icons

Use native shapes that convey role: `cylinder` for stores, `queue` for asynchronous messaging, `diamond` for decisions, `person` for people, `sql_table` for entities, and `class` for UML-like types. Confirm a shape is supported by the installed D2 version before relying on it.

For an icon or image, pair `shape: image` with `icon: <path-or-url>`. Prefer a repository-relative, approved local asset. An icon must supplement—not replace—a text label. Avoid remote URLs unless the user explicitly accepts network-dependent rendering.

## Styling

Apply [DESIGN.md](../DESIGN.md) tokens through explicit properties when the built-in theme alone does not express the required role.

```d2
service: Billing service {
  style.fill: "#E8F1F7"
  style.stroke: "#2F6B9A"
  style.font-color: "#24313D"
  style.border-radius: 10
}
```

Keep styling at the node, edge, or meaningful container level. Do not add an unmaintainable global block of exceptions. Check installed D2 support before using uncommon style keys.

## Layout engines

D2 0.7.1 bundles `dagre` and `elk`:

- `dagre`: default; use for small to medium directional graphs.
- `elk`: use for dense diagrams, nested containers, or difficult edge routing.

Discover availability with `d2 layout`. Render with a selected engine when needed:

```bash
d2 --layout elk docs/diagrams/d2/system.d2 docs/diagrams/d2/system.svg
```

Use `direction: right` for system landscapes and pipelines; use the default/top-down arrangement for workflows and hierarchies. Change grouping and ordering before trying to solve a poor diagram with styling.
