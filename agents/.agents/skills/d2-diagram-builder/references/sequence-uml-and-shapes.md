# Sequence, UML, and Shapes

## Sequence diagrams

Use a sequence diagram only when time ordering and message exchange are the primary question. Arrange participants left-to-right and messages from top to bottom. Keep each message a concise verb phrase and show only interactions necessary to explain the scenario.

D2 supports sequence-diagram syntax and constructs in current documentation, but syntax and availability can vary by installed version. Consult the official D2 documentation and validate a minimal diagram with the target CLI before using advanced constructs such as groups, notes, parallelism, or scenarios.

For a simple interaction diagram, a directed vertical workflow may be clearer and more portable. Do not claim a request is synchronous merely because it appears in sequence order—label calls, events, acknowledgements, timeouts, and retries.

## Class/UML-like diagrams

Use a `class` shape for types, attributes, operations, inheritance, and associations when the structural model is the point. Keep implementation-private members out unless requested. Prefer an architecture or ERD diagram for runtime/deployment or persistence questions.

Use association labels and direction only when they clarify ownership or multiplicity. Avoid recreating every source-language type; show the public or domain model readers need.

## Shape selection

Choose meaning before visual novelty:

| Concept | Preferred treatment |
|---|---|
| Person or role | `person` shape or labeled actor icon |
| Application/service | rounded node or descriptive approved icon |
| Data store | `cylinder` or `sql_table` |
| Queue/topic | `queue` |
| Decision | `diamond` |
| External service | labeled image/icon or distinct styled node |
| Boundary | labeled container |

Validate shapes with the installed CLI. If a native shape is unsupported, use a clearly labeled rounded node rather than a fragile workaround.
