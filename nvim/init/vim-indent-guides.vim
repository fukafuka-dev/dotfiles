" --------------------------------------------------
" vim-indent-guides
" --------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
if &background ==# 'light'
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#cacaca ctermbg=black
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#d5d5d5 ctermbg=darkgray
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1a1a1a ctermbg=black
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2a2a2a ctermbg=darkgray
endif
