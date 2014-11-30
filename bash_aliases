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

# Android
alias d='adb shell'
alias L='cd ~/AOSP/Lollipop; source build/envsetup.sh 1> /dev/null'
alias flo='cd ~/AOSP/Lollipop/out/target/product/flo;'
alias nb='ndk-build'
alias apk='aapt d badging'
alias dex2jar='~/Tools/dex2jar/dex2jar-0.0.9.15/d2j-dex2jar.sh'
alias jd-gui='~/Tools/jd-gui/jd-gui'
alias dp='adb shell input keyevent KEYCODE_POWER'

# Inner Functions
fls() {
    local F
    F=""
    for i in `cat ~/.bash_aliases | sed -n "/() {/s/\([a-z]*\).*/\1/p" | sort`; do
        F="$F $i"
    done
    echo $F
    F=""
    if [[ -f ~/.bash_aliases.local ]]; then
        for j in `cat ~/.bash_aliases.local | sed -n "/() {/s/\([a-z]*\).*/\1/p" | sort`; do
            F="$F $j"
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

# get AndroidManifest from apk into current directory
getAM() {
    if [[ ! "$1" =~ .apk$ ]]; then
        echo "Usage : getAM <apk>"
    elif [[ "$1" =~ .apk$ ]]; then
        apktool d $1 /tmp/tmpapk &> /dev/null
        cp /tmp/tmpapk/AndroidManifest.xml ./
        if [[ $? -eq 0 ]]; then
            echo "get AndroidManifest.xml ..."
        fi
        rm -rf /tmp/tmpapk
        rm -rf ~/apktool
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
    echo -e "${fileNum} files, ${dirNum} directories"
}

# android screencap
sc() {
    if [[ $# -eq 0 ]]; then
        adb shell screencap -p | sed 's/\r$//' > screen.png
        echo "./screen.png is generated"
    elif [[ $# -eq 1 ]]; then
        adb shell screencap -p | sed 's/\r$//' > ${1}.png
        echo "./${1}.png is generated"
    fi
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

# show Android make -j number
makej() {
    nCore=`cat /proc/cpuinfo | grep processor | wc -l`
    isHT=`cat /proc/cpuinfo | grep flags | uniq | grep ht | wc -l`
    echo "2 * ${nCore} * (${isHT} + 1)" | bc
}

# convert one image to multiple-dpi icons (install imagemagick first)
genIcons() {
    if [[ ! -e ./AndroidManifest.xml ]]; then
        echo "NO Android project here."
    else
        if [[ $# -ne 1 ]]; then
            echo "Usage : genIcons <image file>"
        else
            img=$1
            icondirs=`ls -d ./res/drawable-*`
            for icondir in ${icondirs}; do
                dirname=`basename ${icondir} | cut -d"-" -f2`
                case "${dirname}" in
                    ldpi)
                        convert -resize 36x36 ${img} ${icondir}/ic_launcher.png
                        echo "generate res/drawable-ldpi/ic_launcher.png";;
                    mdpi)
                        convert -resize 48x48 ${img} ${icondir}/ic_launcher.png
                        echo "generate res/drawable-mdpi/ic_launcher.png";;
                    hdpi)
                        convert -resize 72x72 ${img} ${icondir}/ic_launcher.png
                        echo "generate res/drawable-hdpi/ic_launcher.png";;
                    xhdpi)
                        convert -resize 96x96 ${img} ${icondir}/ic_launcher.png
                        echo "generate res/drawable-xhdpi/ic_launcher.png";;
                    xxhdpi)
                        convert -resize 144x144 ${img} ${icondir}/ic_launcher.png
                        echo "generate res/drawable-xxhdpi/ic_launcher.png";;
                    *)
                        echo -e "unknown directory : ${icondir}"
                esac
            done
        fi
    fi
}

# source android aliases
if [[ -f ~/.bash_aliases.android ]]; then
    source ~/.bash_aliaes.android
fi

# source local aliases
if [[ -f ~/.bash_aliases.local ]]; then
    source ~/.bash_aliases.local
fi
