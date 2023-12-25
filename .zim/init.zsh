zimfw() { source /home/k/.config/zsh/.zim/zimfw.zsh "${@}" }
zmodule() { source /home/k/.config/zsh/.zim/zimfw.zsh "${@}" }
fpath=(/home/k/.config/zsh/.zim/modules/zsh-completions/src /home/k/.config/zsh/.zim/modules/prompt-pwd/functions /home/k/.config/zsh/.zim/modules/git-info/functions ${fpath})
autoload -Uz -- prompt-pwd coalesce git-action git-info
source /home/k/.config/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/k/.config/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/k/.config/zsh/.zim/modules/completion/init.zsh
source /home/k/.config/zsh/.zim/modules/prompt/init.zsh
source /home/k/.config/zsh/.zim/modules/asciiship/asciiship.zsh-theme
source /home/k/.config/zsh/.zim/modules/eriner/eriner.zsh-theme
