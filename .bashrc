# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# for auto startx
if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]; then
    startx
fi

# add /usr/sbin to PATH
export PATH=$PATH:/sbin/:$HOME/bin/
export PATH=$PATH:$HOME/usr/bin/
export PATH=$PATH:$HOME/usr/local/bin

function timer_start {
  timer=${timer:-$(date "+%s.%N")}
}

function timer_stop {
  #~ timer_show=$(($(date "+%s.%N") - $timer))
  #~ $(echo "( $now - $midnight ) * 1000" | bc)
  timer_show=$(echo "$(date "+%s.%N") - $timer" | bc)
  unset timer
}

trap 'timer_start' DEBUG

green=$(tput setaf 2)
blue=$(tput setaf 4)
white=$(tput setaf 7)
bold=$(tput bold)
reset=$(tput sgr0)

PROMPT_COMMAND=timer_stop
export SAGE_BROWSER="firefox"
export PS1='\[$white$bold\][`printf "%0*.3fs" "7" "$timer_show"`]\n[\t]\[$reset$blue$bold\] \w \$\[$reset\] ' 
alias lsf='pwd;ls -al | grep  -v ^d | awk {'"'"'print $9'"'"'}'  
alias p='ps aux | grep  '  
alias tlc='find . -depth -exec rename '"'"'s'"/(.*)\/([^\/]*)/"'$1'"\/\L"'$2'"/"''"' {} \;"''
alias ..='cd ..' 
alias ...='cd ../..' 
alias ....='cd ../../..'
alias gdb='gdb -q'
alias h='history | grep '
alias f='find . -name '
alias lynx='lynx -accept_all_cookies https://mobile.twitter.com'
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias strings='strings -a '
alias indent='indent -linux -br -brs -l200 -i4 '
alias sudp='sudo '
alias ll='ls -l'
alias sl='ls '
# alias emacs='e '
alias bc='bc -q -l'
alias gitlog='git log --graph --abbrev-commit --decorate --date=relative --all'
alias vt='cd ~/vt && . bin/activate && cd -'
alias vt3='cd ~/vt3 && . bin/activate && cd -'
alias la='ls -al'
alias ports='lsof -Pnl +M -i4'
alias tags='find . -name "*.[chCH]" -print | etags -'
alias nssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
alias nscp='scp -o UserKnownHostsFile=/dev/null '
function findelf {
    find -type f -executable -exec sh -c "file -i '{}' | grep -q 'x-executable; charset=binary'" \; -print
}
alias tt='du -hsx * | sort -rh | head -10'
export LD_LIBRARY_PATH=$HOME/usr/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/usr/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/SailfishOS/lib/
export TZ=/etc/localtime

if [ "$COLORTERM" == "mate-terminal" ] || [ "$COLORTERM" == "xfce4-terminal" ]
then
TERM=xterm-256color
elif [ "$COLORTERM" == "rxvt-xpm" ]
then
TERM=rxvt-256color
fi

export ANDROID_HOME=$HOME/Android/Sdk
source $HOME/.bazel/bin/bazel-complete.bash

sd () { cal -y | GREP_COLORS="mt=07;32" grep --color=always -EC 6 " $1 |^$1 | $1\$" | GREP_COLORS="sl=11;33:mt=07;33" grep --color=always -B2 -A6 '[A-Z][a-z]\( \|$\)'; }

export DOTNET_ROOT=$HOME/bin/dotnetcore
export PATH=$PATH:$DOTNET_ROOT
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$HOME/.cargo/bin:$PATH"
export DOTNETDIR=$(dirname $(which dotnet))
export DOTNETLIB="$HOME/bin/dotnetcore/shared/Microsoft.NETCore.App/2.2.0"
