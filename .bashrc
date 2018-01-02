################################################################################
# .bashrc
# Author: Hiroyuki Matsuo <h-matsuo@ist.osaka-u.ac.jp>
# Reference: http://oxynotes.com/?p=5418
################################################################################

#==================================================
# Set Aliases
#==================================================
if [ "$(uname)" == 'Darwin' ]; then     # macOS
  alias ls='ls -FG'
  export LSCOLORS=Gxfxcxdxbxegedabagacad
elif [ "$(uname)" == 'Linux' ]; then    # Linux
  alias ls='ls -F --color=auto'
fi

#==================================================
# Show Git Branch Name in Prompt
#==================================================
# NOTE: Must download 'git-prompt.sh' and 'git-completion.bash' at first
# $ wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
# $ wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
# $ mv git-prompt.sh ~/.git-prompt.sh
# $ mv git-completion.bash ~/.git-completion.bash
source ~/.git-prompt.sh
source ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

#==================================================
# Change Prompt
#==================================================
if [ -n "$SSH_CLIENT" ]; then
  PROMPT_SSH='\[\e[0;31m\][SSH] '
fi
export PS1="\[\e[0;32m\]\u \[\e[0;33m\]\w\[\e[0;36m\]\`__git_ps1\`\n${PROMPT_SSH}\[\e[0m\]\$ "
unset PROMPT_SSH

#==================================================
# Set Locale
#==================================================
export LC_ALL='ja_JP.utf8'
export LANG='ja_JP.utf8'
export LANGUAGE='ja_JP.utf8'
export LC_CTYPE='ja_JP.utf8'
export LC_NUMERIC='ja_JP.utf8'
export LC_TIME='ja_JP.utf8'
export LC_COLLATE='ja_JP.utf8'
export LC_MONETARY='ja_JP.utf8'
export LC_MESSAGES='ja_JP.utf8'
