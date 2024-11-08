" ==================================================
" Fern
" ==================================================

" 起動キー
nnoremap <leader>t :Fern . -drawer -toggle<CR>

" 設定
let g:fern#default_hidden=1
nnoremap <silent> <Leader>e :<C-u>:Fern . -reveal=% -drawer -toggle -width=42<CR>

function! s:init_fern() abort
  set nonumber
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
  nmap <buffer> <C-h> <C-w>h
  nmap <buffer> <C-j> <C-w>j
  nmap <buffer> <C-k> <C-w>k
  nmap <buffer> <C-l> <C-w>l
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

let g:fern_disable_startup_warnings = 1"
