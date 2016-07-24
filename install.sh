#!/bin/sh
#
# Usage:
#
#    sh install.sh
#
# Environment variables: VERBOSE, CP, LN, MKDIR, RM, DIRNAME, XARGS.
#
#    env VERBOSE=1 sh install.sh
#
# DO NOT EDIT THIS FILE
# 
# This file is generated by rcm(7) as:
#
#   rcup -B 0 -g
#
# To update it, re-run the above command.
#
: ${VERBOSE:=0}
: ${CP:=/bin/cp}
: ${LN:=/bin/ln}
: ${MKDIR:=/bin/mkdir}
: ${RM:=/bin/rm}
: ${DIRNAME:=/usr/bin/dirname}
: ${XARGS:=/usr/bin/xargs}
verbose() {
  if [ "$VERBOSE" -gt 0 ]; then
    echo "$@"
  fi
}
handle_file_cp() {
  if [ -e "$2" ]; then
    printf "%s " "overwrite $2? [yN]"
    read overwrite
    case "$overwrite" in
      y)
        $RM -rf "$2"
        ;;
      *)
        echo "skipping $2"
        return
        ;;
    esac
  fi
  verbose "'$1' -> '$2'"
  $DIRNAME "$2" | $XARGS $MKDIR -p
  $CP -R "$1" "$2"
}
handle_file_ln() {
  if [ -e "$2" ]; then
    printf "%s " "overwrite $2? [yN]"
    read overwrite
    case "$overwrite" in
      y)
        $RM -rf "$2"
        ;;
      *)
        echo "skipping $2"
        return
        ;;
    esac
  fi
  verbose "'$1' -> '$2'"
  $DIRNAME "$2" | $XARGS $MKDIR -p
  $LN -sf "$1" "$2"
}
handle_file_ln "/Users/david/.dotfiles/Brewfile" "/Users/david/Brewfile"
handle_file_ln "/Users/david/.dotfiles/bash_profile" "/Users/david/.bash_profile"
handle_file_ln "/Users/david/.dotfiles/bitbar/worldclock.1s.sh" "/Users/david/.bitbar/worldclock.1s.sh"
handle_file_ln "/Users/david/.dotfiles/config/nvim/autoload/plug.vim" "/Users/david/.config/nvim/autoload/plug.vim"
handle_file_ln "/Users/david/.dotfiles/config/nvim/init.vim" "/Users/david/.config/nvim/init.vim"
handle_file_ln "/Users/david/.dotfiles/gitconfig" "/Users/david/.gitconfig"
handle_file_ln "/Users/david/.dotfiles/install.sh" "/Users/david/.install.sh"
handle_file_ln "/Users/david/.dotfiles/rcrc" "/Users/david/.rcrc"
handle_file_ln "/Users/david/.dotfiles/scripts/bash_colors.bash" "/Users/david/.scripts/bash_colors.bash"
handle_file_ln "/Users/david/.dotfiles/scripts/git-completion.bash" "/Users/david/.scripts/git-completion.bash"
handle_file_ln "/Users/david/.dotfiles/tmux.conf" "/Users/david/.tmux.conf"