source ~/.config/zsh/.zshbegin
source ~/.config/zsh/.zshalias
source ~/.config/zsh/.zshgit
source ~/.config/zsh/.zshutils

HISTFILE=$HOME/.config/zsh/.zshhistory
HISTSIZE=20000
SAVEHIST=20000

autoload -U colors && colors

fg_black="%{$fg[black]%}"
fg_red="%{$fg[red]%}"
fg_blue="%{$fg[blue]%}"
fg_green="%{$fg[green]%}"

bg_black="%{$bg[black]%}"
bg_red="%{$bg[red]%}"
bg_blue="%{$bg[blue]%}"
bg_green="%{$bg[green]%}"
preset_color="%{$reset_color%}"

function update_prompt(){
  local gitbranch="$(git branch --show-current 2> /dev/null)"
  local icon=" $gitbranch "
  [[ -z $gitbranch ]] && icon=" "
  PS1="$fg_black$bg_blue %~%  $preset_color$fg_blue
$fg_black$bg_green $icon$preset_color$fg_green$preset_color "
}
update_prompt

#the reaspon i had to lock access was because something like while loops would only run precmd
timelock="1"
function prompt_preexec(){
   exectime="$SECONDS"
   unset timelock
}

function prompt_precmd(){
   local err="$?"
   update_prompt
   local took="$((SECONDS - exectime))"
   [[ -z $timelock && $took > 1 ]] && 
      echo "$bg[magenta]$fg[black] "$(date -d@$took -u "+%Hh:%Mm:%Ss")" $bg[black]$fg[magenta]$reset_color"
   timelock="1"
   [[ $err != 0 ]] &&  
      echo "$bg[red]$fg[black]  $err $fg[red]$bg[black]$reset_color"
}
preexec_functions=($preexec_functions prompt_preexec)
precmd_functions=($precmd_functions prompt_precmd)


TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

function command_not_found_handler(){
   echo "$1 command not found"
}

function zshaddhistory() { 
   whence ${${(z)1}[1]} >| /dev/null || return 1 
}

export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^I'   autosuggest-accept # tab          | autosuggest
bindkey '^[[Z' complete-word      # shift + tab  | complete

# something unbinds these 2 mappings
bindkey '^N' down-history
bindkey '^P' up-history

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=('[0-9]' fg=cyan)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main regexp)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-calc/zsh-calc.zsh

# make clear ignore all options
function clear(){
   /usr/bin/clear
}
# for zsh-hilight
function c(){
   /usr/bin/clear
}

local old_accept_line=${widgets[accept-line]#*:}
[[ $old_accept_line = 'builtin' ]] && 
   old_accept_line='zle accept-line'

function clear_accept_line(){
   [[ $BUFFER =~ '^clear$' || $BUFFER =~ '^c$'  ]] && 
      zle .clear-screen && 
      BUFFER= &&
      return
   eval $old_accept_line
}

zle -N accept-line clear_accept_line
