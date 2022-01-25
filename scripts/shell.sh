#!/bin/sh

echo "==> 🔗 Symlinking dotfiles to ~/"

ln -s ~/projects/personal/dotfiles/dotfiles/.aliases ~/.aliases
ln -s ~/projects/personal/dotfiles/dotfiles/.curlrc ~/.curlrc
# ln -s ~/projects/personal/dotfiles/dotfiles/.editorconfig ~/.editorconfig
ln -s ~/projects/personal/dotfiles/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/projects/personal/dotfiles/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/projects/personal/dotfiles/dotfiles/.hushlogin ~/.hushlogin
ln -s ~/projects/personal/dotfiles/dotfiles/.huskyrc ~/.huskyrc
# ln -s ~/projects/personal/dotfiles/dotfiles/.wgetrc ~/.wgetrc
ln -s ~/projects/personal/dotfiles/dotfiles/.zshrc ~/.zshrc
# ln -s ~/projects/personal/dotfiles/dotfiles/starship.toml ~/.config/starship.toml

echo "==> 📜 Setting Homebrew Zsh as default shell"

# Add Homebrew Zsh to accepted shells if not present
if ! grep -Fxq "$(which zsh)" /etc/shells > /dev/null 2>&1; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

# Set Homebrew Zsh as default shell
chsh -s "$(which zsh)"

echo "==> 📜 Installing Oh My Zsh and plugins"

# Clone Oh My Zsh
git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh

# Clone plugins to Oh My Zsh
git clone https://github.com/djui/alias-tips ~/.oh-my-zsh/custom/plugins/alias-tips
git clone https://github.com/mattberther/zsh-pyenv ~/.oh-my-zsh/custom/plugins/zsh-pyenv
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# echo "==> 🔗 Symlinking Google Drive scripts to ~/"

# ln -s ~/My\ Drive/Apps/scripts/ ~/scripts

# echo "==> 🔗 Creating Go folders in ~/"

# mkdir -p "$HOME/go/bin"
# # mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/src"

# Warn if .extra file is missing
if [ ! -f ~/.extra ]; then
  echo "==> ⚠️  WARNING: ~/.extra file was not found. Create this when setup completes to prevent notice on shell start"
fi