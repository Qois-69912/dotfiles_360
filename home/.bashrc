# .Bashrc

# Global variable
export EDITOR="nvim"

# Prompt color
export PS1="\[$(tput bold)\]\[\033[38;5;160m\][\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;226m\]\w\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;160m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;51m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

# Shell alias
alias ls='ls -hN --color=auto --group-directories-first'
alias v=$EDITOR
alias la='ls -ahN --color=auto --group-directories-first'

# 7zip alias
alias ex='7z e'

# Git alias
alias gstatus='git status'
alias gcommit='git commit'
alias glog='git log'
alias gadd='git add'
alias gbranch='git branch'
alias gdiff='git diff'

# PATH
export PATH="$HOME/.local/bin:$PATH"
