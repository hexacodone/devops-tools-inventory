# Git Cheat Sheet for DevOps - Comprehensive Reference

> A complete Git reference for DevOps beginners and advanced users

## 📋 Table of Contents

1. [Git Basics](#git-basics)
2. [Repository Setup](#repository-setup)
3. [Branching & Merging](#branching--merging)
4. [Remote Repositories](#remote-repositories)
5. [Staging & Commits](#staging--commits)
6. [History & Logs](#history--logs)
7. [Undoing Changes](#undoing-changes)
8. [Stashing](#stashing)
9. [Tags & Releases](#tags--releases)
10. [Conflict Resolution](#conflict-resolution)
11. [Git Workflows](#git-workflows)
12. [Advanced Commands](#advanced-commands)
13. [Git Configuration](#git-configuration)
14. [Troubleshooting](#troubleshooting)

---

## Git Basics

### What is Git?
Git is a **distributed version control system** that tracks changes to files over time. Every developer has a complete copy of the entire project history.

### The three areas in Git
```
Working Directory → Staging Area → Repository
     (Workspace)      (Index)       (HEAD)
```

- **Working Directory**: Your current files
- **Staging Area**: Preparation area for the next commit
- **Repository**: Stored versions (commits)

---

## Repository Setup

### Create a new repository
```bash
# Initialize a new repository
git init

# Create a repository with an initial commit
git init
git add .
git commit -m "Initial commit"
```

### Clone an existing repository
```bash
# Clone a repository
git clone <repository-url>

# Clone into a specific folder name
git clone <repository-url> <folder-name>

# Clone only the main/master branch
git clone --single-branch --branch main <repository-url>
```

### Check repository status
```bash
# Show current status
git status

# Compact status display
git status -s

# Also show ignored files
git status --ignored
```

---

## Branching & Merging

### Branch basics
```bash
# Show all branches
git branch

# Also show remote branches
git branch -a

# Create a new branch
git branch <branch-name>

# Create a branch and switch to it directly
git checkout -b <branch-name>
# Or with the newer command:
git switch -c <branch-name>
```

### Branch navigation
```bash
# Switch to a branch
git checkout <branch-name>
# Or:
git switch <branch-name>

# Switch to the previous branch
git checkout -
git switch -

# Rename a branch
git branch -m <old-name> <new-name>
git branch -m <new-name>  # Rename the current branch
```

### Merging
```bash
# Merge a branch into the current branch
git merge <branch-name>

# Merge without fast-forward (always creates a merge commit)
git merge --no-ff <branch-name>

# Abort a merge (on conflicts)
git merge --abort
```

### Deleting a branch
```bash
# Delete a branch (only if merged)
git branch -d <branch-name>

# Force-delete a branch
git branch -D <branch-name>

# Delete a remote branch
git push origin --delete <branch-name>
```

---

## Remote Repositories

### Managing remote connections
```bash
# Show remote repositories
git remote -v

# Add a remote repository
git remote add <name> <url>
git remote add origin https://github.com/user/repo.git

# Change the remote URL
git remote set-url origin <new-url>

# Remove a remote
git remote remove <name>
```

### Push & Pull
```bash
# Upload changes
git push origin <branch-name>

# First push, setting the upstream
git push -u origin <branch-name>

# Push all branches
git push --all

# Push tags as well
git push --tags
```

```bash
# Download and merge changes
git pull origin <branch-name>

# Only download, without merging
git fetch origin

# Fetch all remote branches
git fetch --all

# Pull with rebase instead of merge
git pull --rebase origin <branch-name>
```

---

## Staging & Commits

### Adding files to staging
```bash
# Stage a single file
git add <filename>

# Stage all files
git add .

# Stage all modified files (not new ones)
git add -u

# Interactive staging
git add -i

# Stage parts of a file
git add -p <filename>
```

### Creating commits
```bash
# Commit with a message
git commit -m "Commit message"

# Multi-line commit message
git commit -m "Title" -m "Detailed description"

# Commit all modified files (skips staging)
git commit -a -m "Message"

# Amend the last commit
git commit --amend

# Change the last commit's message
git commit --amend -m "New message"
```

### Commit message best practices
```
Format: <type>(<scope>): <subject>

<body>

<footer>
```

**Examples:**
```
feat(auth): add user login functionality
fix(api): resolve timeout issue in user service
docs(readme): update installation instructions
style(css): fix button alignment
refactor(utils): simplify date formatting function
test(auth): add unit tests for login flow
chore(deps): update dependencies to latest versions
```

---

## History & Logs

### Viewing commit history
```bash
# Simple log
git log

# Compact log (one line per commit)
git log --oneline

# Log with graph
git log --graph --oneline --all

# Show the last X commits
git log -5

# Log for a specific file
git log <filename>

# Log with change statistics
git log --stat
```

### Advanced log options
```bash
# Log between two commits
git log <commit1>..<commit2>

# Log for a specific author
git log --author="Name"

# Log since a specific date
git log --since="2 weeks ago"
git log --since="2025-01-01"

# Log with diff
git log -p

# Nicely formatted log
git log --pretty=format:"%h - %an, %ar : %s"
```

### Viewing changes
```bash
# Changes in the working directory
git diff

# Changes in staging
git diff --staged
git diff --cached

# Changes between branches
git diff branch1..branch2

# Changes in a specific file
git diff <filename>
```

---

## Undoing Changes

### Discarding changes
```bash
# Discard changes in a file
git checkout -- <filename>
# Or:
git restore <filename>

# Discard all changes in the working directory
git checkout -- .
git restore .

# Remove a file from staging
git reset HEAD <filename>
# Or:
git restore --staged <filename>
```

### Undoing commits
```bash
# Undo the last commit (keeps changes)
git reset --soft HEAD~1

# Undo the last commit and staging
git reset HEAD~1

# Completely delete the last commit (CAUTION!)
git reset --hard HEAD~1

# Undo a specific commit (creates a new commit)
git revert <commit-hash>
```

### Reset vs Revert
- **Reset**: Rewrites history (dangerous on shared branches)
- **Revert**: Creates a new commit that undoes changes (safe)

---

## Stashing

### Saving temporary changes
```bash
# Stash changes
git stash

# Stash with a message
git stash save "Work in progress on feature X"

# Also stash untracked files
git stash -u

# Show all stashes
git stash list

# Apply a stash
git stash apply

# Apply and drop the latest stash
git stash pop

# Apply a specific stash
git stash apply stash@{2}
```

### Managing stashes
```bash
# Show a stash
git stash show

# Show stash contents in detail
git stash show -p

# Drop a stash
git stash drop stash@{1}

# Clear all stashes
git stash clear

# Create a branch from a stash
git stash branch <branch-name>
```

---

## Tags & Releases

### Creating tags
```bash
# Create a lightweight tag
git tag v1.0.0

# Create an annotated tag (recommended)
git tag -a v1.0.0 -m "Version 1.0.0 release"

# Tag a specific commit
git tag -a v1.0.0 <commit-hash> -m "Message"

# Show all tags
git tag

# Search tags with a pattern
git tag -l "v1.*"
```

### Managing tags
```bash
# Show tag details
git show v1.0.0

# Delete a tag
git tag -d v1.0.0

# Delete a remote tag
git push origin --delete v1.0.0

# Push tags
git push origin v1.0.0
git push origin --tags  # All tags
```

---

## Conflict Resolution

### Understanding merge conflicts
```
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> branch-name
```

### Resolving conflicts
```bash
# Resolve conflicts manually, then:
git add <resolved-file>
git commit

# Use a merge tool
git mergetool

# Abort the merge
git merge --abort

# Show conflict status
git status
```

### Rebase conflicts
```bash
# Continue the rebase after resolving conflicts
git rebase --continue

# Abort the rebase
git rebase --abort

# Skip the current commit during a rebase
git rebase --skip
```

---

## Git Workflows

### Feature Branch Workflow
```bash
# 1. Create a new feature branch
git checkout -b feature/new-feature

# 2. Develop and commit
git add .
git commit -m "feat: add new feature"

# 3. Push the branch
git push -u origin feature/new-feature

# 4. Create a pull request (GitHub/GitLab)

# 5. After merge: clean up the branch
git checkout main
git pull origin main
git branch -d feature/new-feature
```

### Gitflow Workflow
```bash
# Start a feature
git checkout -b feature/new-feature develop

# Finish a feature
git checkout develop
git merge --no-ff feature/new-feature
git branch -d feature/new-feature

# Prepare a release
git checkout -b release/1.0.0 develop

# Finish a release
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0
```

---

## Advanced Commands

### Interactive Rebase
```bash
# Interactively edit the last 3 commits
git rebase -i HEAD~3

# Rebase onto another branch
git rebase -i main

# Options in interactive mode:
# pick = use the commit
# reword = use the commit, change the message
# edit = use the commit, pause for changes
# squash = combine the commit with the previous one
# drop = delete the commit
```

### Cherry-Pick
```bash
# Apply a specific commit to the current branch
git cherry-pick <commit-hash>

# Cherry-pick multiple commits
git cherry-pick <commit1> <commit2>

# Cherry-pick without committing (staging only)
git cherry-pick -n <commit-hash>
```

### Bisect (Bug Hunting)
```bash
# Start bisecting
git bisect start

# Mark the current commit as bad
git bisect bad

# Mark a good commit
git bisect good <commit-hash>

# Git automatically switches to the middle commit
# Test and mark it:
git bisect good  # or git bisect bad

# End the bisect
git bisect reset
```

### Submodules
```bash
# Add a submodule
git submodule add <repository-url> <path>

# Initialize submodules
git submodule init

# Update submodules
git submodule update

# Clone a repository including submodules
git clone --recursive <repository-url>
```

---

## Git Configuration

### Global configuration
```bash
# Set user data
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Set the default editor
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim

# Default branch name
git config --global init.defaultBranch main

# Automatic CRLF handling
git config --global core.autocrlf true   # Windows
git config --global core.autocrlf input  # Linux/Mac
```

### Aliases (shortcuts)
```bash
# Useful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Advanced aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

### Viewing configuration
```bash
# Show all configuration
git config --list

# Show a specific configuration value
git config user.name

# Edit configuration
git config --global --edit
```

---

## Troubleshooting

### Common problems

#### "Your branch is ahead of origin/main"
```bash
# Solution: push the changes
git push origin main
```

#### "Your branch is behind origin/main"
```bash
# Solution: pull the changes
git pull origin main
```

#### "fatal: not a git repository"
```bash
# Solution: initialize the repository or switch to the correct directory
git init
# or
cd /path/to/your/repository
```

#### Accidentally deleted the wrong branch
```bash
# Show the reflog
git reflog

# Restore the branch
git checkout -b <branch-name> <commit-hash>
```

#### Push rejected due to conflicts
```bash
# Solution 1: pull and merge
git pull origin main
# Resolve conflicts, then:
git push origin main

# Solution 2: pull with rebase
git pull --rebase origin main
# Resolve conflicts, then:
git push origin main
```

### Useful debugging commands
```bash
# Shows which commit last changed each line
git blame <filename>

# Shows the reference log (all HEAD movements)
git reflog

# Shows what changed in a commit
git show <commit-hash>

# Checks repository integrity
git fsck

# Cleans up unreferenced objects
git gc

# Repository statistics
git count-objects -v
```

---

## 📝 Git Cheat Sheet - Quick Reference

### Essential Commands
```bash
git status              # Repository status
git add .               # Stage all changes
git commit -m "msg"     # Create a commit
git push origin main    # Upload changes
git pull origin main    # Download changes
git branch              # Show branches
git checkout -b new     # Create a new branch
git merge branch-name   # Merge a branch
git log --oneline       # Commit history
```

### Emergency Commands
```bash
git stash               # Temporarily save changes
git reset --hard HEAD~1 # Delete the last commit (CAUTION!)
git revert <commit>     # Safely undo a commit
git merge --abort       # Abort a merge
git rebase --abort      # Abort a rebase
git checkout -- .       # Discard all changes
```

---

## 🎯 Recommended Workflows for DevOps

### Daily Workflow
```bash
# 1. Morning: get the latest state
git checkout main
git pull origin main

# 2. Create a feature branch
git checkout -b feature/ticket-123

# 3. Develop
git add .
git commit -m "feat: implement new feature"

# 4. Push regularly
git push -u origin feature/ticket-123

# 5. After review: cleanup
git checkout main
git pull origin main
git branch -d feature/ticket-123
```

### Release Workflow
```bash
# 1. Create a release branch
git checkout -b release/v1.2.0 develop

# 2. Bump the version, test
git commit -m "chore: bump version to 1.2.0"

# 3. Merge the release
git checkout main
git merge --no-ff release/v1.2.0
git tag -a v1.2.0 -m "Release v1.2.0"

# 4. Merge back into develop
git checkout develop
git merge --no-ff release/v1.2.0

# 5. Push
git push origin main develop --tags
```

---

## 📚 Further Resources

- [Pro Git Book](https://git-scm.com/book) - Free online
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- [GitHub Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [Interactive Git Tutorial](https://learngitbranching.js.org/)

---

*This cheat sheet grows with your DevOps journey. Save it as a reference and extend it as needed!*

**Last updated:** July 2025  
**Difficulty level:** Beginner to advanced  
**Use case:** DevOps, software development, version control
