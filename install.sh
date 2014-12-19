#!/bin/bash

# TODO:
# 1. echo 'source bashrc.local' to ~/.bashrc if no
# 2. merge vimrc / tmux / bash_aliases together
echo "0. install ~/.bashrc.local"
cp ./bashrc ~/.bashrc.local

echo "1. install ~/.bash_aliases"
cp ./bash_aliases ~/.bash_aliases

echo "2. install ~/.bash_aliases.android"
cp ./bash_aliases.android ~/.bash_aliases.android

if [[ -f ~/.bash_aliases.local ]]; then
    read -p "~/.bash_aliases.local exists! Do you want to overwrite it? [Y] : " answer
    if [[ ${answer} == 'Y' ]]; then
        echo "3. update ~/.bash_aliases.local"
        cp ./bash_aliases.local ~/.bash_aliases.local
    fi
else
    echo "3. install ~/.bash_aliases.local"
    cp ./bash_aliases.local ~/.bash_aliases.local
fi

echo "install OK!"
