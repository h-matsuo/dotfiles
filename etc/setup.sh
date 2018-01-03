#!/bin/sh

# Download git-completion files and deploy them
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 2>/dev/null
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 2>/dev/null
mv git-prompt.sh "${HOME}/.git-prompt.sh"
mv git-completion.bash "${HOME}/.git-completion.bash"

# Link .gitconfig
if [ -f "${HOME}/.gitconfig" ]; then
  mv "${HOME}/.gitconfig"{,.org}
fi
ln -s "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"

# Link .bash_profile
if [ -f "${HOME}/.bash_profile" ]; then
  mv "${HOME}/.bash_profile"{,.org}
fi
ln -s "${DOTFILES_DIR}/.bash_profile" "${HOME}/.bash_profile"

# Link .bashrc
if [ -f "${HOME}/.bashrc" ]; then
  mv "${HOME}/.bashrc"{,.org}
fi
ln -s "${DOTFILES_DIR}/.bashrc" "${HOME}/.bashrc"

# macOS only
if [ "$(uname)" == "Darwin" ]; then

  # Run setup_macOS.sh
  . etc/setup_macOS.sh

fi
