#!/usr/bin/env bash
# =============================================================================
# Lab 2 - Ignoring Files with .gitignore
# =============================================================================

cd GitDemo || exit 1

# Step 1: create files/folders that should be ignored
echo "Application started at 09:00" > app.log
mkdir -p logs
echo "Debug trace line 1" > logs/debug.log
echo "Error trace line 1" > logs/error.log
git status

# Step 2: create .gitignore
echo "*.log" >> .gitignore
echo "logs/" >> .gitignore
cat .gitignore

# Step 3: verify + commit
git status
git add .gitignore
git commit -m "Add .gitignore to exclude log files and the logs folder"
git status

# Step 4: confirm ignored files can't be accidentally added
git add app.log
git add logs/
