
# ----------------------------------------------------------------
# zplugin
# ----------------------------------------------------------------

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions

# ----------------------------------------------------------------
# 環境設定
# ----------------------------------------------------------------
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

if which /usr/local/bin/vim> /dev/null 2>&1; then
  export EDITOR='/usr/local/bin/vim'
  export VISUAL='/usr/local/bin/vim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi
export PAGER='less'

# bin
export PATH="$HOME/bin":"$PATH"

# emacs風bindkey
bindkey -e

# 色
autoload -Uz colors
colors

# neovim
export XDG_CONFIG_HOME=~/.config

# brew install coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin":"$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH=/usr/local/opt/findutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/findutils/libexec/gnuman:${MANPATH}

# fzf
export FZF_DEFAULT_OPTS="--no-sort --exact --cycle --multi --ansi --reverse --border --sync --bind=ctrl-t:toggle --bind=?:toggle-preview --bind=down:preview-down --bind=up:preview-up"

# ZPlugin/zsh_highlight
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[alias]=fg=green
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
ZSH_HIGHLIGHT_STYLES[function]=fg=green
ZSH_HIGHLIGHT_STYLES[command]=fg=green
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=underline
ZSH_HIGHLIGHT_STYLES[path_approx]=fg=yellow,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=none

# C-sを無効化
stty stop undef

# ----------------------------------------------------------------
# プロンプト
# ----------------------------------------------------------------

# Git連携
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
zstyle ':vcs_info:*' formats "%F{yellow}%f%F{green}%c%u%b%F{yellow}%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='👻 '
RPROMPT='%F{cyan}%n@${HOST}:%~%f ${vcs_info_msg_0_}'

# Enable typo correction
setopt correct
SPROMPT="(*'~')< Did you mean %B%F{cyan}%r%f%b? [nyae]: "

# ----------------------------------------------------------------
# alias
# ----------------------------------------------------------------

# vim
alias vin='() { vim $(ls $1 | fzf) }'
alias vim8='/usr/bin/vim'
alias vim=$EDITOR
alias view='() { $EDITOR -R $1 }' # viewコマンドは元々あるがviが使われる

alias zshrc='$EDITOR ~/.zshrc'
alias vimrc='$EDITOR ~/.vimrc'

alias ls='ls -F --color'
alias lsl='ls -l --color --time-style=+%Y-%m-%d\ %H:%M:%S'
alias tmux='tmux -2'
anytree () { pstree $(pidof $1 | sed -e "s/ /,/g"  | tr ',' '\n' | fzf) -U $2 }

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# 安全策
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# ゴミ箱付きrm
alias rmm='mv -t /tmp/garvage -b --suffix=.$(date +%Y%m%d)'

# リポジトリ検索
repo() {
  local list=''
  local SRC_DIR=~/src
  if which fd > /dev/null 2>&1; then
    list=$(fd '.git$' $SRC_DIR -t d -H)
  else
    list=$(find $SRC_DIR -regex '.*\.git$' -type d 2>/dev/null) # エラーメッセージを非表示にする
  fi
  dir=$(echo $list | sed -e 's@.git$@@'| fzf -q "$*"  --preview "tree -C {} | head -200")
  if [ -n "$dir" ]; then
    cd $dir
  fi
}

# grep
alias grep='grep --color=auto'

# メモスクリプト
alias memo="memo.py --config ~/Dropbox/plane/memo"
alias note="memo.py"
alias ncd='(){cd "$(memo.py --config)"}'

# 特定のコマンドを実行した時背景色を変える（終了したら戻る）
alias ssh-login='(){tmux select-pane -P "fg=colour15,bg=magenta"; ssh $1; tmux select-pane -P "fg=default,bg=default" }'

# CSV整形表示
if type "tty-table" > /dev/null 2>&1; then
  alias csvp='() { column $1 | tty-table}'
else
  alias csvp='() { column -s, -t $1 }'
fi

# Docker
docker_login() {
  local login_command=bash
  if [ $# = 2 ]; then login_command=$2 fi
  docker exec -it $1 $login_command
}
alias docker-login='docker_login $1 $2'

# プロジェクト固有
alias ui-start='foreman start -f Procfile.dev'
alias ss='bin/spring stop && direnv allow'

google() { open "https://www.google.com/search?q=${*}" }

wttr()
{
  local request="wttr.in"
  [ "$(tput cols)" -lt 125 ] && request+='?n'
  curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

# ----------------------------------------------------------------
# 補完
# ----------------------------------------------------------------

autoload -Uz compinit
compinit

# ほとんどの補完の定義を削除する。
# special contexts の定義のみ残す (see: man zshcompsys)
fix_comp_assoc() {
  local var=$1
  shift
    for key in "$argv[@]"; do
      case $key in
      -redirect-,\<,*) unset "${var}[$key]";;
      -redirect-,\>,*) unset "${var}[$key]";;
      -value-,-*) ;;
      -value-,*) unset "${var}[$key]";;
      -*) ;;
      *) unset "${var}[$key]";;
      esac
    done
}
fix_comp_assoc _comps        "${(k)_comps[@]}"
fix_comp_assoc _services     "${(k)_services[@]}"
fix_comp_assoc _patcomps     "${(k)_patcomps[@]}"
fix_comp_assoc _postpatcomps "${(k)_postpatcomps[@]}"

# ----------------------------------------------------------------
# fzf
# ----------------------------------------------------------------
function history-fzf() {
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf-tmux --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}
zle -N history-fzf
bindkey '^r' history-fzf

# ----------------------------------------------------------------
# fzf
# ----------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------------------------------------------------------
# anyenv
# ----------------------------------------------------------------

if [ -e "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# ----------------------------------------------------------------
# direnv
# ----------------------------------------------------------------

if which direnv > /dev/null; then
  eval "$(direnv hook zsh)" # direnv
fi

# ----------------------------------------------------------------
# go
# ----------------------------------------------------------------
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
