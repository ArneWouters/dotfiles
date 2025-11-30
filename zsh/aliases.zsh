# lazy stuff
alias ..="cd .."
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias ..l='cd .. && ls'

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

alias tmuxa='tmux attach || tmux new-session'

# exa stuff
alias l='eza -1a'
alias ll='eza -lha --git'
alias ls=eza
alias lt='eza -lT --git'

# brazil
alias bb=brazil-build
alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use -p'
alias bwscreate='bws create -n'
alias brc=brazil-recursive-cmd
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'
