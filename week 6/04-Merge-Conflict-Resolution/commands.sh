#!/usr/bin/env bash
# =============================================================================
# Lab 4 - Resolving Merge Conflicts
# =============================================================================

cd GitDemo || exit 1

# 1. Confirm clean master
git status
git checkout master

# 2. Branch + first version of hello.xml
git branch GitWork
git checkout GitWork
cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from the branch!</message>
</greeting>
EOF
git add hello.xml
git commit -m "Add hello.xml on GitWork"

# 3-4. Update + commit on the branch
cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from the branch! Updated once more.</message>
    <author>GitWork</author>
</greeting>
EOF
git status
git add hello.xml
git commit -m "Update hello.xml content on GitWork"

# 5-7. Conflicting version on master
git checkout master
cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from master - completely different wording!</message>
    <owner>master</owner>
</greeting>
EOF
git add hello.xml
git commit -m "Add hello.xml on master with different content"

# 8-10. Inspect divergence
git log --oneline --graph --decorate --all
git diff master GitWork -- hello.xml
# git difftool -t p4merge master GitWork -- hello.xml

# 11-12. Merge (will conflict) + inspect markers
git merge GitWork
cat hello.xml

# 13. Resolve (uncomment if P4Merge is configured)
# git mergetool -t p4merge
# Otherwise, hand-edit hello.xml to remove conflict markers, then:

# 14. Commit the resolution
git add hello.xml
git commit -m "Merge GitWork into master, resolving hello.xml conflict"

# 15-16. Ignore mergetool backup files
git status
echo "*.orig" >> .gitignore
git add .gitignore
git commit -m "Ignore merge tool backup files (*.orig)"

# 17-19. Clean up
git branch -a
git branch -d GitWork
git log --oneline --graph --decorate
