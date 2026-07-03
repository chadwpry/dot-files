# [Project Name] — Implementation Plan

> **Version:** 1.0  
> **Last updated:** [DATE]  
> **Status:** [Draft / In Review / Approved]  
> **Current scope:** [Must match PRD.md and ARCHITECTURE.md current scope]  
> **This document describes WHAT needs to be built and in what order. See ARCHITECTURE.md for HOW.**

---

## Guiding Principle

[One sentence that captures the thesis of this phase. Example: "Validate that the core interaction works before building anything around it."]

---

## Account Setup (Software Developer)

> **For detailed signup URLs, free tier limits, environment variable reference tables, and local development configuration, see ENVIRONMENTS.md.** This section summarizes what's needed per phase.

The following accounts need to be created before starting development.

### Required Before Phase 0

- **[Service 1]** — [What it's for]. [Tier]. [One-line setup note.]
- **[Service 2]** — [What it's for]. [Tier].

### Required Before [Later Phase]

- **[Service 3]** — [What it's for]. [Tier].

### Environment Variables

> **For the complete environment variable reference, see ENVIRONMENTS.md.** This section lists only what's needed to start Phase 0.

---

## UI Design Approach

[Describe whether wireframes exist, what the engineer should reference, and how much design freedom they have. Example: "No Figma files exist. The engineer designs from scratch based on design tokens in ARCHITECTURE.md Section X."]

---

## Phase 0: [Foundation / Setup]

**Goal:** [One sentence describing what this phase achieves]

| # | Deliverable | Description | Dependencies |
|---|------------|-------------|--------------|
| 0.1 | [Deliverable name] | [What it is] | None |
| 0.2 | [Deliverable name] | [What it is] | 0.1 |

**Exit criteria:** [Testable conditions. "A running dev server with themed components. Auth working. Database accepting connections."]

---

## Phase 1: [Feature Group]

**Goal:** [One sentence describing what this phase achieves]

| # | Deliverable | Description | Dependencies |
|---|------------|-------------|--------------|
| 1.1 | [Deliverable name] | [What it is] | 0.x |
| 1.2 | [Deliverable name] | [What it is] | 0.x, 1.1 |

This phase may have parallel workstreams:

### Workstream A: [Workstream Name]

| # | Deliverable | Description | Dependencies |
|---|------------|-------------|--------------|
| 1A.1 | [Deliverable] | [What it is] | 0.x |

### Workstream B: [Workstream Name]

| # | Deliverable | Description | Dependencies |
|---|------------|-------------|--------------|
| 1B.1 | [Deliverable] | [What it is] | 0.x |

**Exit criteria:** [Testable conditions]

---

## Phase N: [Polish / Validation / Next Phase]

**Goal:** [One sentence]

| # | Deliverable | Description | Dependencies |
|---|------------|-------------|--------------|
| N.1 | [Deliverable] | [What it is] | Phase N-1 |

**Exit criteria:** [Testable conditions]

---

## Future Phases (TODO)

[Explicitly list what is NOT being built yet, with phase labels]

---

## Dependency Graph

```
Phase 0 (Foundation)
  ├── Phase 1 (Feature A)
  └── Phase 2 (Feature B)
        ├── Workstream A
        ├── Workstream B
        └── Workstream C
              └── Phase 3 (Polish)

Phase 4+ (Future) — TODO
```

**Critical path:** Phase 0 → Phase 2 → Phase 3

---

## Corrections and Decisions

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | [Build ordering, sequencing, or approach that was tried] | [What went wrong — dependency failure, blocker, or realization] | [The corrected approach or ordering] | [Why this sequencing or approach structurally doesn't work, not just "we didn't prefer it"] |

---

## Time Estimates

| Phase | Estimated Effort | Notes |
|-------|-----------------|-------|
| Phase 0 | [X-Y weeks] | [What makes it take this long] |
| Phase 1 | [X-Y weeks] | [Notes] |
| Phase 2 | [X-Y weeks] | [Notes] |
| Phase 3 | [X-Y weeks] | [Notes] |
| **Total** | **[X-Y weeks]** | [Team size assumption] |

---

*[End of PLAN.md]*