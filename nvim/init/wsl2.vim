" --------------------------------------------------
" win32yank(Windows Clipboard)
" --------------------------------------------------
let g:clipboard = {
    \   'name': 'win32yank-wsl',
    \   'copy': {
    \      '+': 'win32yank.exe -i',
    \      '*': 'win32yank.exe -i',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o',
    \      '*': 'win32yank.exe -o',
    \   },
    \   'cache_enabled': 1,
    \ }
