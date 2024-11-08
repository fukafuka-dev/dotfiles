" --------------------------------------------------
" vim-tmux-navigator
" --------------------------------------------------

if has('terminal')
  " ターミナルモードでもTmuxと同様のウインドウ移動をする
  tnoremap <silent> <C-h> <C-w>h
  tnoremap <silent> <C-j> <C-w>j
  tnoremap <silent> <C-k> <C-w>k
  tnoremap <silent> <C-l> <C-w>l
  tnoremap <silent> <C-w>p <C-w>"@
endif

