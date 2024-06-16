# Useful Commands for Git Bash

## Create SSH key
```sh
sh-keygen -t ed25519 -C "email_address@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
Copy the pub file to github > account > settings > ssh keys 
Go to repo you want to connect to > green code button > copy ssh link
```sh
cd ~/Github/ExampleRepo
git remote add originssh git@github.com:ExampleUser/ExampleRepo.git
git remote -v
git pull --set-upstream originssh main
git push --set-upstream originssh
```

## Edit/Remove commit
Grab commit hash and open interactive rebase TODO 
```sh
git log
git rebase -i <commit ID>~ # trailing ~ includes selected commit
```
Change "pick" of any commit to your desired command:
```
p, pick <commit> = use commit  
r, reword <commit> = use commit, but edit the commit message  
e, edit <commit> = use commit, but stop for amending  
s, squash <commit> = use commit, but meld into previous commit  
f, fixup [-C | -c] <commit> = like "squash" but keep only the previous  
                   commit's log message, unless -C is used, in which case  
                   keep only this commit's message; -c is same as -C but  
                   opens the editor  
x, exec <command> = run command (the rest of the line) using shell  
b, break = stop here (continue rebase later with 'git rebase --continue')  
d, drop <commit> = remove commit  
l, label <label> = label current HEAD with a name  
t, reset <label> = reset HEAD to a label  
m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]  
.       create a merge commit using the original merge commit's  
.       message (or the oneline, if no original merge commit was  
.       specified); use -c <commit> to reword the commit message  
 
These lines can be re-ordered; they are executed from top to bottom.  
 
If you remove a line here THAT COMMIT WILL BE LOST.  
 
However, if you remove everything, the rebase will be aborted.
```
Make desired changes then add the files and continue to next commit
```sh
git add ~/Github/Repo
git rebase --continue
```