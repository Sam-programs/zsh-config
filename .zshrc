source ~/.config/zsh/.zshconfig
source ~/.config/zsh/.zshalias
source ~/.config/zsh/.zshgit
source ~/.config/zsh/.zshutils

HISTFILE=$HOME/.config/zsh/.zshhistory
HISTSIZE=20000
SAVEHIST=20000

autoload -U colors && colors
PS1="%{%B%}%{$fg[blue]%}%~%{$fg[green]%}"$'\n'"->%{$reset_color%}%{%b%} "


function command_not_found_handler(){
   echo "$1 command not found"
}

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^I'   autosuggest-accept # tab          | autosuggest
bindkey '^[[Z' complete-word      # shift + tab  | complete

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=('[0-9]' fg=cyan)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-calc/zsh-calc.zsh
