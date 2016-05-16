# Internal Commands Abbr.
alias c='clear'
alias e='exit'
alias s='source'
alias p='pwd'
alias op='open'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Internal Commands Extd.
alias n='wc -l'
alias ls='ls -G'
alias lh='ls -lhG'
alias hs='history | grep --color=auto -i'
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias cl='clang -o test test.c && ./test'
alias gt='gcc -o test test.c && ./test'
alias g+='g++ -o test test.cpp && ./test'
alias jt='javac test.java && java test'
alias lk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# External Commands Abbr.
alias ds='display'          # imagemagick
alias lx='xelatex'          # texlive-full
alias st='sublime-text'     # sublime-text
alias diff='colordiff'      # colordiff
alias chrome='open -a "/Applications/Google Chrome.app"' # Chrome

# Inner Functions
fls() {
    alias_files=`ls ~/.bash_aliases*`
    for alias_file in ${alias_files}; do
        local F
        F=""
        for i in `cat ${alias_file} | sed -n "/() {/s/\([a-zA-Z]*\).*/\1/p" | sort`; do
            F="$F $i"
        done
        echo "${alias_file/\/home\/young\//} :$F"
    done
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

# generate current project filelist for quick searching
genfl() {
    if [[ -d .git ]]; then
        exclude="\.git"
    elif [[ -d .svn ]]; then
        exclude=".svn"
    else
        exclude="*"
    fi
    if [[ -e ./filelist ]]; then
        echo "update filelist ... "
    else
        echo "create filelist ... "
    fi
    files=`find . -type f -name "*" | grep -vwe ${exclude}`
    for file in ${files}; do
        bfile=`basename ${file}`
        ffile=${file/./$(pwd)}
        echo "${bfile} ${ffile}" >> /tmp/filelist
    done
    cat /tmp/filelist | sort > ./filelist
    rm /tmp/filelist
    echo "done"
}

# filelist defined here
#filelist=/home/young/<proj>/trunk/src/filelist

# quick open by indexing file in filelist
qo() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: qo <file>"
    else
        findres=`cat ${filelist} | grep -w "$1" | awk '{print $2}'`
        findnum=`echo ${findres} | awk '{print NF}'`
        if [[ ${findnum} -eq 0 ]]; then
            echo "$1 NOT found!"
        elif [[ ${findnum} -eq 1 ]]; then
            echo "${findres}"
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

_qo_autocomp() {
    curw=${COMP_WORDS[COMP_CWORD]}
    files=(`cat ${filelist} | awk '{print $1}' | uniq`)
    COMPREPLY=(`compgen -W '${files[@]}' -- $curw`)
}
complete -F _qo_autocomp qo

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
            echo "${findres}"
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

# md5sum check
md5() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: md5 <file> <md5sum>"
    else
        md5sum $1 | grep "$2"
    fi
}

# print code lines
lines() {
    if [ $# -ne 1 ]; then
        echo "Usage: lines [c|cpp|java|sh|...]"
    else
        case "$1" in
            c) out=1 option="-regex" file=".*\.(c|h)$";;
            cpp) out=1 option="-regex" file=".*\.(cpp|h)";;
            java) out=1 option="-regex" file=".*\.java";;
            sh) out=1 option="-regex" file=".*\.sh";;
            *) out=0;;
        esac
        if [ ${out} -eq 1 ]; then
            find -E . ${option} ${file} | xargs wc -l
        else
            echo "unsupported file class";
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
