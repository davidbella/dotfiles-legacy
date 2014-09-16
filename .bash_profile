# Load local scripts
# provides git auto completion for git commands and branch names
if [ -f ~/.scripts/.git-completion.bash ]; then
  . ~/.scripts/.git-completion.bash
fi

# provides "__git_ps1" function for use in prompt
if [ -f ~/.scripts/.git-prompt.sh ]; then
  source ~/.scripts/.git-prompt.sh
fi

if [ -f ~/.scripts/.git-status-prompt.sh ]; then
  source ~/.scripts/.git-status-prompt.sh
fi

# easy to use bash colors
# clr_xxx "param"
if [ -f ~/.scripts/.bash_colors ]; then
  source ~/.scripts/.bash_colors
fi

# Set the bash prompt
function prompt() {
  function git_symbol() {
    if [ -d .git/ ]; then
      clr_green $(get_git_status)
    fi
  }

  function git_branch() {
    if [ -d .git/ ]; then
      echo -n "on "
      clr_red $(__git_ps1)
    fi
  }

  PS1="\n\$(clr_cyan \u) on \$(clr_brown \h) in \$(clr_blue \w)\
 \$(git_branch) \$(git_symbol) \n\
\[\033[35m\] \@ >> \[\033[0m\]";
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

# Some basic aliases
alias ls='ls -l'
alias cls='clear'

# Alias to open vimwiki fast
alias vimwiki='vim ~/vimwiki/index.wiki'

# Some git aliases
alias gst='git status'

# A bunch of stuff for RVM to work
PATH=/usr/local/bin/:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

EDITOR=vim

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc" # Load the default .bashrc

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Some common commands to remember

# Start postgresql with -D(ata) going to /usr/local/var/postgres
# postgres -D /usr/local/var/postgres

# Stop all running VMs in VirtualBox
# VBoxManage list runningvms | awk '{print $2;}' | xargs -I vmid VBoxManage controlvm vmid poweroff
