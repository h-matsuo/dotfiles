# History 関連の設定
HISTFILE="$HOME/.zsh_history" # ヒストリを保存するファイル
HISTSIZE=50000                # メモリに保存するヒストリの件数
SAVEHIST=50000                # ファイルに保存するヒストリの件数
setopt APPEND_HISTORY         # ヒストリファイルは上書きではなく追記
setopt HIST_IGNORE_ALL_DUPS   # 重複するヒストリは古い方を削除
setopt HIST_IGNORE_DUPS       # 直前と同じコマンドはヒストリに追加しない
setopt HIST_IGNORE_SPACE      # スペースで始めるとヒストリに追加しない
setopt HIST_REDUCE_BLANKS     # 余分なスペースを削除してヒストリに保存
setopt HIST_NO_STORE          # history コマンドはヒストリに追加しない
setopt INC_APPEND_HISTORY     # コマンド履歴を即座にヒストリファイルに追加
setopt SHARE_HISTORY          # プロセス間でヒストリを共有

# ヒストリに追加したくないコマンドのブラックリスト（正規表現）
HIST_BLACKLIST_REGEX=(
  '^cd'
  '^ls'
  '^brew home'
  '^brew info'
  '^brew search'
  '^brew uninstall'
  '^git branch -D'
  '^git commit'
  '^git push .*(-f|--force)'
  '^git reset .*--hard'
  '^git switch -c'
)

# 各コマンドを実行する直前に実行されるフック
# 戻り値が 0 以外ならヒストリに追加されない
zshaddhistory() {
  # ブラックリストに一致するコマンドはヒストリに追加しない
  for regex in "${HIST_BLACKLIST_REGEX[@]}"; do
    if [[ "$1" =~ $regex ]]; then
      return 1
    fi
  done
  return 0
}

# Homebrew
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  ## zsh-completions
  if [ -d $(brew --prefix)/share/zsh-completions ]; then
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

# mise (dev tools, env vars, task runner)
if command -v mise > /dev/null; then
  eval "$(mise activate zsh --shims)"
fi

# fuzzy finder (fzf)
if command -v fzf > /dev/null; then
  # Use new key bindings
  export FZF_LEGACY_KEYBINDINGS=0
  # '^r' for search command history
  if command -v awk > /dev/null; then
    function fzf-select-history() {
      BUFFER=$(history -n -r 1 | awk '!seen[$0]++' | fzf --query "$LBUFFER" --reverse)
      CURSOR=$#BUFFER
      zle reset-prompt
    }
    zle -N fzf-select-history
    bindkey '^r' fzf-select-history
  fi
fi

# starship
if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

# Jetbrains
if [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]; then
  export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
fi

# Aliases
if command -v eza > /dev/null; then
  alias ls='eza --icons'
fi
if command -v ghq > /dev/null; then
  alias cd-ghq='cd $(ghq list -p | fzf)'
fi
if command -v safe-rm > /dev/null; then
  alias rm='safe-rm'
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
