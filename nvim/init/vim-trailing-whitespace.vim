" --------------------------------------------------
" vim-trailing-whitespace
" --------------------------------------------------

function! StripTrailingWhitespace()
    if &ft =~ 'markdown'
        return
    endif
    :FixWhitespace
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

