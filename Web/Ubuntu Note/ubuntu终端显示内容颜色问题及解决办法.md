# ubuntu终端显示内容颜色问题及解决办法

最近在ubuntu系统中用`rm -rf`​命令删除文件的时候，在文件名后面多打了一个空格，导致系统中所有文件丢失，系统中配置也出现了问题。直观的问题是在终端中用`ls`​显示当前目录内容的时候，显示全是白色，所以研究了这个问题并且找到了解决办法。

### 1.问题的描述：

1. 打开终端，用`ls`​或者`ls -a`​显示当前目录下的文件信息，发现所有显示都是白色，如图1所示。
2. 在终端中输入`echo $LS_COLORS`​指令发现没有输出。
3. 在”/home/用户名“目录下，输入`ls -a`​指令执行，发现没有命名为.bashrc的文件，如图1所示。

其中，1）是问题的直观表现，问题2）和问题3）是根本原因。

​![图1](https://img-blog.csdn.net/20170914173339713)​

### 2.问题的原因：

系统的主目录下丢失了.bashrc文件或者该文件没有正常工作。

### 3.解决办法：

1. 利用`ls -l`​查找主目录下有没有命名为.bashrc的文件，如果有，但是依然显示白色或者单一颜色，在终端中执行`source ~/.bashrc`​指令即可。
2. 如果没有这个文件，可以从别人的对应系统中利用`cp`​指令拷贝一份，然后将.bashrc拷贝到`~/`​目录下，然后执行`source ~/.bashrc`​指令即可，解决后显示如图2所示。

​![图2](https://img-blog.csdn.net/20170914174547816)​

注意：为了大家方便，我把我的系统中.bashrc文件中的内容贴在这里了，大家可一用`touch`​指令创建一个.bashrc文件，然后把内容复制粘贴到里面后保存，然后`source`​一下即可。

```bash
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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
 
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
 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
 
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
 
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
 
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
```
