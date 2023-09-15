source ~/.config/zsh/.zshbegin
source ~/.config/zsh/.zshalias
source ~/.config/zsh/.zshgit
source ~/.config/zsh/.zshutils

HISTFILE=$HOME/.config/zsh/.zshhistory
HISTSIZE=20000
SAVEHIST=20000

autoload -U colors && colors
function update_prompt(){
  local gitbranch="$(git branch --show-current 2> /dev/null)"
  [[ -z $gitbranch ]] &&  PS1="%{$fg[black]$bg[blue]%} %~ %{$reset_color$fg[blue]%}
%{$fg[black]$bg[green]%}  %{$bg[black]$fg[green]%}%{$reset_color%} " && return
  local icon=" $gitbranch"
  PS1="%{$fg[black]$bg[blue]%} %~%{$reset_color$fg[blue]%}
%{$fg[black]$bg[green]%} $icon %{$reset_color$fg[green]%}%{$reset_color%} "
}
update_prompt

#the reaspon i had to lock access was because something like while loops would only run precmd
timelock="1"
function preexec(){
 exectime="$SECONDS"
 unset timelock
}

function precmd()
{
 local err="$?"
 update_prompt
 [[ $err != 0 ]] &&  echo "$bg[red]$fg[black]  $err $fg[red]$bg[black]"
 local took="$((SECONDS - exectime))"
 [[ -z $timelock ]] && [[ $took > 1 ]] && 
    echo "$bg[yellow]$fg[black] "$(date -d@$took -u "+%H:%M:%Shrs")" $bg[black]$fg[yellow]" 
     timelock="1"
}

TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

function command_not_found_handler(){
   echo "$1 command not found"
}

zshaddhistory() { 
   whence ${${(z)1}[1]} >| /dev/null || return 1 
}
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^I'   autosuggest-accept # tab          | autosuggest
bindkey '^[[Z' complete-word      # shift + tab  | complete

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=('[0-9]' fg=cyan)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-calc/zsh-calc.zsh
