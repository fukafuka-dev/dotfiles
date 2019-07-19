"" setting
set fenc=utf-8

" color
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox

" バックアップファイルを作らない
set nobackup

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

" 現在の行を強調表示
set cursorline

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" インデントはスマートインデント
set smartindent

" 括弧入力時の対応する括弧を表示
set showmatch

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
nnoremap <Leader>w :w<CR>

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
"  Plug 'christoomey/vim-tmux-navigator'
  Plug 'yonchu/accelerated-smooth-scroll'
  Plug 'tpope/vim-rails'
  Plug 'cohama/lexima.vim'
  Plug 'vim-scripts/todo-txt.vim'
  Plug 'scrooloose/syntastic'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'morhetz/gruvbox', {'do': 'cp colors/* ~/.vim/colors/'}
call plug#end()

" autocmd
" vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace

" syntacstic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

