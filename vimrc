" --------------------------------------------------
" vim-plug
" --------------------------------------------------

call plug#begin()
  " lang
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-rails'
  Plug 'junegunn/vim-journal'

  " vim
  Plug 'luochen1990/rainbow'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-endwise'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'kamykn/spelunker.vim'
  Plug 'docunext/closetag.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'Yggdroot/indentLine'
  Plug 'LeafCage/yankround.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'dense-analysis/ale'
    Plug 'maximbaz/lightline-ale'
  Plug 'simeji/winresizer'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
    Plug 'thinca/vim-partedit'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'viis/vim-bclose'
  Plug 'junegunn/goyo.vim'
  Plug 'lilydjwg/colorizer'
  Plug 'easymotion/vim-easymotion'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'skanehira/vsession'

  " outside tools
  Plug 'ShikChen/osc52.vim'
  Plug 'tyru/eskk.vim'

  " color
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'changyuheng/color-scheme-holokai-for-vim'
call plug#end()

" setting
set nocompatible
set wildmenu
set ambiwidth=double
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" --------------------------------------------------
" ファイルタイプ/シンタックス
" --------------------------------------------------

syntax enable
filetype plugin indent on
set synmaxcol=300
set background=dark
colorscheme afterglow

" --------------------------------------------------
" Basic
" --------------------------------------------------

set nobackup                    " ファイルを上書きする前にバックアップを作らない
set nowritebackup               " ファイルの上書きの前にバックアップを作り、バックアップは上書きに成功した後削除される
set noswapfile                  " スワップファイルを作らない
set autoread                    " 編集中のファイルが変更されたら自動で読み直す
set hidden                      " バッファが編集中でもその他のファイルを開けるように
set showcmd                     " 入力中のコマンドをステータスに表示する
set clipboard+=unnamed          " クリップボードを有効にする
set backspace=indent,eol,start  " Ctrl-H, バックスペースを有効にする
set updatetime=500              " 自動更新時間
set vb t_vb=                    " ビープ音消す
set scrolloff=3                 " スクロール先が見えるようにする
set ttyfast                     " 高速ターミナル接続を行う(スクロールが重くなる対策)
set lazyredraw                  " マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)

" --------------------------------------------------
" 操作
" --------------------------------------------------

set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように
set smartindent         " インデントはスマートインデント
set splitbelow          " 新しいウインドウを下に開
set splitright          " 新しいウィンドウを右に開く
set spelllang=en,cjk    " スペルチェック言語
set autoindent          " 新しい行を開始した時インデントを合わせる

" --------------------------------------------------
" 表示
" --------------------------------------------------

set number                   " 行番号を表示
set list                     " 不可視文字を表示
set listchars=tab:>-,trail:- " 不可視文の表示記号を指定
set signcolumn=yes           " サインカラムを常に表示する
set showmatch                " 括弧入力時の対応する括弧を表示
set matchtime=3              " 対応括弧の表示秒数を3秒にする
set laststatus=2             " ステータスラインを常に表示
set expandtab                " タブ文字の代わりにスペースを▼挿入
set tabstop=2                " タブ数を▼設定
set shiftwidth=2             " Shift + >> で何個タブを移動させるか

" --------------------------------------------------
" 検索
" --------------------------------------------------

set incsearch                          " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase                         " 検索パターンに大文字小文字を区別しない
set smartcase                          " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set wrapscan                           " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する。
set hlsearch                           " 検索結果をハイライト
autocmd QuickFixCmdPost *grep* cwindow " vimgrepすると新しいwindowで開く

" --------------------------------------------------
" key bind
" --------------------------------------------------

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <leader>w :w<CR>

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 楽なモード変更
inoremap <c-c> <Esc>
vnoremap <c-c> <Esc>
"inoremap jj <Esc>
"inoremap っｊ <Esc>

" Deleteキー
inoremap <c-d> <Del>

" ウインドウ
nnoremap <leader>+ <C-w>_<C-w><Bar>
nnoremap <leader>= <C-w>=
nnoremap <leader>- :sp<CR>
nnoremap <leader>\ :vs<CR>

" ウインドウ入れ替え(なるべくtmuxに寄せる)
nnoremap <silent> <c-w>{ <c-w><c-x>
nnoremap <silent> <c-w>} <c-w>x

" レジスタを汚さない削除
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" ヤンク
nnoremap Y y$

" 誤動作防止
nnoremap Q q
nnoremap q <nop>

" manコマンドを引くとバグる
nnoremap K <nop>

nnoremap L :redraw!<CR>

" terminal
if has('terminal')
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <silent> <C-g> <C-\><C-n>
"  tnoremap <silent> jj <C-\><C-n>
endif

" --------------------------------------------------
" functions
" --------------------------------------------------

" ウィンドウとバッファが残ってる時は、ウインドウを残す
function! BufClose()
  if len(getbufinfo({'buflisted':1})) == 1 && len(getwininfo()) == 1
    :execute ':q'
  else
    :execute ':Bclose'
  endif
endfunction
nnoremap <silent> <leader>q :call BufClose()<cr>

function! CdCurrentDirectory()
  execute ':cd' expand('%:h')
  pwd
endfunction
command Cdc :call CdCurrentDirectory()

function! CdGitRootDirectory()
  try
    let path = system('git rev-parse --show-toplevel')
    execute ':cd' path
    pwd
  catch
    echo 'no git repository'
  endtry
endfunction
command Cdg :call CdGitRootDirectory()

" --------------------------------------------------
" alias
" --------------------------------------------------

command Q q
command W w

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

let g:netrw_preview = 1             " プレビューウィンドウを垂直分割で表示する
let g:netrw_liststyle = 3           " netrwは常にtree view
let g:netrw_altv = 1                " vでファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_alto = 1                " oでファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_winsize = 'equalalways' " ウィンドウを等倍で開く

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

" ALE付属のLSPを有効にする
" let g:ale_completion_enabled = 1

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint'],
      \ }

highlight link ALEErrorSign ErrorMsg
highlight link ALEWarningSign cStorageClass

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
"  Goyo
" --------------------------------------------------

let g:goyo_width=120

" --------------------------------------------------
" vim-journal
" --------------------------------------------------

augroup vim_journal
  autocmd!
  autocmd BufNewFile,BufRead *.md  set filetype=journal
  autocmd BufNewFile,BufRead *.txt  set filetype=journal
augroup END

" --------------------------------------------------
" indentLine
" --------------------------------------------------

let g:indentLine_char = '¦'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_term = 239

" --------------------------------------------------
"  vim-easy-align
" --------------------------------------------------

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" --------------------------------------------------
"  SKK
" --------------------------------------------------

let g:eskk#directory = "~/.eskk"
let g:eskk#dictionary = { 'path': "~/.eskk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }

" --------------------------------------------------
" yankround
" --------------------------------------------------

" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

"" 履歴取得数
let g:yankround_max_history = 50

" --------------------------------------------------
" vim-over
" --------------------------------------------------

" 専用のコマンドラインから入力しないといけない
nnoremap <silent> <Space>// :OverCommandLine<CR>%s/

" --------------------------------------------------
" vim-easymotion
" --------------------------------------------------

nmap s <Plug>(easymotion-s2)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)

" --------------------------------------------------
" vim-tmux-navigator
" --------------------------------------------------

if has('terminal')
  " ターミナルモードでもTmuxと同様のウインドウ移動をする
"  tnoremap <silent> <C-h> <C-\><C-n>:TmuxNavigateLeft<cr>
"  tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
"  tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
"  tnoremap <silent> <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
  tnoremap <silent> <C-h> <C-w>h
  tnoremap <silent> <C-j> <C-w>j
  tnoremap <silent> <C-k> <C-w>k
  tnoremap <silent> <C-l> <C-w>l
  tnoremap <silent> <C-w>p <C-w>"@
endif

" --------------------------------------------------
" https://qiita.com/kefir_/items/c725731d33de4d8fb096
" vim縦スクロールの高速化(検証中)
" --------------------------------------------------
" Use vsplit mode
if has("vim_starting") && !has('gui_running') && has('vertsplit')
  function! EnableVsplitMode()
    " enable origin mode and left/right margins
    let &t_CS = "y"
    let &t_ti = &t_ti . "\e[?6;69h"
    let &t_te = "\e[?6;69l\e[999H" . &t_te
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
  endfunction

  " old vim does not ignore CPR
  map <special> <Esc>[3;9R <Nop>

  " new vim can't handle CPR with direct mapping
  " map <expr> ^[[3;3R EnableVsplitMode()
  set t_F9=[3;3R
  map <expr> <t_F9> EnableVsplitMode()
  let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif


" --------------------------------------------------
"  luochen1990/rainbow
" --------------------------------------------------
let g:rainbow_active = 1


" --------------------------------------------------
"  vim-python/python-syntax
" --------------------------------------------------
let g:python_highlight_all = 1

" osc52.vim
" クリップボードにヤンクする
" --------------------------------------------------
vnoremap <leader>y y:call SendViaOSC52(getreg('"'))<CR>

" --------------------------------------------------
" vsession
" --------------------------------------------------
let g:vsession_use_fzf = 1

" --------------------------------------------------
"  vim-close-tag
" --------------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.php,*.vue'
