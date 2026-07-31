# Lab 2 - Ignoring Files with `.gitignore`

**Objective:** Create a `.log` file and a `log/` folder inside the
`GitDemo` working directory, then configure `.gitignore` so Git ignores
both, and confirm via `git status`.

Estimated time: ~20 minutes.

---

## Step 1: Create the files/folders that should be ignored

```bash
cd GitDemo

# A stray log file at the repo root
echo "Application started at 09:00" > app.log

# A folder full of log files
mkdir logs
echo "Debug trace line 1" > logs/debug.log
echo "Error trace line 1" > logs/error.log
```

Before adding a `.gitignore`, `git status` will list all three as
untracked - that's the "problem" this lab solves.

```bash
git status
```

## Step 2: Create/update `.gitignore`

```bash
# Ignore every file ending in .log, anywhere in the repo
echo "*.log" >> .gitignore

# Ignore the whole logs/ folder (trailing slash = directory only)
echo "logs/" >> .gitignore

cat .gitignore
```

## Step 3: Verify Git now ignores them

```bash
git status
```

`app.log` and the `logs/` folder should no longer show up as untracked -
only `.gitignore` itself appears as a new/untracked file, since it hasn't
been committed yet.

```bash
git add .gitignore
git commit -m "Add .gitignore to exclude log files and the logs folder"
git status
```

## Step 4: Confirm ignored files stay ignored even if you try to add them

```bash
git add app.log
# -> "The following paths are ignored by one of your .gitignore files: app.log"

git add logs/
# -> same "ignored" message, or silently does nothing depending on Git version
```

If you ever *do* need to force-add something Git is ignoring (rare, but
useful to know): `git add -f app.log`.

## Expected outcome
- `git status` shows a clean working tree aside from the committed
  `.gitignore` - `app.log` and everything under `logs/` are invisible to
  Git, both locally and once pushed to the remote.
