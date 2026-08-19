# Architecture and Workflow Patterns

## Architecture diagrams

Answer one architecture question per diagram:

- **Context:** who or what interacts with the system, and what is outside its boundary?
- **Container/component:** which deployable or logical parts own which responsibilities?
- **Integration/data flow:** which interfaces, protocols, topics, and stores connect the parts?
- **Deployment:** where does each component run, across which environment or trust boundary?

Use left-to-right flow: actors at left, owned application components in the center, stores/integrations at right. Wrap meaningful boundaries (organization, VPC, runtime, environment, or domain) in containers. Mark external systems distinctly and label only non-obvious relationships.

Do not mix a deployment view with method-level interactions. Split the diagram if readers need both.

## Workflow diagrams

Use top-to-bottom flow with one clear start and end. Model actions as nodes, real branches as diamonds, and bounded outcomes as terminal nodes. Label each decision exit with its condition. Keep failures close to the action that can fail, but route retries/dead-letter handling aside from the happy path.

```d2
direction: down
receive: Receive event
validate: Validate payload
decision: Valid? {shape: diamond}
process: Process order
reject: Reject event

receive -> validate -> decision
decision -> process: yes
decision -> reject: no {
  style.stroke-dash: 4
}
```

Use a queue shape and a labeled edge for asynchronous work. A workflow should describe behavior, not every implementation dependency.

## Data-flow conventions

- Label writes, reads, publishes, consumes, and calls when the verb matters.
- Distinguish synchronous calls from asynchronous events with both labels and styling.
- Show a trust boundary when data crosses one.
- Do not imply persistence merely because a service is shown; add the store and the write/read relationship.

## Review prompts

Before finalizing, ask whether a new reader can identify the system boundary, primary path, ownership of each component, and the meaning of non-default edges in a few seconds. If not, reduce scope or create a second diagram.
