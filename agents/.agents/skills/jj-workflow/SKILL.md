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
4. A repository and an active, appropriately described jj change must already be prepared by the user.

No skill should proceed with file changes when `jj` is unavailable, no repository exists, or the user has not prepared a suitable active change.

## jj Overview

- **Repository:** <https://github.com/jj-vcs/jj>
- **Tutorial and reference:** <https://steveklabnik.github.io/jujutsu-tutorial/>
- **Local man pages:** Run `jj help <command>` or `man jj-<command>` for detailed usage of any subcommand.

Use `jj` for all version control workflows. Do not use raw `git` commands for day-to-day work.

## Quick Reference

Skills may inspect the active change with these read-only commands:

| Task | Command |
|---|---|
| View status | `jj st` |
| View log | `jj log` |
| View diff of current change | `jj diff` |
| View diff of specific revision | `jj diff -r <rev>` |

The following are **human-only** history-management commands: `jj describe`, `jj new`, `jj squash`, `jj edit`, `jj bookmark create`, `jj git push`, `jj git fetch`, `jj resolve`, and `jj undo`.

When unsure about a command, the user may consult `jj help <command>` locally or refer to the tutorial at <https://steveklabnik.github.io/jujutsu-tutorial/>.

## Change Discipline (Mandatory)

The human owns jj history. Before editing files, a skill must verify with `jj st` and `jj log` that the user has created and selected an active change whose description covers the work.

Skills must **not** run `jj init`, `jj new`, `jj describe`, `jj edit`, `jj squash`, or any other jj command that creates, selects, describes, advances, or rewrites a change. They must not create separate changes for logical units of work. If the active change is missing, unsuitable, or no longer covers the work, stop and ask the user to create or select the appropriate change.

Skills may use read-only commands such as `jj st`, `jj log`, and `jj diff` to inspect and review the active change. Make all file modifications within the user-prepared change.

## Version Control Workflow

1. **User prepares the change:** The user creates, selects, and describes the change.
2. **Skill fills the change:** The skill edits files only within that active change.
3. **Skill reviews:** Use `jj log` and `jj diff` to confirm the work matches the user-provided description.
4. **User manages history:** Only the user creates, advances, rewrites, bookmarks, or pushes changes.

## Human-Only Raw Git Operations

Most day-to-day version control is done with `jj`. A human may use raw `git` for history-rewriting operations that have no `jj` equivalent:

- **Removing a file from all history** — use `git filter-branch`, not Python packages like `git-filter-repo`
- **Purging secrets from history** — same `git filter-branch` approach
- **Rewriting author information across all commits** — `git filter-branch --env-filter`

**Never install Python packages (pip, pip3, git-filter-repo) to accomplish git operations.** The `git` binary provides `filter-branch` for all history rewriting. See `references/history-rewriting.md` for the full reference.

## Before Starting Work

Before making any file changes, every skill should:

1. Run `jj st` and `jj log` to understand the current state of the repository.
2. Confirm from `jj log` that the user-selected current change has an appropriate description; do not modify it.
3. If the repository or a suitable active change is absent, stop and ask the user to prepare it.

---

## Role-Specific Change References

The role-specific references define scope guidance for work that the user may choose to separate into changes. They do not authorize skills to create or manage jj changes:

| Reference | Role | Focus |
|-----------|------|-------|
| `references/developer-changes.md` | Software developer | Code, config, and infrastructure changes |
| `references/planner-changes.md` | Software planner | Document creation and editing |
| `references/tester-changes.md` | Software tester | Test writing and validation |
| `references/history-rewriting.md` | All roles | Purging files, rewriting authorship, force pushing |

Skills should load their role-specific reference alongside this skill to assess whether work fits the user-prepared active change.