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

# use nvim over vim
alias vim=nvim

# docker
alias dco=docker-compose
alias dmc=docker-machine

# kubectl
alias ktops='kubectl --namespace="tops" '
alias kpp='kubectl --namespace="preprod" '

alias int-pepe='kubectl --namespace="tops" exec -ti $(kubectl --namespace="tops" get pod | grep -e "int-pepe-hcm-\d" | cut -f1 -d" ") '

alias nuke='rm -rf node_modules && npm cache clean && npm i && npm start'
alias clear_browserify_cache='rm .gulp/watchify-cache.json'

alias namelyset='echo "hcm.image.tag=$(git rev-parse HEAD | cut -c-7),hcm.global.assetsVersion=$(git rev-list --max-count=1 HEAD app/assets package.json | shasum | cut -c1-8)"'

vimd() {
  vim $(git diff --name-only develop)
}

# makes sure docker machine named "default" is up and running and env loaded
docker_running=$(docker-machine ls | grep default)
if [[ "$docker_running" == *"Stopped"* ]]
then
    docker-machine start default
    eval "$(docker-machine env default)"
    env | grep "DOCKER_HOST"
elif [[ "$docker_running" == *"Running"* ]]
then
    eval "$(docker-machine env default)"
fi

export HOMEBREW_GITHUB_API_TOKEN=e7bfb679a52caa4fd1da5f60bcec6e2bf32b90dc

export NVM_DIR="/Users/davidbella/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# chruby & autoswitching
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# teamocil autocomplete
# must come after RVM
complete -W "$(teamocil --list)" teamocil
