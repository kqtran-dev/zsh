if [[ $(uname) == "Darwin" ]]; then
    export ZIM_HOME='${HOME}/.config/zsh/.zim'
fi

zimfw() { source ${HOME}/.config/zsh/.zim/zimfw.zsh "${@}" }
zmodule() { source ${HOME}/.config/zsh/.zim/zimfw.zsh "${@}" }
fpath=(${HOME}/.config/zsh/.zim/modules/zsh-completions/src ${HOME}/.config/zsh/.zim/modules/prompt-pwd/functions ${HOME}/.config/zsh/.zim/modules/git-info/functions ${fpath})
autoload -Uz -- prompt-pwd coalesce git-action git-info
source ${HOME}/.config/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/.config/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.config/zsh/.zim/modules/prompt/init.zsh
source ${HOME}/.config/zsh/.zim/modules/eriner/eriner.zsh-theme
