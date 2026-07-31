#!/usr/bin/env bash
# =============================================================================
# Lab 5 - Clean Up and Push Back to Remote
# =============================================================================

cd GitDemo || exit 1

# 1. Confirm clean state
git status

# 2. List branches
git branch -a

# 3. Sync down any remote-only changes
git pull origin master

# 4. Push all pending local commits
git push origin master

# 5. Confirm local and remote match
git log origin/master --oneline
git log master --oneline
