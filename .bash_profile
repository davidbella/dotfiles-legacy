#####
# Use 256 colors!
export TERM=xterm-256color

##### Load external scripts
# Bash color helpers
source ${HOME}/.scripts/.bash_colors
source ${HOME}/.scripts/.bash_colors_256

# Brew tab complete
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Fancy git bash prompt helper
GIT_PROMPT_THEME=Solarized

# Only displays the 'on' in the callback if you are in a git repo
function prompt_callback {
  local repo=`git rev-parse --show-toplevel 2> /dev/null`
  if [[ -e "$repo" ]]; then
    echo " on"
  fi
}

source ${HOME}/.scripts/bash-git-prompt/gitprompt.sh

##### Set informative environment variables
# Grab the current IP Addresses
export EXTERNAL_IP=`curl -4 icanhazip.com 2>/dev/null &`
export INTERNAL_IP=`ifconfig | grep 'inet' | tail -1 | cut -d" " -f2 2>/dev/null &`
export VPN_IP=`ifconfig tun0 2>/dev/null | grep 'inet' 2>/dev/null &`
export VPN_IP=`echo $VPN_IP | awk '{print \"vpn \" $2}' > /dev/null 2>&1`

##### Set up the prompt
# Creates a neat little spark line off of the IP addresses
function prompt_spark() {
  clr_red $(spark $(echo $EXTERNAL_IP | sed -e 's?\.?,?g'),0,0,0,0,$(echo $INTERNAL_IP | sed -e 's?\.?,?g') 2>/dev/null)
}

# Currently using the bash-git-prompt repo to help set my prompt
# requires you to "wrap" the git status inside of your desired prompt
function prompt {
  GIT_PROMPT_START="\n \$(clr_cyan \u) using \$(clr_brown \h) in \$(clr_blue \w)"
  GIT_PROMPT_END="\n \$(prompt_spark)   \$(clr_red \@)  "
}

prompt

# Allow tmux sessions to write to common history
# http://askubuntu.com/questions/339546/how-do-i-see-the-history-of-the-commands-i-have-run-in-tmux
###
# No duplication of commands in history
export HISTCONTROL=ignoredups:erasedups
# Appends to history file instead of overwriting when shell exits
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

##### Set a view usable environment variables
# Make sure your editor is set to vim in a few scenarios
export VISUAL="vim"
export SVN_EDITOR="vim"
export GIT_EDITOR="vim"
export EDITOR="vim"

# Adds a couple of the /usr locations to PATH, helpful for brew
export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"
export PATH="$USR_PATHS:$PATH"

# Aliases
# ls
alias l='ls -lh'
alias ls='ls -lh'
alias la='ls -lah'
# Files changed today - haven't gotten this to work outside of factset
# alias lst="find . -daystart -maxdepth 1 -mtime -1 | sed -e 's?^\./\{0,1\}??' -e 's?^\..*??' | xargs ls -l --color -d"

# clear
alias c='clear'
alias cls='clear'

# Git
alias gst="git status"

# fasd navigator
eval "$(fasd --init auto)"
alias v='f -e vim'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export RUBYMOTION_ANDROID_SDK=~/android-rubymotion/sdk
export RUBYMOTION_ANDROID_NDK=~/android-rubymotion/ndk
