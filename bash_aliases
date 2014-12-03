# Internal Commands Abbr.
alias c='clear'
alias e='exit'
alias s='source'
alias p='pwd'
alias g='gedit'
alias op='xdg-open'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Internal Commands Extd.
alias n='wc -l'
alias rm='rm -I'
alias lh='ls -lh --color=auto'
alias hs='history | grep --color=auto -i'
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias gt='gcc -o test test.c && ./test'
alias g+='g++ -o test test.cpp && ./test'
alias jt='javac test.java && java test'
alias agi='sudo apt-get install -y'
alias lk='gnome-screensaver-command -l'

# External Commands Abbr.
alias ds='display'          # imagemagick
alias lx='xelatex'          # texlive-full
alias tm='tmux -2'          # tmux
alias slm='sublime-text'    # sublime-text

# Inner Functions
fls() {
    # FIXME: change it to general format
    local F
    F=""
    for i in `cat ~/.bash_aliases | sed -n "/() {/s/\([a-z]*\).*/\1/p" | sort`; do
        F="$F $i"
    done
    echo $F
    F=""
    if [[ -f ~/.bash_aliases.android ]]; then
        for j in `cat ~/.bash_aliases.android | sed -n "/() {/s/\([a-z]*\).*/\1/p" | sort`; do
            F="$F $j"
        done
    fi
    echo $F
    F=""
    if [[ -f ~/.bash_aliases.local ]]; then
        for k in `cat ~/.bash_aliases.local | sed -n "/() {/s/\([a-z]*\).*/\1/p" | sort`; do
            F="$F $k"
        done
    fi
    echo $F
}

# display PATH each line
path() {
    echo "${PATH//:/$'\n'}"
}

# grep text
gp() {
    grep -rni "$1" .
}

# add exec permission
ax() {
    if [[ $# -ne 1 ]]; then
        echo "Usage : ax <file>"
    else
        chmod a+x $1
    fi
}

# mkdir directory and enter
mcd() {
    if [[ $# -ne 1 ]]; then
        echo "Usage : mcd <dir>"
    else
        mkdir -p $1 && cd $1
    fi
}

# display runtime since last startup
rt() {
    cat /proc/uptime | awk -F. '{\
        run_days = $1 / 86400;\
        run_hours = ($1 % 86400) / 3600;\
        run_minutes = ($1 % 3600) / 60;\
        run_seconds = $1 % 60;\
        printf("%d days %d hours %d minutes %d seconds\n"\
        , run_days, run_hours, run_minutes, run_seconds)}'
}

# view directory size like ls
dls() {
    OLDIFS=${IFS}
    IFS=$'\n'
    du -sh `ls -p | grep "/$"`
    IFS=${OLDIFS}
}

# show image dimensions (width x height)
# NOTE : imagemagick need to be installed
imgdim() {
    if [[ $# -ne 1 ]]; then
        echo "Usage : imgdim <file>"
    else
        identify -format "%wx%h" $1
    fi
}

# show number of files and directories
num() {
    fileNum=`ls -1 -F | sed "/\/$/d" | wc -l`
    dirNum=`ls -1 -F | grep "/$" | wc -l`
    echo "${fileNum} files, ${dirNum} directories"
}

# firefox command (default search engine : baidu)
fox() {
    if [[ $# -eq 0 ]]; then
        firefox
    elif [[ $# -eq 1 ]]; then
        case "$1" in
            git) firefox -new-tab "http://github.com/young-mu";;
            xref) firefox -new-tab "http://androidxref.com";;
            note) firefox -new-tab "http://note.youdao.com";;
            126) firefox -new-tab "http://www.126.com";;
            md) firefox -new-tab "http://mahua.jser.me";;
            *) firefox -search $1
        esac
    fi
}

# google-chrome command (default page : google)
gc() {
    if [[ $# -eq 0 ]]; then
        google-chrome "http://www.google.com"
    elif [[ $# -eq 1 ]]; then
        case "$1" in
            gmail) google-chrome "http://gmail.google.com";;
            trans) google-chrome "http://translate.google.com";;
            src) google-chrome "http://source.android.com";;
            dev) google-chrome "http://developer.android.com";;
            repot) google-chrome "https://android.googlesource.com";;
            play) google-chrome "http://play.google.com";;
            git) google-chrome "http://github.com/young-mu";;
            xref) google-chrome "http://androidxref.com";;
            note) google-chrome "http://note.youdao.com";;
            126) google-chrome "http://www.126.com";;
            md) google-chrome "http://mahua.jser.me";;
            *) echo "no <$1> item."
        esac
    fi
}

# open git project in github
go() {
    REMOTE=`git remote -v 2> /dev/null`
    if [[ $? -ne 0 ]]; then
        echo "NO git project here."
    else
        URL=`echo ${REMOTE} | awk '{print $2}'`
        google-chrome ${URL}
    fi
}

# find file and open it
ffo() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: ffo <file>"
    else
        findres=`find . -type f -name $1`
        findnum=`echo ${findres} | awk '{print NF}'`
        if [[ ${findnum} -eq 0 ]]; then
            echo "$1 NOT found!"
        elif [[ ${findnum} -eq 1 ]]; then
            echo "$findres"
            vim ${findres}
        elif [[ ${findnum} -ge 1 ]]; then
            declare -i n=1
            for file in ${findres}; do
                echo "[${n}] ${file}"
                n=n+1
            done
            read -p "which one to open: " num
            if [[ ${num} -ge 1 && ${num} -lt n ]]; then
                vim `echo ${findres} | awk -v cnt=$num '{print $cnt}'`
            fi
        fi
    fi
}

# convert from dec to hex or from hex to dec
con() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: con <dec>|0x<hex>"
    else
        if [[ $1 =~ ^0x ]]; then
            printf "%d\n" $1
        else
            ret=`printf "%x\n" $1`
            echo 0x${ret}
        fi
    fi
}

# source android aliases
if [[ -f ~/.bash_aliases.android ]]; then
    source ~/.bash_aliases.android
fi

# source local aliases
if [[ -f ~/.bash_aliases.local ]]; then
    source ~/.bash_aliases.local
fi
