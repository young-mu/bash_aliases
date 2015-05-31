# source git bash tools
# execute 'xcode-select --install' first
if [ -f $(xcode-select -p)/usr/share/git-core/git-completion.bash ]; then
    source $(xcode-select -p)/usr/share/git-core/git-completion.bash
    source $(xcode-select -p)/usr/share/git-core/git-prompt.sh
fi

# refresh PS1
PS1='
\[\e[0m\]<\
\[\e[0;32m\]\#\
\[\e[0m\]> \u[\
\[\e[0;31m\]$?\
\[\e[0m\]]:\w\$\
\[\e[0;36m\]$(__git_ps1) \
\[\e[m\]'

# diable Ctrl-s and Ctrl-q
stty -ixon
