# Dotfiles
## Clone
```bash
git clone ssh://git.amazon.com/pkg/Awouters-dotfiles
mv Awouters-dotfiles dotfiles
```


## Setup
Commands for setting up the links to the config files

### [Aerospace](https://github.com/nikitabobko/AeroSpace)
```bash
ln -s ~/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
```


## Extra
-  [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
```bash
sudo npm install -g diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
```

