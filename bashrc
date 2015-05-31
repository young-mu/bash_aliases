# source git bash tools
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
fi

# refresh PS1
PS1='
\[\e[0m\][\
\[\e[0;31m\]$?\
\[\e[0m\]]\u:\W/ \$\
\[\e[0;32m\]$(__git_ps1 "(%s)") \
\[\e[0m\]'

# diable Ctrl-s and Ctrl-q
stty -ixon

# source bash_aliases
source ~/.bash_aliases
