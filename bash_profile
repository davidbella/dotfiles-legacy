EXTERNAL_IP=`dig +short +time=1 myip.opendns.com @resolver1.opendns.com`
INTERNAL_IP=`ifconfig | grep "inet[^6]" | grep broadcast | tail -1 | cut -d" " -f2 2>/dev/null`
VPN_IP=`ifconfig utun0 2>/dev/null | grep 'inet' 2>/dev/null | awk '{print $2}' 2>/dev/null`

echo $EXTERNAL_IP > ~/.external_ip
echo $INTERNAL_IP > ~/.internal_ip
echo $VPN_IP > ~/.vpn_ip

source ${HOME}/.scripts/bash_colors.bash
source ${HOME}/.scripts/git-completion.bash

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

function prompt {
  local foreground=$(( ( RANDOM % 10 )  + 30 ))
  local background=$(( ( RANDOM % 10 )  + 40 ))

  GIT_PROMPT_START="\n \$(clr_cyan \u) using \$(clr_brown \h) in \$(clr_blue '\w')"
  GIT_PROMPT_END="\n \[\033[1;${foreground}m\]\[\033[${background}m\]\[\033[0m\]\[\033[0m\]  \[\033[32m\]\@\[\033[0m\]  "
}

prompt


# Aliases
# ls
alias l='ls -Glh'
alias ls='ls -Glh'
alias la='ls -Glah'
alias ls0="\ls | tr '\n' '\0'"
alias xargs='xargs -0'

# Experimental
# use nvim over vim
alias vim=nvim


export HOMEBREW_GITHUB_API_TOKEN=e7bfb679a52caa4fd1da5f60bcec6e2bf32b90dc

export NVM_DIR="/Users/david/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export ANDROID_HOME=~/Library/Android/sdk

PATH="~/Library/Android/sdk/tools:~/Library/Android/sdk/platform-tools:${PATH}"
PATH="/usr/local/opt/openvpn/sbin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
