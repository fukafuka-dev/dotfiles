
" vim-plug
" --------------------------------------------------

call plug#begin()
  " lang
  Plug 'vim-ruby/vim-ruby'
  Plug 'elzr/vim-json'
  Plug 'posva/vim-vue'
  Plug 'othree/yajs.vim'
  Plug 'tpope/vim-rails'
  Plug 'junegunn/vim-journal'
  Plug 'leafgarland/typescript-vim'
  Plug 'zah/nim.vim'
  Plug 'tyru/eskk.vim'

" vim
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
  Plug 'tpope/vim-fugitive'
  Plug 'lilydjwg/colorizer'
  Plug 'osyo-manga/vim-over'
  Plug 'easymotion/vim-easymotion'

  " color
  Plug 'danilo-augusto/vim-afterglow', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'cormacrelf/vim-colors-github', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'morhetz/gruvbox', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'yasukotelin/shirotelin', {'do': 'cp colors/* ~/.vim/colors/'}
call plug#end()

"" setting
set fenc=utf-8
set nocompatible
set wildmenu
set ambiwidth=double

" --------------------------------------------------
" ファイルタイプ関連を有効にする
" --------------------------------------------------
syntax enable
filetype plugin indent on
set synmaxcol=200
colorscheme afterglow
set background=dark
"colorscheme github
"set background=light

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

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 楽なモード▼変更
inoremap <c-c> <Esc>
inoremap jj <Esc>
inoremap っｊ <Esc>
vnoremap <c-c> <Esc>

" Deleteキー
inoremap <c-d> <Del>

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

" terminal
if has('terminal')
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <silent> jj <C-\><C-n>
endif

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <leader>w :w<CR>

" ウィンドウとバッファが残ってる時は、ウインドウを残す
function! BufClose()
  if len(getbufinfo({'buflisted':1})) == 1 && len(getwininfo()) == 1
    :execute ':q'
  else
    :execute ':Bclose'
  endif
endfunction
nnoremap <silent> <leader>q :call BufClose()<cr>

" --------------------------------------------------
" alias
" --------------------------------------------------

command Q q

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

let g:netrw_preview = 1                       " プレビューウィンドウを垂直分割で表示する
let g:netrw_liststyle = 3                   " netrwは常にtree view
let g:netrw_altv = 1                        " vでファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_alto = 1                        " oでファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_winsize = 'equalalways'         " ウィンドウを等倍で開く

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
"" キーマップ
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
