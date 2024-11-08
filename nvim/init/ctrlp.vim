" --------------------------------------------------
" ctrlp
" --------------------------------------------------
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|vendor/|tmp/'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <leader>p :<C-u>CtrlP<CR>
let g:ctrlp_map = '<Nop>'
