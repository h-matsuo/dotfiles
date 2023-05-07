# Homebrew
if [ -d /opt/homebrew ]
  fish_add_path /opt/homebrew/bin
  fish_add_path /opt/homebrew/sbin
end

# fuzzy finder (fzf)
if type fzf > /dev/null 2>&1
  set -U FZF_LEGACY_KEYBINDINGS 0
end

# fish-color-scheme-switcher (scheme)
if type scheme > /dev/null 2>&1
  scheme set monokai
end

# Fast Node Manager (fnm)
if type fnm > /dev/null 2>&1
  fnm env --use-on-cd | source
end

# direnv
if type direnv > /dev/null 2>&1
  direnv hook fish | source
end

# Java
if [ -f /usr/libexec/java_home ]
  set -g JAVA_HOME (/usr/libexec/java_home -F -v 20)
  fish_add_path "$JAVA_HOME/bin"
end

# Go
if type go > /dev/null 2>&1
  set -g GOPATH $HOME/go
  fish_add_path $GOPATH/bin
end

# starship
if type starship > /dev/null 2>&1
  starship init fish | source
end

# Aliases
if type exa > /dev/null 2>&1
  alias ls "exa --icons"
end

# mysql-client
if [ -d /opt/homebrew/opt/mysql-client/bin ]
  fish_add_path /opt/homebrew/opt/mysql-client/bin
end

# Docker Desktop
if [ -d '/Applications/Docker.app/Contents/Resources/bin' ]
  fish_add_path '/Applications/Docker.app/Contents/Resources/bin'
end

# Rust (rustup)
if [ -d "$HOME/.cargo/bin" ]
  fish_add_path "$HOME/.cargo/bin"
end

# Jetbrains
if [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]
  fish_add_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
end

# rbenv
if type rbenv > /dev/null 2>&1
  status --is-interactive; and rbenv init - fish | source
end

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]
  . "$HOME/google-cloud-sdk/path.fish.inc"
end

# tmux
if type tmux > /dev/null 2>&1
  # htop を実行した際に % が見えなくなる問題への対処
  # c.f. https://stackoverflow.com/questions/33386687
  # c.f. https://unix.stackexchange.com/questions/1045
  set -g TERM screen-256color

  # Start tmux
  if not set -q TMUX
    exec tmux
  end
end
