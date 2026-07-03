---
name: docs-standards
description: >
  Defines the expected structure, sections, and content for project specification
  markdown files in the docs/ folder. Use when creating, reviewing, or referencing
  project documentation to ensure specs have the right information in the right place.
  Triggers: docs, documentation, spec, specification, PRD, architecture, plan, research,
  project docs, docs folder.
---

# Docs Standards

Project specifications live in markdown files in the `docs/` folder. This skill defines what each file contains, what sections it must have, and how the files relate to each other. Other skills reference this standard to know what information to expect and where to find it.

## Document Inventory

Every project should have these core specification files in `docs/` (project-specific files are additional, not replacements):

| File | Purpose | Traces to |
|------|---------|----------|
| `docs/ONBOARDING.md` | Condensed project summary — fast orientation for new sessions (~2-5K tokens instead of reading all docs) | All core docs |
| `docs/PRD.md` | Product requirements — what to build and why | Business and user needs |
| `docs/ARCHITECTURE.md` | Technical architecture — how to build it | PRD requirements |
| `docs/ENVIRONMENTS.md` | Operational reference — how to configure, run, and debug the system | Architecture decisions |
| `docs/PLAN.md` | Implementation plan — phases, order, exit criteria | Architecture decisions |
| `docs/RESEARCH.md` | Competitive research and technology evaluation — context, not prescription | Market and technical landscape |
| `docs/design/NNN-description.md` | Design documents — temporal technical decisions, migrations, phased changes | Architecture decisions (transition state) |

Projects may have additional `docs/*.md` files for domain-specific specifications (prompts, data models, API contracts, etc.). These are supplementary and scoped by the project.

### `docs/ONBOARDING.md` — Project Onboarding Summary

`docs/ONBOARDING.md` is a **condensed summary** of the project designed to orient a new session quickly, consuming ~2-5K tokens instead of ~20K tokens reading all docs. It is the **entry point** for project exploration — all skills and agents should read `docs/ONBOARDING.md` first if it exists.

**Contents must include:**

| Section | Must Contain |
|---------|-------------|
| **Project Summary** | One-paragraph description: what it is, what it does, for whom |
| **Tech Stack** | Languages, frameworks, key dependencies (just the list, not rationale) |
| **Architecture Diagram** | ASCII or text diagram of service communication (compact version of ARCHITECTURE.md diagram) |
| **Current Status** | Which phase is complete, in progress, and next (from PLAN.md) |
| **Key Decisions** | 3-5 most impactful decisions or corrections from across all docs (not the full tables — just the headlines and why-not-to-revisit reasons) |
| **Quick Start** | Command to run the dev stack, command to run tests (from ENVIRONMENTS.md Quick Start) |
| **Project Structure** | Compact directory tree (top-level only for each major area) |
| **Where to Find Details** | Mapping of "need X → read Y doc" (e.g., "API endpoints → ARCHITECTURE.md §5") |

**Contents must NOT include:**
- Full requirement tables, full schema definitions, full API endpoint tables
- Detailed environment variable tables
- Step-by-step deployment instructions
- Lengthy rationale or research details

Those details live in the core docs. ONBOARDING.md links to them, it does not duplicate them.

**When to update ONBOARDING.md:**
- When a phase status changes (completing a phase in PLAN.md)
- When a new core doc is added
- When a significant technical decision or correction is made
- When the tech stack changes
- When the project structure changes significantly

ONBOARDING.md is maintained by the `software-planner` skill during document authoring, and can also be updated by the `software-developer` skill when implementation changes require it.

### Design Documents (`docs/design/`)

Design documents capture **temporal technical decisions**: migrations, schema changes, architectural transitions, and phased rollout plans. They are richer than a Corrections and Decisions table row (which summarizes the outcome) but more specific than ARCHITECTURE.md (which describes the current state, not the migration history).

Design documents live in `docs/design/` and are numbered sequentially:

```
docs/design/
├── 001-description-of-change.md
├── 002-description-of-change.md
└── ...
```

**When to create a design document:**
- A significant architectural change (service migration, data model overhaul)
- A multi-phase rollout with checkpoints (especially when phases may span sessions)
- A design decision that involves multiple moving parts (API changes, schema changes, Worker changes, frontend updates)
- Something that has its own "Phase 1, Phase 2, Phase 3" progression

**When NOT to create a design document:**
- A simple one-step change (just update ARCHITECTURE.md and add a Corrections row)
- A bug fix (no design needed)
- A quick configuration change (update ENVIRONMENTS.md)

**Relationship to core docs:**
- ARCHITECTURE.md describes the **current state** (what the system looks like now)
- Design documents describe the **transition** (how it got here or how it will change)
- When a design document's changes are complete, ARCHITECTURE.md should already reflect the new state
- ARCHITECTURE.md references design documents in Corrections and Decisions and in Key Technical Decisions
- A design document is **not** a living document — once its phases are complete, it becomes a historical record

## Document Hierarchy

When documents conflict, follow this priority order:

1. **`docs/ARCHITECTURE.md`** — Technical decisions, data models, APIs, schemas, and implementation details override all other docs because this is what the code must match
2. **`docs/PRD.md`** — Product requirements, scope, and business rules override plan and research
3. **`docs/ENVIRONMENTS.md`** — Operational configuration: environment variables, service ports, cloud credentials, troubleshooting. When ENVIRONMENTS.md and ARCHITECTURE.md conflict on operational facts (ports, env var names, config values), ENVIRONMENTS.md wins because it's maintained to match the running system
4. **`docs/PLAN.md`** — Implementation phases, deliverables, and dependency order
5. **`docs/design/NNN-*.md`** — Design documents (transitional decisions, migrations) — describe the transition state; ARCHITECTURE.md describes the current state. When complete, design doc outcomes must be reflected in ARCHITECTURE.md
6. **Project-specific docs** (e.g., `docs/ONBOARDING_PROMPT.md`) — Domain-specific specifications
7. **`docs/RESEARCH.md`** — Background context and competitive analysis (informative, never prescriptive)
8. **Other `docs/*.md` files** — Supplementary specifications

If ARCHITECTURE.md says the database has a `profiles` table but PRD.md describes a `users` table, ARCHITECTURE.md wins. Report the conflict to the project owner.

## Corrections and Decisions

Every core specification document (PRD.md, ARCHITECTURE.md, PLAN.md, RESEARCH.md) should include a **Corrections and Decisions** section. This section captures wrong paths taken, abandoned approaches, pivots, and changed assumptions — so they are not repeated.

This is different from "Resolved Decisions" (which captures proactive choices) and "Open Decisions" (which captures undecided questions). Corrections and Decisions captures **reactive learnings**: approaches that were tried and failed, ideas that seemed right but weren't, and assumptions that turned out to be wrong.

### Why This Section Exists

- Engineers with fresh context windows (or new team members) will re-explore the same dead ends unless told not to.
- Research often evaluates and rejects options — that rejection reasoning must be preserved.
- Architecture pivots lose their rationale over time, making the new approach seem arbitrary.
- Sequencing mistakes in the plan can be repeated if the reasoning for the correct order isn't documented.

### Format

Each entry is a row in a table with these columns:

| Column | Must Contain |
|--------|-------------|
| **#** | Entry number for reference |
| **What We Tried** | The approach, idea, technology, or assumption that was explored |
| **Why It Was Wrong** | What happened — the failure mode, conflict, or realization that made this approach unworkable |
| **What We Do Instead** | The approach or decision that replaced it |
| **Why Not To Revisit** | The fundamental reason this isn't just "not right now" but structurally wrong for this project. This is the key column — it must answer "but what if we try it again?" definitively |

### Examples

**Architecture correction:**

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | Using a single `users` table with a `role` column for all user types | Business team requires different data shapes per user type; polymorphic queries became complex and error-prone; RLS policies couldn't cleanly separate access | Separate `profiles`, `providers`, and `admins` tables with shared auth | The core issue is different data ownership and access patterns per user type, not a schema preference. Any single-table approach will hit the same RLS and query complexity wall. |

**PRD correction:**

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | Matching algorithm visible to users with compatibility scores | Users found scores reductive and anxiety-inducing; reduced willingness to engage; competitor data showed scores correlate negatively with retention | Anonymous matching — users see shared interests only, no numeric score | User testing across multiple friend-matching platforms (Patook, Peanut) showed that numeric scores create comparison anxiety without improving match quality. The trend in successful platforms is toward shared-interest disclosure without scoring. |

**Plan correction:**

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | Building the dashboard before the onboarding flow | Dashboard requires user data to display; no users have completed onboarding yet, so dashboard shows empty state that can't be validated | Build onboarding first, then dashboard when we have real user data | Dashboard widgets need real data to validate UX. Building first means designing for imaginary usage patterns that may not match actual behavior. This is a structural dependency, not a preference. |

### Where Corrections Appear

Corrections go in the document that governs the domain of the mistake:

| Document | Corrections About |
|----------|-------------------|
| `docs/PRD.md` | Product direction pivots, scope mistakes, feature assumptions that proved wrong |
| `docs/ARCHITECTURE.md` | Technical dead ends, abandoned schemas, rejected technologies, structural design changes |
| `docs/PLAN.md` | Sequencing mistakes, dependency misjudgments, build-order pivots |
| `docs/RESEARCH.md` | Evaluated-and-rejected technologies, competitive assumptions that changed, research dead ends |
| `docs/design/NNN-*.md` | Design-specific pivots within the change (e.g., “tried X extraction tier first, moved to Y") |

A correction that spans multiple documents (e.g., a product pivot that invalidated an architecture choice) should appear in both documents, with each entry focusing on its domain. The PRD entry describes the product correction; the ARCHITECTURE.md entry describes the technical correction that resulted.

### Writing Good Entries

- **Be specific** — "Tried using Supabase Realtime for presence" not "Tried a real-time approach"
- **Explain the failure** — What actually went wrong, not just that it didn't work
- **Name the replacement** — Every correction must state the current approach
- **Close the door** — The "Why Not To Revisit" column must answer the question "but what if things change?" If the reason might change (e.g., a library improved), say so: "Not revisitable until [specific condition changes]." Otherwise, state why it's structurally wrong.
- **Don't editorialize** — "Query complexity exceeded what RLS could handle cleanly" not "It was a terrible idea"

## `docs/PRD.md` — Product Requirements Document

What to build and why.

### Required Sections

| Section | Must Contain | Why It Matters for Implementation |
|---------|-------------|-----------------------------------|
| **Product Overview** | What it is, what it is not, target users, competitive positioning | Sets scope boundaries so the engineer doesn't over-build |
| **Current Scope** | Exactly what features, flows, and data are in scope right now | Distinguishes prototype from future vision |
| **Out of Scope** | Explicitly what is NOT being built | Prevents scope creep and over-engineering |
| **Functional Requirements** | Numbered, testable requirements | Each requirement traces to implementation code |
| **Non-Functional Requirements** | Performance, accessibility, security, compliance constraints | Sets technical constraints the implementation must satisfy |
| **Success Metrics** | Target values for completion rates, error rates, etc. | Defines when the implementation is "good enough" |
| **Corrections and Decisions** | Wrong paths taken and abandoned, with reasoning | Prevents the engineer from repeating the same mistakes |
| **Resolved Decisions** | What was decided and why | Prevents re-litigating settled questions |
| **Open Decisions** | What hasn't been decided yet | Tells the engineer to ask rather than assume |

### Quality Checklist

- Every requirement is testable (could a tester write a test for it?)
- "Out of scope" is explicit, not implied
- Success metrics have numbers, not just descriptions ("> 70% completion rate", not "high completion")
- Corrections and Decisions entries explain what was tried, why it failed, what was done instead, and why not to revisit it
- Open decisions are clearly flagged so the engineer doesn't silently resolve them

---

## `docs/ARCHITECTURE.md` — Technical Architecture

How to build it. This is the single most important file for implementation — every line of code should trace back to a decision in this document.

### Required Sections

| Section | Must Contain | Why It Matters for Implementation |
|---------|-------------|-----------------------------------|
| **System Overview** | High-level architecture, what service/tool talks to what | The engineer needs the map before laying roads |
| **Data Flow** | Step-by-step flows for key interactions (e.g., "user signs up → profile created → onboarding starts") | Shows the sequence and dependencies |
| **Database Schema** | Tables, columns, types, constraints, indexes, RLS policies | Complete enough to write migrations from |
| **Project Structure** | Directory layout with file-by-file purpose | The engineer should be able to scaffold this blindly |
| **API Design** | Endpoints, methods, request/response shapes, auth, error codes | The contract between frontend and backend |
| **Key Technical Decisions** | Framework choices, service choices, patterns, and why each was chosen | Pre-answers "should I use X or Y?" questions |
| **Security Architecture** | Auth flows, RLS policies, encryption, CORS, rate limits, trust boundaries | Prevents security holes and inconsistent auth |
| **Environment Variables** | Reference table: variable name, scope (public/server), description, example value — or cross-reference to ENVIRONMENTS.md if that document is being maintained | Ensures no missing config and no leaked secrets |
| **Error Handling** | Error codes, retry policies, fallback behaviors | Prevents each file from inventing its own error patterns |
| **Design System Tokens** | Colors, typography, spacing, component specs — if the project has a UI | Ensures visual consistency without guessing |
| **Infrastructure & Deployment** | Where it deploys, how, regions, CI/CD approach | The engineer needs to know the target environment |
| **Corrections and Decisions** | Technical dead ends, abandoned approaches, and pivots with reasoning | Prevents the engineer from rebuilding the same failed solutions |
| **Open Architecture Decisions** | Technical decisions not yet made | Like PRD open decisions, but technical |
| **Future Architecture (TODO)** | What's coming later but not now | Prevents the engineer from accidentally building for v2 |

### Quality Checklist

- Database schema has every column, type, and constraint
- Project structure lists every file the engineer must create
- Every environment variable has its scope clearly marked (public vs. server-only)
- Error codes are defined before the engineer writes error handling
- Data flows show the full end-to-end path, not just one service
- Corrections and Decisions entries explain what approach was tried, why it was abandoned, the alternative chosen, and why the rejected approach should not be revisited

---

## `docs/ENVIRONMENTS.md` — Operational Reference

How to configure, run, and debug the system. This is the single source of truth for environment variables, service ports, cloud account setup, and troubleshooting. Architecture decisions live in ARCHITECTURE.md; ENVIRONMENTS.md only describes how to operate what ARCHITECTURE.md designed.

### Content Boundaries

**ENVIRONMENTS.md contains (operational — "how to run"):**
- What runs locally vs. cloud (concise table, not a full architecture diagram)
- Cloud services: which are required, signup URLs, free tier limits, self-hosting alternatives
- Environment variable reference tables grouped by target (frontend, agent, server-side), with required/optional flags and examples
- Local service ports and configuration
- Local development quirks (e.g., "magic links appear in Studio, not your email")
- Testing instructions: how to verify the system works end-to-end
- Troubleshooting: problem → solution table
- Production deployment: where each component deploys, what changes between local and production
- Reset and cleanup instructions
- Interactive setup script reference (`bun scripts/setup.ts`)

**ENVIRONMENTS.md does NOT contain (design — lives in ARCHITECTURE.md or PRD.md):**
- Why a technology was chosen over alternatives
- Full data models or SQL schemas
- Step-by-step data flow descriptions
- Design system tokens or UI specifications
- Product requirements or feature scope

**Other documents should not duplicate ENVIRONMENTS.md content.** When PLAN.md or ARCHITECTURE.md need to reference env vars or account setup, they link to ENVIRONMENTS.md instead of repeating the tables.

### Required Sections

| Section | Must Contain | Why It Matters for Implementation |
|---------|-------------|-----------------------------------|
| **Quick Start** | Command to run the interactive setup script, common day-to-day commands | Gets a new developer from zero to running in minutes |
| **Where Things Run** | Local vs. cloud services, ports, what each service provides | The developer needs to know what runs on their machine vs. what needs API keys |
| **Cloud Accounts & API Keys** | Signup URLs, free tier limits, what each key is for, optional vs. required | Prevents "I can't start until I have an account on X" blockers |
| **Local Configuration** | Config file settings, local auth quirks, environment-specific overrides | Prevents confusion about why things behave differently locally |
| **Environment Variables Reference** | Complete tables: variable name, required/optional, example value, scope, grouped by target | Single source of truth — no other doc should maintain env var lists |
| **Testing the Full Flow** | Step-by-step verification that everything works end-to-end | Confirms the setup actually works, catches config errors early |
| **Troubleshooting** | Problem → solution table for common setup and runtime issues | Prevents repeated questions and time wasted on known issues |
| **Reset Instructions** | How to wipe and recreate the local environment | Developers will break things; they need a clean recovery path |
| **Production Deployment** | Where each component deploys, deployment steps, what changes from local | The developer needs to know the target environment |

### Quality Checklist

- Every environment variable is listed with its target (frontend, agent, edge function secrets)
- Cloud services clearly mark what's required vs. optional
- Local development quirks are documented (things that behave differently than production)
- Troubleshooting covers the most common failure modes
- No design rationale — that belongs in ARCHITECTURE.md
- No full schemas or data model definitions — those belong in ARCHITECTURE.md
- Setup commands reference the automation script, not manual steps

---

## `docs/PLAN.md` — Implementation Plan

What order to build it in, with clear exit criteria so the engineer knows when each phase is done.

### Required Sections

| Section | Must Contain | Why It Matters for Implementation |
|---------|-------------|-----------------------------------|
| **Guiding Principle** | The one-sentence thesis of this phase | Keeps the engineer focused on the right goal |
| **Account Setup** | Cloud services, accounts, and API keys needed before coding — summarize with cross-reference to ENVIRONMENTS.md for signup URLs, free tier limits, and detailed setup notes | Prevents "I can't start until I have X" blockers |
| **Phase Table** | Phase number, deliverable ID, description, dependencies, notes | The engineer's sequencing guide |
| **Exit Criteria per Phase** | Testable conditions per phase ("Auth working. Database accepting connections. PWA installable.") | The engineer knows when a phase is done |
| **Dependency Graph** | What blocks what, in text or diagram | Makes the build order obvious |
| **Time Estimates** | Rough order of magnitude per phase | Sets expectations and helps spot scope problems |
| **UI Design Approach** | Whether wireframes exist, what to reference for visual direction | Tells the engineer whether to design from tokens or follow mockups |
| **Corrections and Decisions** | Implementation dead ends, sequencing mistakes, and pivots with reasoning | Prevents the engineer from repeating the same build-order mistakes |
| **Environment Variable Management** | Where each var goes (frontend .env, backend secrets, agent env, etc.) — with cross-reference to ENVIRONMENTS.md for the full reference tables | Prevents "where does this key go?" confusion |

### Quality Checklist

- Every phase has exit criteria that are testable (not just "build the feature")
- Dependencies are explicit — the engineer shouldn't have to guess what to build first
- Account setup is complete enough that the engineer can create everything before writing code
- Time estimates are present even if rough — missing estimates hide scope problems
- Corrections and Decisions entries capture sequencing mistakes, failed approaches, and pivots so the engineer doesn't repeat them

---

## `docs/RESEARCH.md` — Competitive Research & Technology Evaluation

Background context that informs decisions but isn't prescriptive. The engineer reads this for understanding, not for implementation requirements.

### Required Sections

| Section | Must Contain | Why It Matters for Implementation |
|---------|-------------|-----------------------------------|
| **Target Feature Set** | Numbered features the product aims to deliver | Maps research to what we're actually building |
| **Platform / Competitor Profiles** | For each: name, status (active/defunct), users, monetization, relevance, 5 source articles | Proves we understand the landscape |
| **Key Findings** | Synthesized insight from the research | "X tried this and failed because Y" prevents repeating mistakes |
| **Gap Analysis** | Where our product fits that nothing else does | The unique value prop in research terms |
| **Technology Evaluations** (if applicable) | API/provider comparisons with cost, coverage, and recommendation | Informs architecture decisions in ARCHITECTURE.md |
| **Technology Evaluations** (if applicable) | API/provider comparisons with cost, coverage, and recommendation | Informs architecture decisions in ARCHITECTURE.md |
| **Corrections and Decisions** | Research dead ends, evaluated-and-rejected options, and changed assumptions | Prevents re-evaluating options that were already researched and dismissed |
| **Regulatory Considerations** | Relevant compliance, privacy laws, data handling requirements | Constraints the implementation must respect |

### Quality Checklist

- Each competitor has a viability assessment (active, defunct, uncertain)
- Key findings are synthesized insight, not just a list of facts
- Gap analysis clearly states what differentiates this product
- Technology evaluations (if present) have a clear recommendation
- Corrections and Decisions entries explain what was evaluated, why it was rejected, and what was chosen instead
- Regulatory considerations identify specific laws, not just general concern

---

## Loading Project Documents

When a skill needs to load project documents, it should:

1. **If `docs/ONBOARDING.md` exists, read it first.** It is the condensed entry point (~2-5K tokens) and provides enough context to decide which additional docs to read.
2. Run `ls docs/*.md` to discover all specification files
3. Read additional docs as needed for the specific task — not all docs are needed for every task
4. For project-specific files not listed in this standard, still read them; they contain critical context
5. If a required section (from the quality checklists above) is missing from a document, note it and inform the user

If `docs/ONBOARDING.md` does not exist, read all markdown files in `docs/` as before.

### Cross-Document Traceability

Requirements trace across documents:

```
PRD.md (functional requirement #5)
  → ARCHITECTURE.md (API endpoint, database table, data flow)
    → PLAN.md (phase deliverable, exit criteria)
      → Implementation (code, config, tests)
```

If a PRD requirement has no corresponding architecture section, the spec is incomplete. If an architecture section describes something not in the PRD, it may be out of scope. Flag both cases.