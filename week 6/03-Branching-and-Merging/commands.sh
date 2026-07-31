#!/usr/bin/env bash
# =============================================================================
# Lab 3 - Branching and Merging
# =============================================================================

cd GitDemo || exit 1

# --- Branching ---
git branch GitNewBranch
git branch -a

git checkout GitNewBranch
echo "This feature was built on GitNewBranch." > feature.txt
git status

git add feature.txt
git commit -m "Add feature.txt on GitNewBranch"
git status
git log --oneline

# --- Merging ---
git checkout master

git diff master GitNewBranch

# Requires P4Merge configured as a difftool (see README for setup)
# git difftool -t p4merge master GitNewBranch

git merge GitNewBranch
git log --oneline --graph --decorate

git branch -d GitNewBranch
git status
git branch -a
