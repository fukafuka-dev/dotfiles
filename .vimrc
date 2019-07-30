"" setting
set fenc=utf-8
set nocompatible
set wildmenu
filetype plugin on

" color
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox

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

" 見た目系
" 行番号を表示
set number

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" Show gitgutter column always
set signcolumn=yes

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" always show signcolumns
set signcolumn=yes

" 現在の行を強調表示
set cursorline

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" インデントはスマートインデント
set smartindent

" 括弧入力時の対応する括弧を表示
set showmatch
" 対応括弧の表示秒数を3秒にする
set matchtime=3

" ステータスラインを常に表示
set laststatus=2
set expandtab
set tabstop=2
set shiftwidth=2

" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright

" spell check
set spelllang=en,cjk

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

" 検索関係
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
autocmd QuickFixCmdPost *grep* cwindow "vimgrepすると新しいwindowで開く

" キーバインド

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
vnoremap <c-c> <Esc>
"vnoremap jj <Esc>
"inoremap <C-@> <Esc> " tmuxとprefix被るから無理だった

" delete key
inoremap <c-d> <Del>

" 行頭、行末
nnoremap <c-a> 0
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>
nnoremap <c-e> $

" レジスタを汚さない削除
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>

" fzf-vim
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>s :GFiles?<CR>

" netrwは常にtree view
let g:netrw_liststyle = 3

" vでファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1

" oでファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

call plug#begin()
  Plug 'vim-ruby/vim-ruby'
  Plug 'posva/vim-vue'
  Plug 'othree/yajs.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'yonchu/accelerated-smooth-scroll'
  Plug 'tpope/vim-rails'
  Plug 'cohama/lexima.vim'
  Plug 'scrooloose/syntastic'
  Plug 'sekel/vim-vue-syntastic'
    Plug 'tpope/vim-pathogen'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'morhetz/gruvbox', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
    Plug 'thinca/vim-partedit'
  Plug 'kamykn/spelunker.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'callmekohei/vim-todoedit'
  Plug 'elzr/vim-json'
call plug#end()

" vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace

" syntacstic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'javascript', 'vue'] }
let g:syntastic_ruby_checkers = ['rubocop']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

" [syntacstic]eslint
execute pathogen#infect()
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif

" vim-json
let g:vim_json_syntax_conceal = 0
