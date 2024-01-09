zstyle ':zim:zmodule' use 'degit'

ZIM_HOME=${ZDOTDIR}/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

#binds 
bindkey "[D" backward-word
bindkey "[C" forward-word

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# python
bindkey ";3D" backward-word
bindkey ";5C" forward-word
# Initialize modules.
source ${ZIM_HOME}/init.zsh
source ${ZDOTDIR}/.aliases
