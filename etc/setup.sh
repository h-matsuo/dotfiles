#!/bin/sh

# Download git-completion files and deploy them
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 2>/dev/null
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 2>/dev/null
mv git-prompt.sh "${HOME}/.git-prompt.sh"
mv git-completion.bash "${HOME}/.git-completion.bash"

# Link .gitconfig
if [ -f "${HOME}/.gitconfig" ]; then
  rm "${HOME}/.gitconfig"
fi
ln -s "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"

# Link .bashrc
if [ -f "${HOME}/.bashrc" ]; then
  rm "${HOME}/.bashrc"
fi
ln -s "${DOTFILES_DIR}/.bashrc" "${HOME}/.bashrc"

# macOS only
if [ "$(uname)" == "Darwin" ]; then

  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Inatall Hombrew Cask
  brew tap caskroom/cask

  # Install development tools
  brew install bash git wget tree

  # Install development apps
  brew cask install sublime-text docker virtualbox vagrant

  # Install development fonts
  brew cask install font-myrica

fi
