export LANG=en_US.UTF-8
#export XMODIFIERS="@im=fit"
#16colors
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1 

export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # Lists all the colors, uses vars in .bashrc_non-interactive
#welcome
#echo -e "Kernel Information: " `uname -smr`
#echo -e "${COLOR_BROWN}`bash --version`"
#echo -ne "${COLOR_GRAY}Uptime: "; uptime
#echo -ne "${COLOR_GRAY}Server time is: "; date
#prompt
export PS1="\[${COLOR_GREEN}\]\u@\h\[${COLOR_BLUE}\]:\w\\$\[${COLOR_NC}\] "
#export PS1="\[${COLOR_NC}\]\u@\h:\w\a\]\\$ "
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"'  # user@host path
#export PS1="\\[${COLOR_GREEN}\\]\\w > \\[${COLOR_NC}\\]"
function xtitle {  # change the title of your xterm* window
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007" 
}
#misc
export HISTCONTROL=ignoredups
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
#some more ls alias
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias thunder='python ~/CodeLib/xunlei-lixian/lixian_cli.py'
#modify path and classpath
export PATH=$PATH:~/Scripts
# MacPorts Installer addition on 2011-01-31_at_15:42:42: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
#git completion
source $HOME/.git-completion.bash
#rvm
#source /Users/sodabiscuit/.rvm/scripts/rvm
#gclient
export PATH=$PATH:$HOME/CodeLib/depot_tools
#golang
export GOROOT=$HOME/CodeLib/google/go
export GOARCH=386
export GOOS=darwin
export PATH=$PATH:$GOROOT/bin
#node
#export NODE_PATH=/opt/node:/opt/node/lib/node_modules
#export PATH=$PATH:/opt/node/bin
#nacl
export NACL_SDK_ROOT=$HOME/Dev/nacl_sdk
#python
export PYTHONPATH=$HOME/CodeLib/tornado:$PYTHONPATH
export PYTHONPATH=$HOME/CodeLib/google/google-api-python-client:$PYTHONPATH
#mongodb
export MONGO_PATH=$HOME/Dev/mongodb
export PATH=$PATH:$MONGO_PATH/bin
#mit-scheme
export PATH=$PATH:/Applications/mit-scheme.app/Contents/Resources/

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
