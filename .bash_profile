################################################################################
# .bash_profile
# Author: Hiroyuki Matsuo <h-matsuo@ist.osaka-u.ac.jp>
# Reference: http://oxynotes.com/?p=5418
################################################################################

#==================================================
# Include '~/.bashrc'
#==================================================
if [ -n "$BASH_VERSION" ]; then # if running bash
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
