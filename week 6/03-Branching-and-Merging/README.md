# Lab 3 - Branching and Merging

**Objective:** Create a branch, make changes on it, merge it back into
`master`, and clean up afterward - covering the everyday feature-branch
workflow.

Estimated time: ~30 minutes.

---

## Branching

### 1. Create a new branch

```bash
cd GitDemo
git branch GitNewBranch
```

### 2. List all local and remote branches

```bash
git branch -a
```

The branch with a `*` next to it is the one you currently have checked
out - right after `git branch GitNewBranch`, you're still on `master`,
so the `*` stays on `master` until you switch.

### 3. Switch to the new branch and add content

```bash
git checkout GitNewBranch
# (or the newer equivalent: git switch GitNewBranch)

echo "This feature was built on GitNewBranch." > feature.txt
git status
```

### 4. Commit the changes on the branch

```bash
git add feature.txt
git commit -m "Add feature.txt on GitNewBranch"
```

### 5. Check status

```bash
git status
git log --oneline
```

---

## Merging

### 1. Switch back to master

```bash
git checkout master
```

### 2. Diff master against the branch (command line)

```bash
git diff master GitNewBranch
```

### 3. Diff visually with P4Merge

```bash
git difftool -t p4merge master GitNewBranch
```

(Requires P4Merge installed and configured as a difftool - see the note
below if `git difftool` doesn't recognize `p4merge`.)

### 4. Merge the branch into master

```bash
git merge GitNewBranch
```

Since master hasn't diverged (no new commits on master since the branch
was created), this will be a **fast-forward merge** - master's pointer
just moves forward to the branch's latest commit, no merge commit needed.

### 5. Observe the log

```bash
git log --oneline --graph --decorate
```

### 6. Delete the now-merged branch

```bash
git branch -d GitNewBranch
git status
git branch -a
```

`-d` (lowercase) only deletes a branch if it's already fully merged - a
safety net against losing unmerged work. `GitNewBranch` should no longer
appear in the branch list.

---

## Note: configuring P4Merge as a Git difftool

If `git difftool -t p4merge` errors out, register it once:

```bash
git config --global diff.tool p4merge
git config --global difftool.p4merge.path "C:/Program Files/Perforce/p4merge.exe"
git config --global difftool.prompt false
```

## Expected outcome
- `feature.txt` exists on `master` after the merge.
- `git log --oneline --graph --decorate` shows a clean, linear history
  (fast-forward merge - no separate merge commit).
- `GitNewBranch` no longer appears in `git branch -a` after deletion.
