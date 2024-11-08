" --------------------------------------------------
" ale
" --------------------------------------------------

let g:ale_javascript_eslint_use_global = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_virtualtext_cursor = 'disabled'

" ALE付属のLSPを有効にする
" let g:ale_completion_enabled = 1

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint', 'tsserver'],
      \ }

" エラーの色を暗めの色に設定
highlight ALEError ctermbg=darkred
highlight ALEWarning ctermbg=darkblue
highlight link ALEStyleError ALEError
highlight link ALEStyleWarning ALEWarning
