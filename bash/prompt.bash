
function xtitle {
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007"
}

todop() {
  if [[ ! -e $TODO ]]; then return; fi

  todos=$(grep -e "^-" $TODO \
      | grep -ve "\(@someday\|@cancelled\|@done\)" | grep -c "")
  if [ $todos != 0 ]; then
      echo -e "[⌘:$todos]"
  fi
}

# git prompt
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo -ne "$RED$BOLD+"
  fi
  echo -e "[${ref#refs/heads/}:$(git_prompt_short_sha)] $END"
}

function git_prompt_short_sha() {
  sha=$(git rev-parse --short HEAD 2> /dev/null) && echo "$sha"
}

export PS1="\[\033[G\]
$CYAN$BOLD\$(todop)$RED$BOLD\u$END@$YELLOW$BOLD\H$END in $GREEN$BOLD\w$END \$(git_prompt_info)
› "

