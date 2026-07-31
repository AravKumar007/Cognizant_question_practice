# Lab 1 - Git Configuration & First Commit

**Objective:** Configure Git on a fresh machine, set Notepad++ as the
default commit-message editor, and create/commit/push the first file to
a new repository called `GitDemo`.

Estimated time: ~30 minutes.

---

## Step 1: Verify Git is installed and set user-level config

```bash
# Confirm Git Bash / Git client is installed
git --version

# Set your identity - Git stamps every commit with this
git config --global user.name "Arav Kumar"
git config --global user.email "your-email@example.com"

# Confirm the config took effect
git config --global --list
```

`git config --global user.name` and `user.email` are what get attached to
every commit you make from this machine, across all repos - not just this
one. Use a personal email, not a work/Cognizant one, when following the
lab's GitHub account instructions.

## Step 2: Make Notepad++ the default Git editor

Git opens an external editor whenever it needs a multi-line message (e.g.
`git commit` with no `-m`, or an interactive rebase). By default that's
Vim, which trips a lot of people up on Windows - Notepad++ is a friendlier
swap.

```bash
# Sanity check - can Git Bash see notepad++ on PATH at all?
notepad++
```

If that fails, Notepad++'s install folder isn't on the Windows PATH yet:
**Control Panel → System → Advanced system settings → Environment
Variables → Path → Edit → Add** the Notepad++ install directory (typically
`C:\Program Files\Notepad++`).

Once it's added, close and reopen Git Bash, then:

```bash
# Create a bash alias so `notepad` launches Notepad++
echo "alias notepad='notepad++'" >> ~/.bashrc
source ~/.bashrc

# Point Git at Notepad++ as the default editor
git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

# Confirm it stuck
git config --global -e
```

`-e` opens the config file in whatever editor is configured - if Notepad++
pops up, the setting worked.

## Step 3: Create the GitDemo repository and add a file

```bash
# Create and enter the project folder
mkdir GitDemo
cd GitDemo

# Turn it into a Git repository
git init

# Confirm - a hidden .git folder should now exist
ls -la

# Create a file with some content
echo "Welcome to my first Git repository!" > welcome.txt

# Confirm the file exists and check its contents
ls -la
cat welcome.txt

# Git sees it as untracked so far
git status

# Stage it so Git starts tracking it
git add welcome.txt

# Commit with a multi-line message via the configured editor
git commit
# Notepad++ opens - type a summary line, a blank line, then details, save & close.

# Confirm the working directory is clean and the commit is recorded
git status
git log --oneline
```

## Step 4: Connect to a remote and push

```bash
# Create an empty "GitDemo" repository on GitHub/GitLab first (via the
# website), then link this local repo to it:
git remote add origin https://github.com/<your-username>/GitDemo.git

# Pull first in case the remote has an initial README/license commit
git pull origin master --allow-unrelated-histories

# Push the local commit(s) up
git push origin master
```

If your default branch is `main` instead of `master` (GitHub's current
default), swap `master` for `main` in both commands above.

## Expected outcome
- `welcome.txt` exists locally and is committed.
- `git status` reports "nothing to commit, working tree clean".
- The commit is visible on the remote repository's web page after `git push`.
