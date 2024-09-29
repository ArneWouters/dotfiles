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

### [Alacritty](https://alacritty.org/index.html)
```bash
ln -s ~/dotfiles/alacritty ~/.config/alacritty
```

### Aliases
```bash
ln -s ~/dotfiles/shell/aliases.sh ~/.shell/aliases.sh
```

### [Neovim](https://neovim.io/)
```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

### [Starship](https://starship.rs)
```bash
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
```

### [TMUX](https://github.com/tmux/tmux)
```bash
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```


## Extra
-  [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
```bash
sudo npm install -g diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
```
- [eza](https://github.com/eza-community/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

