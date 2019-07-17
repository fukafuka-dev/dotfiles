# 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=zsh
export TERM=xterm-256color

# 色
autoload -Uz colors
colors

# プロンプト
PROMPT="
%{${fg[magenta]}%}%~%{${reset_color}%}
[%{${fg[magenta]}%}%n%{${reset_color}%}]$ "

# alias
alias ls='ls -GF'
alias ui-start='foreman start -f Procfile.dev'
alias ss='bin/spring stop'

# memos
today_new_memo() {
  mkdir -p ~/workspace/memo/$(date "+%Y/%m")  
  vim ~/workspace/memo/$(date "+%Y/%m/%d.md")
}
alias nm='today_new_memo'
alias nmy='vim ~/workspace/memo/$(date -d "1 day ago" "+%Y/%m/%d.md")'

# 補完
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

# plugin
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2 
zplug load

# fzf
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

# 環境別設定を読み込む
load_zsh() {
  local x=$1
  ZSHHOME="${HOME}/${x}"

  if [ -d $ZSHHOME -a -r $ZSHHOME -a \
       -x $ZSHHOME ]; then
      for i in $ZSHHOME/*; do
          [[ ${i##*/} = *.zsh ]] &&
              [ \( -f $i -o -h $i \) -a -r $i ] && . $i
      done
  fi
}

echo 'load below'
load_zsh '.zsh_local'
