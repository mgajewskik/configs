# My configs repo

This repo contains my configs. The usage with scripts can be found below.
To update all modified files: `myconfig add -u`

## First setup

```bash
git init --bare $HOME/.myconfig
alias myconfig='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
myconfig config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'" >> $HOME/.zshrc
myconfig remote add origin git@github.com:MGajewskiK/configs.git
```

## Cloning config

```bash
alias myconfig='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
echo ".myconfig" >> .gitignore
git clone --bare git@github.com:MGajewskiK/configs.git $HOME/.myconfig
myconfig checkout
# clean HOME from old configs
mkdir -p .config-backup && \
myconfig checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
myconfig checkout
myconfig config --local status.showUntrackedFiles no
```

## Automated cloning script

```bash
git clone --bare https://github.com/MGajewskiK/configs.git $HOME/.myconfig
function config {
   /usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME $@
}
mkdir -p .config-backup
myconfig checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    myconfig checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
myconfig checkout
myconfig config status.showUntrackedFiles no
```

### References

https://www.atlassian.com/git/tutorials/dotfiles
https://news.ycombinator.com/item?id=11071754
