---
name: jj-workflow
description: >
  Defines the mandatory version control workflow, change discipline, and command
  reference for Jujutsu (jj). All skills that make file changes must follow this
  workflow. Load with /skill:jj-workflow when you need the command reference,
  change discipline rules, or version control workflow. Triggers: jj, version
  control, commit, change, describe, squash, bookmark.
---

# jj Workflow

Version control uses **jj** (Jujutsu), not raw git commands. This skill defines the command reference, mandatory change discipline, and version control workflow that all skills must follow when making file changes.

## jj Prerequisite

Before any skill can make file changes, these conditions must be met:

1. The `jj` binary must be installed and available on `PATH`.
2. If `jj` is not installed, inform the user that `jj` is required before work can begin.
3. Halt work and wait for the user to install `jj`. Do not attempt to install `jj` on the user's behalf.
4. If a new project has no repository, initialize one with `jj` before making any file changes.

No skill should proceed with file changes when `jj` is unavailable.

## jj Overview

- **Repository:** <https://github.com/jj-vcs/jj>
- **Tutorial and reference:** <https://steveklabnik.github.io/jujutsu-tutorial/>
- **Local man pages:** Run `jj help <command>` or `man jj-<command>` for detailed usage of any subcommand.

Use `jj` for all version control workflows. Do not use raw `git` commands for day-to-day work.

## Quick Reference

| Task | Command |
|---|---|
| View status | `jj st` |
| View log | `jj log` |
| Describe current change | `jj describe -m "message"` |
| Create a new change | `jj new` |
| View diff of current change | `jj diff` |
| View diff of specific revision | `jj diff -r <rev>` |
| Squash into parent | `jj squash` |
| Edit an earlier change | `jj edit <rev>` |
| Create a bookmark (named branch) | `jj bookmark create <name>` |
| Push to remote | `jj git push` |
| Fetch from remote | `jj git fetch` |
| Resolve conflicts | `jj resolve` |
| Undo last operation | `jj undo` |

When unsure about a command, consult `jj help <command>` locally or refer to the tutorial at <https://steveklabnik.github.io/jujutsu-tutorial/>.

## Change Discipline (Mandatory)

Every logical unit of work MUST be recorded as its own jj change. This is non-negotiable.

The workflow for every piece of work is:

1. **Describe first:** Run `jj describe -m "concise description of what you intend to do and why"` BEFORE making any file changes. This is mandatory for every change.
2. **Do the work:** Edit files, create files — all within the described change.
3. **Review:** Run `jj diff` to confirm the change matches the description.
4. **Advance:** Run `jj new` to create a new empty change before starting the next unit of work.

**Describe before you build. The description is the plan; the file changes are the execution.** This ensures that every change in the history has a meaningful description that was written with intent, not retrofitted after the fact.

**You must run `jj new` after each completed unit of work.** This ensures every logical change is a separate, reviewable node in the history. Do not accumulate multiple unrelated changes into a single jj change.

What constitutes a "logical unit of work" depends on the role. See the role-specific references:

- **Developer:** `jj-workflow/references/developer-changes.md`
- **Planner:** `jj-workflow/references/planner-changes.md`
- **Tester:** `jj-workflow/references/tester-changes.md`

## Version Control Workflow

1. **Describe-first changes:** Every change starts with `jj describe` declaring intent, then the work happens inside that change.
2. **Atomic changes:** Each logical unit of work is a separate jj change.
3. **Review before sharing:** Use `jj log` and `jj diff` to review changes before pushing.
4. **Squash workflow:** Use `jj squash` to fold work-in-progress into a clean parent change when ready.
5. **Bookmarks for sharing:** When pushing to a remote or creating a pull request, create a bookmark with `jj bookmark create <name>` and push with `jj git push`.

## When to Use Raw Git Instead of jj

Most day-to-day version control is done with `jj`. However, certain history-rewriting operations have no `jj` equivalent and require raw `git` commands:

- **Removing a file from all history** — use `git filter-branch`, not Python packages like `git-filter-repo`
- **Purging secrets from history** — same `git filter-branch` approach
- **Rewriting author information across all commits** — `git filter-branch --env-filter`

**Never install Python packages (pip, pip3, git-filter-repo) to accomplish git operations.** The `git` binary provides `filter-branch` for all history rewriting. See `references/history-rewriting.md` for the full reference.

## Before Starting Work

Before making any file changes, every skill should:

1. Run `jj st` and `jj log` to understand the current state of the repository.
2. Confirm the current change has a description via `jj describe` before editing any files.
3. If starting a new project with no repository, initialize one with `jj`.

---

## Role-Specific Change References

Each role has its own definition of what constitutes a logical unit of work and any role-specific jj procedures. These are defined in the references directory:

| Reference | Role | Focus |
|-----------|------|-------|
| `references/developer-changes.md` | Software developer | Code, config, and infrastructure changes |
| `references/planner-changes.md` | Software planner | Document creation and editing |
| `references/tester-changes.md` | Software tester | Test writing and validation |
| `references/history-rewriting.md` | All roles | Purging files, rewriting authorship, force pushing |

Skills should load their role-specific reference alongside this skill to understand what counts as a change in their domain.