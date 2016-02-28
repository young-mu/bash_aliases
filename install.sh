#!/bin/bash

if [[ ! `cat ~/.bashrc | grep "bashrc\.local"` ]]; then
    echo -e "\n# source ~/.bashrc.local" >> ~/.bashrc
    echo "if [ -f ~/.bashrc.local ]; then" >> ~/.bashrc
    echo "    . ~/.bashrc.local" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi

echo "0. install ~/.bashrc.local and ~/.git-prompt.sh"
cp ./bashrc ~/.bashrc.local
cp ./git-prompt.sh ~/.git-prompt.sh

echo "1. install ~/.bash_aliases"
cp ./bash_aliases ~/.bash_aliases

if [[ -f ~/.bash_aliases.local ]]; then
    read -p "~/.bash_aliases.local exists! Do you want to overwrite it? [Y] : " answer
    if [[ ${answer} == 'Y' ]]; then
        echo "2. update ~/.bash_aliases.local"
        cp ./bash_aliases.local ~/.bash_aliases.local
    fi
else
    echo "2. install ~/.bash_aliases.local"
    cp ./bash_aliases.local ~/.bash_aliases.local
fi

echo "install OK!"
