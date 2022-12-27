## Compare files side-by-side
  ```
  sdiff -l <file1> <file2> | cat -n | grep -v -e '($'
  diff -y <file1> <file2> | cat -n | grep -v -e '($'
  ```
  
## Git
  ### Undo and Reset
    # Revert changes to modified files.
    git reset --hard [committed hash] [specific HEAD]

    # Remove all untracked files and directories.
    # '-f' is force, '-d' is remove directories.
    git clean -fd
    
    # Undo git add for uncommitted changes
    git reset <file>
    
    # To unstage all changes for all files
    git reset
    
  ### Commit
    # Stage the files
    git add <files>
    
    # Stage for all files
    git add -A
    
    # Commit with message
    git commit -m "1st line message" -m "2nd line message"
    git commit -m "line one message
    line two \"quote\"
    message"
    
  ### LFS
    git lfs track         # see tracked formats
    git lfs track <files> # track specific files
    git lfs ls-files      # list tracked files

  
