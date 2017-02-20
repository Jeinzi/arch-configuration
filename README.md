# My arch configuration
I keep track of my dotfiles and install scripts using a git repo sitting in my home directory. To install, clone
```
git clone https://github.com/jeinzi/dotfiles
```
while in your home directory, then merge with your existing files. Using bash, this can be done by executing
```
shopt -s dotglob nullglob
cp -r dotfiles/* .
shopt -u dotglob nullglob
```
With zsh, which is what I use, the command is 
```
cp -r dotfiles/*(D) . && rm -rf dotfiles
```
The calls to `shopt` respectively the `(D)` enable the matching of filenames starting with a dot, see this StackExchange [question](http://unix.stackexchange.com/questions/6393/how-do-you-move-all-files-including-hidden-from-one-directory-to-another) for information on other shells.
