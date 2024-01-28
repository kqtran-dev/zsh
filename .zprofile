# default path
export path=(
    '/usr/bin'
    '/bin'
    '/usr/sbin'
    '/sbin'
)

# possible paths
possible_paths=(
    "${HOME}.local/bin"
    "$HOME/Library/Python/3.9"
    "/opt/homebrew/bin"
    "/snap/bin"
)

for path in "${paths[@]}"; do
    if [ -d "$path" ]; then
        # Check if the directory is not already in PATH
        if [[ ":$PATH:" != *":$path:"* ]]; then
            PATH="$path:$PATH"
        fi
    fi
done

export LANGUAGE=en_US
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # changes for x3270
# export LC_ALL=C # changes for x3270

export EDITOR='nvim'
export VISUAL='nvim'


# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

source ${ZDOTDIR}/.zshrc
