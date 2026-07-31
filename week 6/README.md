# Week 6 - Git Hands-On Labs

Solutions to the 5 Git HOL exercises, all built around a single running
example repository called **GitDemo**. Each lab picks up where the
previous one left off, so they're numbered and meant to be worked through
in order.

## Folder structure
```
week 6/
├── README.md
├── 01-Git-Setup-And-First-Commit/   # git config, Notepad++ as editor, init, add, commit, push
├── 02-GitIgnore/                    # .gitignore for *.log files and a logs/ folder
├── 03-Branching-and-Merging/        # feature branch -> fast-forward merge -> cleanup
├── 04-Merge-Conflict-Resolution/    # deliberate conflict + 3-way merge resolution
└── 05-Cleanup-and-Push/             # final pull/push sync with the remote
```

Each folder contains:
- `README.md` - a full step-by-step walkthrough with every command and
  what to expect from it.
- `commands.sh` - the same commands as a single reference script (meant
  to be read and run a few lines at a time in Git Bash, not executed
  blindly top to bottom).
- Any sample files the lab creates (`welcome.txt`, `.gitignore`, etc.).

## How to use this
These labs are meant to be *performed*, not just read - the actual
deliverable is your own local `GitDemo` repository and its commit
history on GitHub/GitLab, built by running the commands in each
`README.md` yourself. This `week 6` folder is your reference/documentation
of that process, not a substitute for doing it.

## Prerequisites
- Git Bash (or any Git CLI) installed.
- A personal GitHub or GitLab account (not your Cognizant credentials).
- Notepad++ installed, for Lab 1's editor integration.
- P4Merge installed, for the visual diff/merge steps in Labs 3 and 4
  (optional - the command-line `git diff` / `git mergetool` steps work
  without it too).

## Lab summary
| Lab | Topic |
|---|---|
| 1 | Git config, Notepad++ integration, first commit + push |
| 2 | `.gitignore` for log files and folders |
| 3 | Creating a branch, committing on it, fast-forward merge, branch cleanup |
| 4 | Deliberate merge conflict + resolving it with a 3-way merge |
| 5 | Final `pull`/`push` to sync everything with the remote |
