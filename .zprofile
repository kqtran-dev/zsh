# default path
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
# possible paths
# paths=(
#     "${HOME}/.local/bin"
#     "$HOME/Library/Python/3.9"
#     "/opt/homebrew/bin"
#     "/snap/bin"
#     "/c/Windows/System32/"
#     "/c/Windows/System32/WindowsPowerShell/v1.0/"
# )

for p in "${paths[@]}"; do
    if [ -d "$p" ]; then
            export PATH="$p:$PATH"
        fi
done

# Detect OS
case "$(uname -s)" in
    Darwin)
        os="macos"
        ;;
    Linux)
        if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
            os="wsl"
        else
            os="linux"
        fi
        ;;
    *)
        os="unknown"
        ;;
esac

# Define OS-specific paths
paths=()

if [[ $os == "macos" ]]; then
    paths+=(
        "$HOME/.local/bin"
        "$HOME/Library/Python/3.9"
        "/opt/homebrew/bin"
        "/opt/homebrew/opt/coreutils/libexec/gnubin"
    )
elif [[ $os == "wsl" ]]; then
    paths+=(
        "$HOME/.local/bin"
        "/mnt/c/Windows/System32/"
        "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/"
    )
elif [[ $os == "linux" ]]; then
    paths+=(
        "$HOME/.local/bin"
        "/snap/bin"
    )
fi

# Add to PATH
for p in "${paths[@]}"; do
    if [ -d "$p" ]; then
        export PATH="$p:$PATH"
    fi
done
export LANGUAGE=en_US
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # changes for x3270
export LC_CTYPE=en_US.UTF-8
# export LC_ALL=C # changes for x3270

export EDITOR='nvim'
export VISUAL='nvim'


# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

source ${ZDOTDIR}/.zshrc

# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
PATH="/c/Windows/System32/:${PATH}"
PATH="/c/Windows/System32/WindowsPowerShell/v1.0:${PATH}"
export PATH
