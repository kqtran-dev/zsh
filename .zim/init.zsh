zimfw() { source /Users/k/.config/zsh/.zim/zimfw.zsh "${@}" }
zmodule() { source /Users/k/.config/zsh/.zim/zimfw.zsh "${@}" }
fpath=(/Users/k/.config/zsh/.zim/modules/zsh-completions/src /Users/k/.config/zsh/.zim/modules/prompt-pwd/functions /Users/k/.config/zsh/.zim/modules/git-info/functions ${fpath})
autoload -Uz -- prompt-pwd coalesce git-action git-info
source /Users/k/.config/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/k/.config/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/k/.config/zsh/.zim/modules/prompt/init.zsh
source /Users/k/.config/zsh/.zim/modules/eriner/eriner.zsh-theme
