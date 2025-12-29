If the local repo is a fork from a remote parent (upstream repo), use these commands to fetch and merge from upstream.

```
git remote add upstream <remote-ssh-url>
git remote -v
git fetch upstream
git merge upstream/<remote-branch>
```
