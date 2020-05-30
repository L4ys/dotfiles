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
force_color_prompt=yes

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
    if [ "$(id -u)" = "0" ]; then
        PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    fi
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
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

__git_ps1()
{
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo " ["${ref#refs/heads/}"]";
}

[ -f ~/.ctfrc ] && . ~/.ctfrc
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh
[ -f ~/.pythonrc ] && export PYTHONSTARTUP="$HOME/.pythonrc"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=~/bin:$PATH
export EDITOR=vim
export CLICOLOR=1
export PIN_ROOT="$HOME/bin/pin"

alias ..="cd .."
alias gdb="gdb -q"
alias gdbm="gdb-multiarch -q"
alias pwndbg="gdb -x ~/pwndbg/gdbinit.py"
alias tmux="history -n;tmux -2"
alias rip="curl orange.tw"
alias tip="curl --socks5 127.0.0.1:9050 orange.tw"
alias tcurl="curl --socks5 127.0.0.1:9050 "
alias tssh="ssh -o 'ProxyCommand /usr/bin/nc -x 127.0.0.1:9050 %h %p'"
alias rssh="ssh -NfR 12345:localhost:22"
alias lssh="ssh -NfL 12345:localhost:12345"
alias strace="strace -ixv"
alias ltrace="ltrace -iC"
alias objdump="objdump -M intel"
alias len="expr length"
alias fuck="killall -9"
alias djson="python -m json.tool"
alias folders="find . -maxdepth 1 -type d -print0 | xargs -0 du -skh | sort -rn"

alias ll='ls -l'
alias la='ls -Ahl'
alias l='ls -CF'
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Less Colors for Man Pages
export PAGER="$(which less) -s"
export BROWSER="$PAGER"
export LESS='-R'
export LESS_TERMCAP_mb=$'\E[38;5;167m'  # begin blinking
export LESS_TERMCAP_md=$'\E[38;5;39m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # end mode
export LESS_TERMCAP_se=$'\E[38;5;231m'  # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;167m'  # begin standout-mode - info box
export LESS_TERMCAP_us=$'\E[38;5;167m'  # begin underline
export LESS_TERMCAP_ue=$'\E[0m'         # end underline

# ssh auto complete
complete -W "$(cat ~/.ssh/config 2>&1| grep '^Host ' | grep -v '*' |  awk '{print $2}')" ssh

# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/.env
    source /usr/local/bin/virtualenvwrapper.sh
fi

tunnel()
{
    if [ $# != 4 ]; then
        echo "tunnel <LOCAL PORT> <DEST HOST> <DEST PORT> <host>"
    else
        ssh -NfL $1:$2:$3 $4
    fi
}

docker-shell()
{
    docker exec -it $1 /bin/bash
}

# OSX
if [ "$(uname)" == "Darwin" ]; then
    PS1='\[\033[38;5;214m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    export LSCOLORS="Exfxcxdxbxegedabagacad"
    export HOMEBREW_NO_ANALYTICS=1
    alias ls="ls -G"
    alias deskshow="defaults write com.apple.finder CreateDesktop false;killall Finder"
    alias deskhide="defaults write com.apple.finder CreateDesktop true;killall Finder"
    alias bubu="brew update && brew upgrade && brew cleanup"
    source $(brew --prefix)/etc/profile.d/autojump.sh
elif grep -iq Microsoft /proc/version; then
    alias open="explorer.exe"
    alias xclip="clip.exe"
fi

