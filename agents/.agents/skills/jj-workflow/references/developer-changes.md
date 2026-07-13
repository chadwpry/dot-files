# Developer Change Scope

Use this guidance to determine whether development work fits the user-prepared active jj change. It does not authorize the developer to create, select, describe, advance, or rewrite changes.

## Logical Units of Work

A logical unit of development work may be:

- A single file or closely related group of files serving one purpose (for example, a Dockerfile and its companion `.env.example`).
- A single feature, fix, or refactor that can be described in one sentence.
- A test file or test suite addition.
- A documentation update.

## Scope Guidance

- Prefer focused work—typically 1–3 files and under roughly 200 changed lines.
- Avoid unrelated files, WIP across multiple features, and separable implementation, test, and documentation work in the same change.
- If the work exceeds the user-prepared change's scope, stop and ask the user to create or select another change.

## Working in the Active Change

1. Inspect `jj st` and `jj log`.
2. Confirm the user-selected change's description covers the work.
3. Edit or create files only within that change.
4. Review with `jj diff`.

Do not run `jj init`, `jj new`, `jj describe`, `jj edit`, or `jj squash`.