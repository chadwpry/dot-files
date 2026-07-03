# Planning Workflow Reference

This reference describes the step-by-step workflow for creating and refining project specification documents in the `docs/` folder.

## Document Creation Order

Documents should be created in dependency order because later documents reference earlier ones:

```
1. docs/PRD.md          ← What to build and why (no dependencies)
2. docs/RESEARCH.md     ← Competitive context (depends on PRD scope)
3. docs/ARCHITECTURE.md ← How to build it (depends on PRD + RESEARCH)
4. docs/PLAN.md         ← Build order and phases (depends on ARCHITECTURE)
5. Project-specific docs ← As needed based on domain requirements
```

## Starting a New Project

1. **Initialize repository:** Ensure `jj` is available, initialize repo if needed.
2. **Create `docs/` directory.**
3. **Start with PRD.md:** Collaborate with the stakeholder to define:
   - What the product is and is not
   - Target users and their needs
   - Functional requirements (numbered, testable)
   - Non-functional requirements (measurable)
   - Success metrics (with numbers)
   - Out of scope items
4. **Then RESEARCH.md:** If competitive analysis is needed:
   - Identify competitors and their profiles
   - Synthesize key findings
   - Document technology evaluations
   - Capture gap analysis
5. **Then ARCHITECTURE.md:** Based on PRD requirements:
   - System overview and data flows
   - Database schema (every column, type, constraint)
   - Project structure (every file the engineer must create)
   - API design (endpoints, shapes, auth)
   - Key technical decisions with rationale
   - Security architecture
   - Environment variables (scoped public vs server-only)
   - Error handling codes and policies
6. **Then PLAN.md:** Based on ARCHITECTURE:
   - Guiding principle for the phase
   - Account setup requirements
   - Phase table with deliverables and dependencies
   - Exit criteria per phase (testable conditions)
   - Dependency graph
   - Time estimates

## Refining Existing Documents

1. Read all existing `docs/*.md` files.
2. Compare each against `docs-standards` quality checklists.
3. Identify gaps, inconsistencies, and conflicts.
4. Resolve conflicts using document hierarchy (ARCHITECTURE.md > PRD.md > PLAN.md > project-specific > RESEARCH.md).
5. Add Corrections and Decisions entries for changed assumptions.
6. Ensure cross-document traceability (every PRD requirement traces to ARCHITECTURE and PLAN).

## Cross-Document Traceability

Requirements must trace across documents:

```
PRD.md (functional requirement #5)
  → ARCHITECTURE.md (API endpoint, database table, data flow)
    → PLAN.md (phase deliverable, exit criteria)
      → Implementation (code, config, tests)
```

If a PRD requirement has no corresponding architecture section, the spec is incomplete.
If an architecture section describes something not in the PRD, it may be out of scope. Flag both cases to the stakeholder.

## Writing Effective Requirements

### Functional Requirements (PRD)

- **Testable:** "The system shall reject passwords shorter than 8 characters" not "The system shall have good security"
- **Numbered:** FR-1, FR-2, FR-3 — so other documents can reference them
- **Prioritized:** Must have / Should have / Nice to have
- **Specific:** Include exact values, not vague descriptors

### Architecture Requirements

- **Complete:** Database schema has every column, type, and constraint
- **Explicit:** File paths and names are specified, not left to the engineer
- **Unambiguous:** API shapes are fully defined, not described in prose
- **Justified:** Every technical decision has rationale (not just the choice)

### Plan Requirements

- **Testable exit criteria:** "User can complete onboarding and see their profile in the database" not "Feature works"
- **Explicit dependencies:** "Deliverable 2.3 depends on 1.2" not "after the database is ready"
- **Ordered:** Phases are sequenced with clear reasons for the order

## Corrections and Decisions Format

Every core specification document should include this section. Each entry:

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | [The approach, technology, or assumption] | [What actually went wrong] | [The replacement approach] | [Why this isn't just "not right now" but structurally wrong] |

Writing good entries:
- **Be specific** — "Tried using Supabase Realtime for presence" not "Tried a real-time approach"
- **Explain the failure** — What actually went wrong, not just that it didn't work
- **Name the replacement** — Every correction must state the current approach
- **Close the door** — The "Why Not To Revisit" column must answer "but what if things change?"