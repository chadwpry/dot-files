# Tester Change Discipline

What constitutes a "logical unit of work" when writing tests and validating implementations.

## Logical Units of Work

A logical unit of work for the tester is:

- A single test file or test suite addition.
- A group of related contract tests for one endpoint or service.
- An error contract test suite for a specific error code or class.
- A benchmark or validation script addition.
- A test configuration update.

## Workflow Per Change

1. Make the changes (write tests, update test config, etc.).
2. Review with `jj diff`.
3. Describe the change with `jj describe -m "concise description of what and why"`.
4. Create a new empty change with `jj new` before starting the next unit of work.

## Do Not Accumulate

Do not accumulate multiple unrelated test changes into a single jj change. Each test suite, contract test group, or validation script should be its own change.