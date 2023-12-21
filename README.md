
git submodule update --init --recursive

git submodule foreach --recursive git fetch

git submodule foreach git merge origin master

stow -d ~/.config -t ~ zsh

git submodule add https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/.zprezto"


