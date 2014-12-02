#!/bin/bash

echo "1. install ~/.bash_aliases"
cp ./bash_aliases ~/.bash_aliases

echo "2. install ~/.bash_aliases.android"
cp ./bash_aliases.android ~/.bash_aliases.android

if [[ -f ~/.bash_aliases.local ]]; then
    read -p "~/.bash_aliases.local exists! Do you want to overwrite it? [Y|n] : " answer
    if [[ ${answer} == 'Y' ]]; then
        echo "3. update ~/.bash_aliases.local"
        cp ./bash_aliases.local ~/.bash_aliases.local
        echo "install OK!"
    elif [[ ${answer} == 'n' ]]; then
        echo "install OK!"
    else
        echo "unknown choice"
        echo "install OK!"
    fi
fi
