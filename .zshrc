# Homebrew
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  ## zsh-completions
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
  fi

  ## zsh-autosuggestions
  if [ -d $(brew --prefix)/share/zsh-autosuggestions ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi

  ## zsh-syntax-highlighting
  if [ -d $(brew --prefix)/share/zsh-syntax-highlighting ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi

fi

# fuzzy finder (fzf)
if command -v fzf > /dev/null; then
  # Use new key bindings
  export FZF_LEGACY_KEYBINDINGS=0
  # '^r' for search command history
  function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
  }
  zle -N fzf-select-history
  bindkey '^r' fzf-select-history
fi

# starship
if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

# Aliases
if command -v eza > /dev/null; then
  alias ls='eza --icons'
fi
if command -v ghq > /dev/null; then
  alias cd-ghq='cd $(ghq list -p | fzf)'
fi

# tmux
if command -v tmux > /dev/null; then
  # htop を実行した際に % が見えなくなる問題への対処
  # c.f. https://stackoverflow.com/questions/33386687
  # c.f. https://unix.stackexchange.com/questions/1045
  export TERM=screen-256color

  # tmux の中では tmux を起動しない
  if [[ -z "$TMUX" ]]; then
    # セッションが起動済みなら attach; そうでないなら新しいセッションを開始
    # c.f. https://unix.stackexchange.com/questions/103898
    exec tmux new-session -A -s main
  fi
fi
