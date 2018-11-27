################################################################################
# .bashrc
# Author: Hiroyuki Matsuo <h-matsuo@ist.osaka-u.ac.jp>
# Reference: http://oxynotes.com/?p=5418
################################################################################

#==================================================
# Set Aliases
#==================================================
if [ "$(uname)" == "Darwin" ]; then     # macOS
  alias ls="ls -FG"
  export LSCOLORS=Gxfxcxdxbxegedabagacad
elif [ "$(uname)" == "Linux" ]; then    # Linux
  alias ls="ls -F --color=auto"
fi

#==================================================
# Show Git Branch Name in Prompt
#==================================================
source "${HOME}/.git-prompt.sh"
source "${HOME}/.git-completion.bash"
GIT_PS1_SHOWDIRTYSTATE=true

#==================================================
# Change Prompt
#==================================================
if [ -n "$SSH_CLIENT" ]; then
  PROMPT_SSH="\[\e[0;31m\][SSH] "
fi
export PS1="\[\e[0;32m\]\u \[\e[0;33m\]\w\[\e[0;36m\]\`__git_ps1\`\n${PROMPT_SSH}\[\e[0m\]\$ "
unset PROMPT_SSH

#==================================================
# Set Locale
#==================================================
# export LC_ALL="ja_JP.utf8"
# export LANG="ja_JP.utf8"
# export LANGUAGE="ja_JP.utf8"
# export LC_CTYPE="ja_JP.utf8"
# export LC_NUMERIC="ja_JP.utf8"
# export LC_TIME="ja_JP.utf8"
# export LC_COLLATE="ja_JP.utf8"
# export LC_MONETARY="ja_JP.utf8"
# export LC_MESSAGES="ja_JP.utf8"

#==================================================
# Share bash_history between multiple terminals
# http://iandeth.dyndns.org/mt/ian/archives/000651.html
#==================================================

function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND="share_history;$PROMPT_COMMAND"
shopt -u histappend
export HISTSIZE=9999

#==================================================
# Include "~/.mybashrc"
#==================================================
if [ -f "${HOME}/.mybashrc" ]; then
  . "${HOME}/.mybashrc"
fi
