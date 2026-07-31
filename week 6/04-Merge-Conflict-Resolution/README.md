# Lab 4 - Resolving Merge Conflicts

**Objective:** Deliberately create a merge conflict by editing the same
file differently on two branches, then resolve it with a 3-way merge.

Estimated time: ~30 minutes.

---

## 1. Confirm master is clean

```bash
cd GitDemo
git status
git checkout master
```

## 2. Create a branch and add `hello.xml`

```bash
git branch GitWork
git checkout GitWork

cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from the branch!</message>
</greeting>
EOF

git add hello.xml
git commit -m "Add hello.xml on GitWork"
```

## 3. Update `hello.xml` on the branch and observe status

```bash
cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from the branch! Updated once more.</message>
    <author>GitWork</author>
</greeting>
EOF

git status
```

## 4. Commit that change

```bash
git add hello.xml
git commit -m "Update hello.xml content on GitWork"
```

## 5. Switch to master

```bash
git checkout master
```

## 6. Add a *conflicting* version of `hello.xml` to master

```bash
cat > hello.xml << 'EOF'
<greeting>
    <message>Hello from master - completely different wording!</message>
    <owner>master</owner>
</greeting>
EOF
```

## 7. Commit it on master

```bash
git add hello.xml
git commit -m "Add hello.xml on master with different content"
```

## 8. Observe the diverged history

```bash
git log --oneline --graph --decorate --all
```

You should see two separate lines of commits after the point where
`GitWork` branched off - `master` and `GitWork` have each added their own
version of `hello.xml`, so their histories have diverged.

## 9. Check differences with Git's diff tool

```bash
git diff master GitWork -- hello.xml
```

## 10. Visualize with P4Merge

```bash
git difftool -t p4merge master GitWork -- hello.xml
```

## 11. Merge the branch into master

```bash
git merge GitWork
```

Because both branches touched the same lines of `hello.xml`, Git can't
auto-merge and reports a conflict:
```
Auto-merging hello.xml
CONFLICT (content): Merge conflict in hello.xml
Automatic merge failed; fix conflicts and then commit the result.
```

## 12. Observe the conflict markers

```bash
cat hello.xml
```

Git inserts markers directly into the file:
```
<<<<<<< HEAD
<owner>master</owner>
=======
<author>GitWork</author>
>>>>>>> GitWork
```
Everything between `<<<<<<< HEAD` and `=======` is master's version;
everything between `=======` and `>>>>>>> GitWork` is the branch's version.

## 13. Resolve with a 3-way merge tool

```bash
git mergetool -t p4merge
```

P4Merge opens three panes - master's version (left), the branch's
version (right), and the merged result (center) - drag/accept the pieces
you want into the center pane, save, and close the tool.

If resolving by hand instead, edit `hello.xml` directly, remove all the
`<<<<<<<` / `=======` / `>>>>>>>` markers, and keep the combined content
you actually want, e.g.:
```xml
<greeting>
    <message>Hello from master - completely different wording!</message>
    <owner>master</owner>
    <author>GitWork</author>
</greeting>
```

## 14. Commit the resolved merge

```bash
git add hello.xml
git commit -m "Merge GitWork into master, resolving hello.xml conflict"
```

## 15. Check status and add the mergetool backup file to `.gitignore`

P4Merge (and most merge tools) leave a `hello.xml.orig` backup file
behind after resolving.

```bash
git status
echo "*.orig" >> .gitignore
```

## 16. Commit the `.gitignore` update

```bash
git add .gitignore
git commit -m "Ignore merge tool backup files (*.orig)"
```

## 17. List all available branches

```bash
git branch -a
```

## 18. Delete the merged branch

```bash
git branch -d GitWork
```

## 19. Observe the final log

```bash
git log --oneline --graph --decorate
```

The graph now shows the two divergent lines rejoining at the merge
commit you created in step 14.

## Expected outcome
- `hello.xml` on `master` contains the combined content from both branches.
- `*.orig` backup files are ignored going forward.
- `GitWork` no longer appears in the branch list.
- The commit graph clearly shows a merge commit joining two diverged lines.
