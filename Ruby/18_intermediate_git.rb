# Lesson overview
# This section contains a general overview of topics that you will learn in this lesson.

# History-changing Git commands.
# Different ways of changing history.
# Using remotes to change history.
# Dangers of history-changing operations.
# Best practices of history-changing operations.
# Pointers.

# git commit --amend
# git rebase --continue
# git log

# git reset HEAD~
# git add test3.md && git commit -m 'Create third file'
# git add test4.md && git commit -m 'Create fourth file'

# git reset --soft

# git reset --hard

# If you only ever rebase commits that have never left your own computer, you’ll be just fine. 
# If you rebase commits that have been pushed, but that no one else has based commits from, you’ll also be fine. 
# If you rebase commits that have already been pushed publicly, and people may have based work on those commits, then you may be in for some frustrating trouble, and the scorn of your teammates.
  

# git reset --soft
# git reset HEAD~ === git reset --mixed
# git reset --hard

# The reset command overwrites these three trees in a specific order, stopping when you tell it to:

# Move the branch HEAD points to (stop here if --soft).
# Make the index look like HEAD (stop here unless --hard).
# Make the working directory look like the index.


# Regarding the specific commands we’ve covered:
# For git commit --amend never amend commits that have been pushed to remote repositories.
# For git rebase never rebase a repository that others may work off of.
# For git reset never reset commits that have been pushed to remote repositories.
# For git push --force only use it when appropriate, use it with caution, and preferably default to using git push --force-with-lease.


# So when I use git rebase, 
# I (almost) always give it two arguments: 
# the name of the place I want to start from, 
# and the name of the place I want to end up. 
# Or, to put it another way, 
# I tell rebase the sequence of events I want it to create, 
# from left to right: git rebase first_this then_this

