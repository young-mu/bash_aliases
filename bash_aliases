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
alias rm='rm -I'
alias lh='ls -lh --color=auto'
alias hs='history | grep --color=auto'
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias gt='gcc -o test test.c && ./test'
alias g+='g++ -o test test.cpp && ./test'
alias jt='javac test.java && java test'
alias agi='sudo apt-get install -y'

# External Commands Abbr. 
alias ds='display'
alias lx='xelatex' 
alias tm='tmux -2'
alias slm='sublime-text'

# Android
alias d='adb shell'
alias nb='ndk-build'
alias apk='aapt d badging'
alias dex2jar='~/Tools/dex2jar/dex2jar-0.0.9.15/d2j-dex2jar.sh'
alias jd-gui='~/Tools/jd-gui/jd-gui'
alias cts='cd ~/Android/android/out/host/linux-x86/cts/android-cts'
alias genarm='cd ~/Android/android/out/target/product/generic'
alias genx86='cd ~/Android/android_x86/out/target/product/generic_x86'

# Inner Functions

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
