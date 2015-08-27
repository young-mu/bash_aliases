# bashrc.local

# source git bash tools
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
fi

# source adb bash
if [ -f ~/.adb.bash ]; then
    source ~/.adb.bash
fi

# refresh PS1
PS1='
\[\e[0m\][\
\[\e[0;31m\]$?\
\[\e[0m\]]\u:\W/ \$\
\[\e[0;32m\]$(__git_ps1 "(%s)") \
\[\e[0m\]'

# disable Ctrl-s and Ctrl-q
stty -ixon

# Android SDK
export ANDROID_SDK=/home/young/Android/android-sdk-linux
# SDK tools (android, lint, etc.)
export PATH=${PATH}:${ANDROID_SDK}/tools
# SDK build-tools (aapt, etc.)
export PATH=${PATH}:${ANDROID_SDK}/build-tools/22.0.1
# SDK platform-tools (adb, fastboot, etc.)
export PATH=${PATH}:${ANDROID_SDK}/platform-tools

# Android NDK
export ANDROID_NDK=/home/young/Android/android-ndk-r10e
# NDK tools (ndk, etc.)
export PATH=${PATH}:${ANDROID_NDK}
# NDK cross-compile toolchains
export PATH=${PATH}:${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
export PATH=${PATH}:${ANDROID_NDK}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin

# Android studio
export PATH=${PATH}:/home/young/Android/android-studio/bin

# suppress java log
unset JAVA_TOOL_OPTIONS
