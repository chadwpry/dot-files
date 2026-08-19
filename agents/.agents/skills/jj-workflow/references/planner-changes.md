# Planner Change Scope

Use this guidance to determine whether planning work fits the user-prepared active jj change. It does not authorize the planner to create, select, describe, advance, or rewrite changes.

## Logical Units of Work

A logical unit of planning work may be:

- Creating a new specification document (for example, `docs/RESEARCH.md`).
- A meaningful update to a single document section (for example, a database schema in `docs/ARCHITECTURE.md`).
- Resolving a conflict between documents.
- Adding a Corrections and Decisions entry.

## Working in the Active Change

1. Inspect `jj st` and `jj log`.
2. Confirm the user-selected change's description covers the planned work.
3. Create or edit `docs/` files only within that change.
4. Review with `jj diff`.

If the work does not fit the active change, stop and ask the user to create or select an appropriate change. Do not run `jj init`, `jj new`, `jj describe`, `jj edit`, or `jj squash`.

## Cross-Document Consistency

When updating one document, check whether other documents need corresponding updates. If the resulting work exceeds the active change's scope, ask the user to manage the change boundary.

## Repository Prerequisite

The user must provide a jj-managed repository and a suitable active change before planning begins. Do not initialize a repository.