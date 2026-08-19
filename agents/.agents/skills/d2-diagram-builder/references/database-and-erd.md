# Database and ERD Diagrams

Use an ERD when the question concerns entities, fields, keys, cardinality, or ownership. Do not put all physical storage details in an architecture diagram.

## Modeling rules

- Use one `sql_table` node per entity/table and group tables by bounded context or domain.
- Include a concise field set: primary key, foreign keys, fields that explain a relationship, and materially important constraints. Omit routine audit fields unless they affect the question.
- Mark primary and foreign keys with D2 table field constraints when supported by the installed version.
- Label relationship cardinality explicitly when it matters. Do not rely only on visual proximity.
- Use directed edges consistently, for example child `->` parent with a `many-to-one` label, or use labels at both ends when the chosen notation needs them.

```d2
direction: right

customer: Customer {
  shape: sql_table
  id: uuid {constraint: primary_key}
  email: text
}

order: Order {
  shape: sql_table
  id: uuid {constraint: primary_key}
  customer_id: uuid {constraint: foreign_key}
  status: text
}

order -> customer: many-to-one
```

## Visual treatment

Use the Data teal token pair from [DESIGN.md](../DESIGN.md) for persistent stores. Use neutral boundary containers to separate domains. Keep relationship lines out of table bodies where possible; use ELK if many relationships cross.

## Review checklist

- Does every shown foreign key have an intended relationship?
- Is cardinality clear where a reader might otherwise guess?
- Are conceptual entities separated from physical tables when that distinction matters?
- Is the diagram scoped to the requested domain rather than the whole database?
