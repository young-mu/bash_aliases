# source git bash tools
# execute 'xcode-select --install' first
if [ -f $(xcode-select -p)/usr/share/git-core/git-completion.bash ]; then
    source $(xcode-select -p)/usr/share/git-core/git-completion.bash
    source $(xcode-select -p)/usr/share/git-core/git-prompt.sh
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
