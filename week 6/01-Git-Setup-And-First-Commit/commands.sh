#!/usr/bin/env bash
# =============================================================================
# Lab 1 - Git Configuration & First Commit
# Reference script - run these commands one at a time in Git Bash so you can
# read each result, rather than piping the whole file through blindly.
# =============================================================================

# --- Step 1: verify install + set identity ---
git --version
git config --global user.name "Arav Kumar"
git config --global user.email "your-email@example.com"
git config --global --list

# --- Step 2: Notepad++ as default editor (Windows/Git Bash only) ---
notepad++ || echo "notepad++ not on PATH yet - add it via Environment Variables first"
echo "alias notepad='notepad++'" >> ~/.bashrc
source ~/.bashrc
git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
git config --global -e

# --- Step 3: create repo + first file ---
mkdir -p GitDemo
cd GitDemo || exit 1
git init
ls -la
echo "Welcome to my first Git repository!" > welcome.txt
ls -la
cat welcome.txt
git status
git add welcome.txt
git commit -m "Add welcome.txt with initial greeting"
git status
git log --oneline

# --- Step 4: connect remote + sync ---
# Replace <your-username> with your actual GitHub/GitLab username first.
# git remote add origin https://github.com/<your-username>/GitDemo.git
# git pull origin master --allow-unrelated-histories
# git push origin master
