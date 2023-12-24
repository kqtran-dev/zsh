XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

ZDOTDIR="$HOME/.config/zsh"

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
