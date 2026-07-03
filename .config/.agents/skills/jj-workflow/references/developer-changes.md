# Developer Change Discipline

What constitutes a "logical unit of work" when writing code, configuration, and infrastructure.

## Logical Units of Work

A logical unit of work for the developer is:

- A single file or closely related group of files serving one purpose (e.g., a Dockerfile, a config file and its companion .env.example).
- A single feature, fix, or refactor that can be described in one sentence.
- A test file or test suite addition.
- A documentation update.

## Change Size Guidance

- Prefer small, focused changes — typically 1-3 files and under ~200 lines of diff.
- If a change is growing larger, stop and split it into smaller logical units.
- A good change can be reviewed in isolation and understood without scrolling through unrelated context.
- When in doubt, err on the side of smaller. Two small changes are better than one sprawling change.

## What Does NOT Belong in a Single Change

- Unrelated files grouped together for convenience.
- "WIP" dumps of partial progress across multiple features.
- Mixing implementation work with test work with documentation work unless they are inseparable.
- Changes large enough that the description needs more than one or two sentences to explain.

## Workflow Per Change

1. Describe the intent first: `jj describe -m "what this change does and why"`.
2. Do the work (edit/create files).
3. Review with `jj diff` to confirm the work matches the description.
4. Advance: `jj new`.