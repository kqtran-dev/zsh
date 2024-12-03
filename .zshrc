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

eval "$(zoxide init zsh)"

printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c' 

# Detect OS and set clipboard alias accordingly
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    # WSL: Use clip.exe for clipboard
    alias copy="clip.exe"
    alias paste="powershell.exe Get-Clipboard"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: Use pbcopy and pbpaste for clipboard
    alias copy="pbcopy"
    alias paste="pbpaste"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux: Use xclip for clipboard
    alias copy="xclip -selection clipboard"
    alias paste="xclip -selection clipboard -o"
fi

prompt_for_password() {
    echo -n "Enter your Bitwarden master password: "
    read -s BW_PASSWORD
    echo    # Move to the next line after input
}

get_bw_session() {
 if [[ -z "$BW_SESSION" ]]; then
        # Prompt for the master password
        prompt_for_password
        echo "Unlocking Bitwarden..."
        BW_SESSION=$(echo "$BW_PASSWORD" | bw unlock --raw)
        unset BW_PASSWORD
        export BW_SESSION="$BW_SESSION"
    fi
    # echo "$BW_SESSION"
}
bwcopy() {
    # BW_SESSION=$(get_bw_session)
    if [[ -z "$BW_SESSION" ]]; then
        get_bw_session
    fi 
  if hash bw 2>/dev/null; then
    bw get item "$(bw list items 2>/dev/null | jq '.[] | "\(.name) | username: \(.login.username) | id: \(.id)" ' | fzf-tmux | awk '{print $(NF -0)}' | sed 's/\"//g')" | jq '.login.password' | sed 's/\"//g' | copy
  fi
}
export NODE_OPTIONS="--no-deprecation"

# source ${HOME}/.rc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

