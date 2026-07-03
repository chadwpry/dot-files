# History Rewriting

For operations that rewrite repository history — such as removing a file from all commits, purging secrets, or rewriting author information — use native `git` commands. `jj` does not currently have a direct equivalent for these operations.

## Removing a File from All History

To completely remove a file AND its history from the repository, use `git filter-branch` (a built-in git command, requires no additional packages):

```bash
# Remove a file from all commits, across all branches
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch <path-to-file>' \
  --prune-empty --tag-name-filter cat -- --all
```

After running `filter-branch`:

1. Clean up the backup refs and expired objects:
   ```bash
   rm -rf .git/refs/original/
   git reflog expire --expire=now --all
   git gc --prune=now --aggressive
   ```
2. Force push to overwrite the remote history:
   ```bash
   git push origin --force --all
   git push origin --force --tags
   ```

## Important Rules

- **Never install Python packages** (like `git-filter-repo`) for history rewriting. Always use native `git` commands (`git filter-branch`) which require no additional dependencies.
- **Never install `pip`, `pip3`, or any Python package manager** to accomplish git operations. The `git` binary already provides `filter-branch` for this purpose.
- After rewriting history, always force push all branches and tags to the remote.
- Warn the user that force pushing rewrites remote history — anyone who has cloned the repo will need to re-clone or reset their local copy.
- If using `jj`, remember that `jj git push` handles force pushing. After a `git filter-branch`, you may need to use raw `git push --force` since `jj`'s view of the repo may be out of sync with the rewritten history.

## Other History Rewriting Operations

| Task | Command |
|------|---------|
| Remove a file from all history | `git filter-branch --index-filter 'git rm --cached --ignore-unmatch <file>' -- --all` |
| Change author email across all commits | `git filter-branch --env-filter 'export GIT_AUTHOR_EMAIL="new@email.com"; export GIT_COMMITTER_EMAIL="new@email.com"' -- --all` |
| Remove empty commits left behind | `git filter-branch --prune-empty -- --all` |

## Cleanup After filter-branch

`git filter-branch` creates backup refs under `refs/original/`. These must be removed before garbage collection will actually free the space:

```bash
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

This ensures the removed file's content is truly purged from the object store.

## Reinitializing jj After History Rewriting

`git filter-branch` rewrites commit hashes, which invalidates jj's internal state. After running `filter-branch` and the cleanup commands above, jj must be reinitialized:

```bash
# Remove jj's state (it references old, now-nonexistent commit hashes)
rm -rf .jj/

# Reinitialize jj against the current git repo
jj git init --git-repo=.

# Re-track remote bookmarks
jj bookmark track main --remote=origin
# Repeat for each remote bookmark as needed
```

**Failure to reinitialize jj after `git filter-branch` will cause `jj st`, `jj log`, and all other jj commands to fail with "object not found" errors.** This is because jj's operation log and working copy state reference commit IDs that no longer exist after the rewrite.