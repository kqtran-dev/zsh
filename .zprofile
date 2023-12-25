export path=(
    '/usr/bin'
    '/bin'
    '/usr/sbin'
    '/sbin'
)

if [[ "$OSTYPE" == darwin* ]]; then
    path+='/opt/homebrew/bin'
fi 

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # changes for x3270
# export LC_ALL=C # changes for x3270

export EDITOR='nvim'
export VISUAL='nvim'


# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

source ${ZDOTDIR}/.zshrc
