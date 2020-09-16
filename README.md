# dotfiles
My dotfiles

## Getting started
### Prerequisites
* zsh
* vim
* tmux

#### Install oh-my-zsh
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Install powerline font
```bash
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh SourceCodePro
```
Run the code above and set the font in the terminal preferences.
![](https://i.imgur.com/yoZzfpo.png?raw=true)

#### Installing tmux plugins
Press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugins.

#### Installing ![diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
```bash
sudo npm install -g diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
```
