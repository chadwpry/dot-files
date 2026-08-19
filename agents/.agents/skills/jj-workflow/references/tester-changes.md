# Tester Change Scope

Use this guidance to determine whether test work fits the user-prepared active jj change. It does not authorize the tester to create, select, describe, advance, or rewrite changes.

## Logical Units of Work

A logical unit of test work may be:

- A single test file or test suite addition.
- A group of related contract tests for one endpoint or service.
- An error-contract test suite for a specific error code or class.
- A benchmark or validation script addition.
- A test configuration update.

## Working in the Active Change

1. Inspect `jj st` and `jj log`.
2. Confirm the user-selected change's description covers the test work.
3. Make test edits only within that change.
4. Review with `jj diff`.

If the work does not fit the active change, stop and ask the user to create or select an appropriate change. Do not run `jj init`, `jj new`, `jj describe`, `jj edit`, or `jj squash`.