"" setting
set fenc=utf-8
set nocompatible
set wildmenu
set ambiwidth=double

" 一旦ファイルタイプ関連を無効化する
filetype off
filetype plugin indent off

" color
syntax enable
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme iceberg

" バックアップファイルを作らない
set nobackup
set nowritebackup

" スワップファイルを作らない
set noswapfile

" 編集中のファイルが変更されたら自動で読み直す
set autoread

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 入力中のコマンドをステータスに表示する
set showcmd

" クリップボードを有効にする
set clipboard+=unnamed

" backspece
set backspace=indent,eol,start

" 自動更新時間
set updatetime=500

" ビープ音消す
set vb t_vb=

" --------------------------------------------------
" 操作
" --------------------------------------------------

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" インデントはスマートインデント
set smartindent

" 新しいウインドウを下に開く
set splitbelow

" 新しいウィンドウを右に開く
set splitright

" スペルチェック言語
set spelllang=en,cjk

" --------------------------------------------------
" 表示
" --------------------------------------------------

" 行番号を表示
set number

if has('nvim')
  autocmd TermOpen * setlocal norelativenumber " terminal modeでの行番号非表示
  autocmd TermOpen * setlocal nonumber
endif

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" サインカラムを常に表示する
set signcolumn=yes

" 現在の行を強調表示
if has('nvim')
  set cursorline
endif
"
" 括弧入力時の対応する括弧を表示
set showmatch

" 対応括弧の表示秒数を3秒にする
set matchtime=3

" ステータスラインを常に表示
set laststatus=2
set expandtab
set tabstop=2
set shiftwidth=2

" カーソル設定
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

" --------------------------------------------------
" 検索
" --------------------------------------------------

" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch

" インタラクティブに置換検索する
if has('nvim')
  set inccommand=split
endif

" 検索パターンに大文字小文字を区別しない
set ignorecase

" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase

" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する。（有効:wrapscan/無効:nowrapscan）
set wrapscan
" 検索結果をハイライト
set hlsearch

"vimgrepすると新しいwindowで開く
autocmd QuickFixCmdPost *grep* cwindow

" --------------------------------------------------
" key bind
" --------------------------------------------------

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" インサートモードでも移動
"inoremap <c-d> <delete>
"inoremap <c-j> <down>
"inoremap <c-k> <up>
"inoremap <c-h> <left>
"inoremap <c-l> <right>

inoremap <c-c> <Esc>
inoremap jj <Esc>
inoremap っｊ <Esc>
vnoremap <c-c> <Esc>
"vnoremap jj <Esc>

" delete key
inoremap <c-d> <Del>

" 行頭、行末
nnoremap <c-a> 0
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>
nnoremap <c-e> $

" ウインドウ入れ替え(なるべくtmuxに寄せる)
nnoremap <silent> <c-w>{ <c-w><c-x>
nnoremap <silent> <c-w>} <c-w>x

" レジスタを汚さない削除
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" terminal
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> jj <C-\><C-n>

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <leader>w :w<CR>
nnoremap <leader>q :Sayonara<CR>

" --------------------------------------------------
" vim-plug
" --------------------------------------------------

call plug#begin()
  " lang
  Plug 'vim-ruby/vim-ruby'
  Plug 'elzr/vim-json'
  Plug 'posva/vim-vue'
  Plug 'othree/yajs.vim'
  Plug 'tpope/vim-rails'
  Plug 'callmekohei/vim-todoedit'

  " vim
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'yonchu/accelerated-smooth-scroll'
  Plug 'cohama/lexima.vim'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'kamykn/spelunker.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'itchyny/lightline.vim'
  Plug 'dense-analysis/ale'
    Plug 'maximbaz/lightline-ale'
  Plug 'bfredl/nvim-miniyank'
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Plug 'simeji/winresizer'
  Plug 'scrooloose/nerdtree'
  Plug 'docunext/closetag.vim'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
    Plug 'thinca/vim-partedit'
  Plug 'christoomey/vim-tmux-navigator'

  " color
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
call plug#end()

" --------------------------------------------------
" fzf-vim
" --------------------------------------------------

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>s :GFiles?<CR>

" --------------------------------------------------
" netrw
" --------------------------------------------------

" netrwは常にtree view
let g:netrw_liststyle = 3

" vでファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1

" oでファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" --------------------------------------------------
" vim-trailing-whitespace
" --------------------------------------------------

autocmd BufWritePre * :FixWhitespace

" --------------------------------------------------
" vim-json
" --------------------------------------------------

let g:vim_json_syntax_conceal = 0

" --------------------------------------------------
" ale
" --------------------------------------------------

let g:ale_javascript_eslint_use_global = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" --------------------------------------------------
" lightline/ale
" --------------------------------------------------

let g:lightline = {}

let g:lightline.colorscheme = 'wombat'

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

" --------------------------------------------------
"  NERDTree
" --------------------------------------------------
nnoremap <leader>t :NERDTreeToggle<CR>
" --------------------------------------------------
" OSXでの矩形yank&pasteのバグ
" --------------------------------------------------
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)


" --------------------------------------------------
"  vim-lsp
" --------------------------------------------------
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

" --------------------------------------------------
" ファイルタイプ関連を有効にする
" --------------------------------------------------
filetype plugin indent on

set synmaxcol=320
syntax enable

augroup vimrc-highlight
  au!
  au Syntax ruby if 1000 < col('$') | syntax off | endif
augroup END
