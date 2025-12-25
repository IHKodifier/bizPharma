# Git Workflow Guide: avoiding "Diverged Branches"

**Date**: 2025-12-25
**Context**: bizPharma Project

This guide explains why branches diverge and outlines the recommended workflow for our project to keep history clean and deployments safe.

---

## 1. The "Diverged" Problem Explained

**Scenario**: You try to push or merge, and Git says *"Your branch and 'origin/dev' have diverged"*.

**Why it happens**:
This means **two different things happened at the same time** to the same branch:
1.  **Remote**: Someone (or you from another machine/PR) pushed a commit to `origin/dev`.
2.  **Local**: You made a *different* commit locally on `dev`.

Git sees two timeline splits. It refuses to "fast-forward" because it doesn't know which timeline is correct.

**The Fix (The Golden Rule)**:
Always **Rebase** before you push.
```bash
# Before pushing your local changes:
git pull origin dev --rebase
```
*   **What this does**: It takes your local commits, temporarily puts them aside, pulls down the new stuff from `origin`, and then "replays" your work on top.
*   **Result**: A straight line history. No divergence.

---

## 2. Recommended Strategy for bizPharma

Given your setup (`dev` acts as Staging), we recommend **Simplified Gitflow**.

### The Branches
1.  **`main` (Production)**
    *   **Rule**: deeply stable. NOTHING goes here unless it works on Staging first.
    *   **Updates**: Only via Pull Request (PR) or Merge from `dev`.
2.  **`dev` (Staging/Integration)**
    *   **Rule**: This is your "Default" branch. It represents the Staging Environment.
    *   **Updates**: Feature branches merge into here.
3.  **`feature/xyz` (Development)**
    *   **Rule**: Create a new branch for every task.
    *   **Lifecycle**: checkout from `dev` -> code -> merge back to `dev` -> delete.

### Visual Workflow

```mermaid
graph LR
    A[Main (Prod)] --> B[Dev (Staging)]
    B --> C[Feature A]
    B --> D[Feature B]
    C -- Merge --> B
    D -- Merge --> B
    B -- Release --> A
```

---

## 3. How to Release to Production (Safe Merge)

Since you are currently verified on `dev` (Staging) and want to go to `main` (Production), follow this **Safe Merge Protocol**:

### Step 1: Ensure Local Dev is clean and updated
```bash
git checkout dev
git pull origin dev --rebase  # Ensure you possess the latest Staging code
```

### Step 2: Merge into Main
```bash
git checkout main
git pull origin main --rebase # Ensure local main isn't stale
git merge dev                 # Merge Staging into Production
```

### Step 3: Push
```bash
git push origin main
```
*   This triggers the **Production Deployment** pipeline.

---

## 4. Specific Scenarios

### Q: "Should I merge dev into main now?"
**A: YES.**
Your `dev` branch currently contains:
1.  Multi-environment config fixes.
2.  Backend crash fixes.
3.  Data Connect infrastructure code.
All verified. `main` does not have these. To make Production work, `main` MUST have these.

### Q: "How to avoid divergence in Feature Branches?"
1.  Start clean: `git checkout dev` -> `git pull` -> `git checkout -b feature/new-login`.
2.  Work, commit, work.
3.  Before merging back:
    ```bash
    git checkout dev
    git pull       # Get updates from others
    git checkout feature/new-login
    git rebase dev # Replay your work on top of latest dev
    ```
4.  Now merge.

---

## Summary
*   No need for a separate `staging` branch if `dev` *is* Staging.
*   **Rebase** is your friend to cure divergence.
*   **Merge `dev` -> `main`** whenever Staging is verified and you are ready to ship.
