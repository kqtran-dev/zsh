# zmodload zsh/zprof
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

# printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c' 
# commenting this out - causes tmux to hang 

# Detect OS and set clipboard alias accordingly
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    # WSL: Use clip.exe for clipboard
    alias copy="clip.exe"
    alias paste="powershell.exe Get-Clipboard"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: Use pbcopy and pbpaste for clipboard
    alias copy="pbcopy"
    alias paste="pbpaste"
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
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
}

bwc() {
  # Ensure a Bitwarden session is active
  if [[ -z "$BW_SESSION" ]]; then
    get_bw_session
  fi 

  if hash bw 2>/dev/null; then
    # Check if the master password is valid by listing items
    local filter="${1:-}"
    local bw_output

    if [[ -n "$filter" ]]; then
      # Use the `--search` option if a filter is provided
      bw_output=$(bw list items --search "$filter" 2>&1)
    else
      # Use the original command when no filter is provided
      bw_output=$(bw list items 2>&1)
    fi

    # Check for invalid master password
    if [[ "$bw_output" == *"Invalid master password."* ]]; then
      echo "Error: Invalid master password. Exiting."
      return 1
    fi

    # Check for empty output
    if [[ "$bw_output" == "[]" ]]; then
      echo "No matching items found. Exiting."
      return 1
    fi

    # Select an item from the filtered output
    local item_id=$(echo "$bw_output" |
      jq -r '.[] | "\(.name) | username: \(.login.username // "N/A") | id: \(.id)"' |
      fzf-tmux |
      awk '{print $(NF -0)}' |
      sed 's/\"//g')

    # Exit if no item was selected
    [[ -z "$item_id" ]] && return

    # Fetch the full item details
    local item=$(bw get item "$item_id" 2>/dev/null)

    # Extract the password
    local password=$(echo "$item" | jq -r '.login.password // empty')

    # Copy the password to the clipboard
    if [[ -n "$password" ]]; then
      echo "$password" | copy
      echo "Password copied to clipboard."
    else
      echo "No password found for this entry."
    fi
  else
    echo "Bitwarden CLI (bw) not installed or not in PATH."
    return 1
  fi
}



2fa() {
  # Ensure a Bitwarden session is active
  if [[ -z "$BW_SESSION" ]]; then
    get_bw_session
  fi 

  if hash bw 2>/dev/null; then
    # Check if the master password is valid by listing items
    local filter="${1:-}"
    local bw_output

    if [[ -n "$filter" ]]; then
      # Use the `--search` option if a filter is provided
      bw_output=$(bw list items --search "$filter" 2>&1)
    else
      # Use the original command when no filter is provided
      bw_output=$(bw list items 2>&1)
    fi

    # Check for invalid master password
    if [[ "$bw_output" == *"Invalid master password."* ]]; then
      echo "Error: Invalid master password. Exiting."
      return 1
    fi

    # Check for empty output
    if [[ "$bw_output" == "[]" ]]; then
      echo "No matching items found. Exiting."
      return 1
    fi

    # Select an item from the filtered output
    local item_id=$(echo "$bw_output" |
      jq -r '.[] | "\(.name) | username: \(.login.username // "N/A") | id: \(.id)"' |
      fzf-tmux |
      awk '{print $(NF -0)}' |
      sed 's/\"//g')

    # Exit if no item was selected
    [[ -z "$item_id" ]] && return

    # Fetch the TOTP and copy it to the clipboard
    local totp=$(bw get totp "$item_id" 2>/dev/null)
    if [[ -n "$totp" ]]; then
      echo "$totp" | copy
      echo "TOTP copied to clipboard."
    else
      echo "No TOTP found for this entry."
    fi
  else
    echo "Bitwarden CLI (bw) not installed or not in PATH."
    return 1
  fi
}

function ztop() {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ -n "$git_root" ]]; then
        zoxide query "$git_root" && cd "$git_root"
    else
        echo "Not inside a Git repository." >&2
    fi
}

export NODE_OPTIONS="--no-deprecation"

# removing this - what was this for?
# source ${HOME}/.rc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zprof
