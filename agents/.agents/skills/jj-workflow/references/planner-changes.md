# Planner Change Discipline

What constitutes a "logical unit of work" when creating and editing specification documents.

## Logical Units of Work

A logical unit of work for the planner is:

- Creating a new specification document (e.g., adding `docs/RESEARCH.md`).
- A meaningful update to a single document section (e.g., defining the database schema in `docs/ARCHITECTURE.md`).
- Resolving a conflict between documents.
- Adding a Corrections and Decisions entry.

## Workflow Per Change

1. Describe the intent first: `jj describe -m "concise description of the planned change and why"`.
2. Create or edit `docs/` files.
3. Review with `jj diff` to confirm the change matches the description.
4. Advance: `jj new`.

## Cross-Document Consistency

When updating one document, check whether other documents need corresponding updates. Do not batch unrelated document edits into a single jj change — each meaningful update should be its own change.

## Repository Initialization

Before planning any new project:

1. Confirm the `jj` binary is installed and available on `PATH`.
2. If `jj` is not installed, inform the user that `jj` is required before planning can begin.
3. Halt planning work and wait for the user to install `jj`. Do not attempt to install `jj` on the user's behalf.
4. Ensure the project has a version-controlled repository managed by Jujutsu (`jj`).
5. If no repository exists yet, initialize one with `jj` before proceeding with the plan.
6. Before making any repository file changes, run `jj describe -m "concise description of the planned change and why"`.

Treat this as a hard prerequisite for all new project planning.