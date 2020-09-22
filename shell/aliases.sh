#lazy stuff
alias ..="cd .."

# tmux stuff
alias tmux="TERM=screen-256color-bce tmux"

# spark stuff
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH

# exa stuff
alias l='exa -1a'
alias ll='exa -lh --git'
alias ls=exa
alias lt='exa -lT --git'
