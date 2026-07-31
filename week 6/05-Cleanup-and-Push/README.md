# Lab 5 - Clean Up and Push Back to Remote

**Objective:** Wrap up the previous labs by confirming a clean local
state, syncing with the remote, and pushing any outstanding commits.

Estimated time: ~10 minutes.

---

## 1. Verify master is clean

```bash
cd GitDemo
git status
```

Expect: `On branch master, nothing to commit, working tree clean` -
everything from Labs 3 and 4 (the merge, the conflict resolution, the
`.gitignore` update) should already be committed locally.

## 2. List all available branches

```bash
git branch -a
```

By this point, `GitNewBranch` and `GitWork` should both be gone (deleted
after merging in Labs 3 and 4) - only `master` (and its remote-tracking
counterpart, if the remote is already linked) should remain.

## 3. Pull the remote repository into master

```bash
git pull origin master
```

This fetches and merges any commits that exist on the remote but not
locally - important if you ever made a change directly on GitHub/GitLab
(e.g. edited the README in the browser) during the earlier labs.

## 4. Push all pending commits from Labs 3 & 4 to the remote

```bash
git push origin master
```

This uploads everything committed locally since the last push - the
branch merge from Lab 3, and the conflict-resolution commits plus the
`.gitignore` update from Lab 4.

## 5. Confirm the changes landed on the remote

```bash
# Compare local and remote history
git log origin/master --oneline
git log master --oneline
```

Both should show the exact same commit hashes at the top. You can also
just open the repository on GitHub/GitLab in a browser and confirm
`feature.txt`, `hello.xml`, and the updated `.gitignore` are all visible
in the file listing, with the expected commit messages in the history tab.

## Expected outcome
- `git status` on `master` reports a clean working tree both before and
  after the pull/push.
- `git log master --oneline` and `git log origin/master --oneline` match
  exactly - local and remote are in sync.
- All files created across Labs 1-4 (`welcome.txt`, `.gitignore`,
  `feature.txt`, `hello.xml`) are visible in the remote repository.
