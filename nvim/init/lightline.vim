" --------------------------------------------------
" lightline
" --------------------------------------------------

let g:lightline = {}

let g:lightline.colorscheme = 'wombat'

" aleとの連携が前提
let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ }

let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ }

let g:lightline.component_function = {
\   'absolute_path': 'AbsolutePath'
\ }

let g:lightline.active = {
\   'left': [
\     ['mode', 'paste'],
\     ['readonly', 'absolute_path', 'modified']
\   ],
\  'right': [
\     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\     [ 'lineinfo' ],
\     [ 'percent' ],
\     [ 'fileformat', 'fileencoding', 'filetype' ]
\   ]
\ }

function! AbsolutePath()
  let a = substitute(expand('%:p'), $HOME, '~', '')
  if a == ""
    return 'none'
  elseif strlen(a) > 40
    return a[strlen(a)-40:]
  else
    return a
  endif
endfunction
