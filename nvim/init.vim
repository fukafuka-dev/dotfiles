" --------------------------------------------------
" vim-plug
" --------------------------------------------------

call plug#begin()
  " syntax highlight
  Plug 'mechatroner/rainbow_csv'
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'vim-python/python-syntax', { 'for': 'python' }
  Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
  Plug 'habamax/vim-asciidoctor'
  Plug 'hashivim/vim-terraform'

  " vim
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'luochen1990/rainbow'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-endwise'
  Plug 'docunext/closetag.vim'
  Plug 'LeafCage/yankround.vim'
  Plug 'itchyny/lightline.vim'

  Plug 'dense-analysis/ale'
    Plug 'maximbaz/lightline-ale'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/vim-easy-align'
  Plug 'KorySchneider/vim-trim'
  Plug 'glidenote/memolist.vim'

  " ui
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'airblade/vim-gitgutter'
  Plug 'viis/vim-bclose'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'simeji/winresizer'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'lambdalisue/fern.vim', { 'branch': 'main' }
  Plug 'lambdalisue/fern.vim'
  Plug 'miyakogi/seiya.vim'

  " outside tools
if has('mac')
  Plug 'github/copilot.vim'
endif

  " color
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'NLKNguyen/papercolor-theme'
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
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" --------------------------------------------------
" Color Scheme
" --------------------------------------------------
let g:seiya_auto_enable=1
set background=dark
colorscheme PaperColor
hi Normal guibg=NONE
hi LineNr guibg=NONE
hi VertSplit guibg=NONE
hi Special guibg=NONE
hi Identifier guibg=NONE
"colorscheme afterglow

" --------------------------------------------------
" markdown設定
" --------------------------------------------------
augroup update_markdown_syntax
  autocmd!
  autocmd FileType markdown syntax match markdownError '\w\@<=\w\@='
augroup END

" terminal(fzf含む)はcolorschemeが適用されない
if has('terminal') && exists('##ColorSchemePre')
  let g:terminal_ansi_colors = [
    \ "#e8e8e8", "#bb5653", "#909d62", "#eac179", "#7da9c7", "#b06597", "#8cdcd8", "#d8d8d8",
    \ "#626262", "#bb5653", "#909d62", "#eac179", "#7da9c7", "#b06597", "#8cdcd8", "#e8e8e8"
  \ ]

  augroup mycolorscheme
    autocmd!
    autocmd ColorSchemePre * unlet! g:terminal_ansi_colors
    autocmd ColorSchemePre * autocmd! mycolorscheme
  augroup END
endif

" --------------------------------------------------
" Basic
" --------------------------------------------------
set nobackup                    " ファイルを上書きする前にバックアップを作らない
set nowritebackup               " ファイルの上書きの前にバックアップを作り、バックアップは上書きに成功した後削除される
set noswapfile                  " スワップファイルを作らない
set autoread                    " 編集中のファイルが変更されたら自動で読み直す
set hidden                      " バッファが編集中でもその他のファイルを開けるように
set showcmd                     " 入力中のコマンドをステータスに表示する
"set clipboard+=unnamed          " クリップボードを有効にする
set clipboard+=unnamedplus
set backspace=indent,eol,start  " Ctrl-H, バックスペースを有効にする
set updatetime=500              " 自動更新時間
set vb t_vb=                    " ビープ音消す
set scrolloff=3                 " スクロール先が見えるようにする
set ttyfast                     " 高速ターミナル接続を行う(スクロールが重くなる対策)
set lazyredraw                  " マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)
set re=1                        " 正規表現のエンジン

" --------------------------------------------------
" 操作
" --------------------------------------------------

set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように
set smartindent         " インデントはスマートインデント
set splitbelow          " 新しいウインドウを下に開
set splitright          " 新しいウィンドウを右に開く
set spelllang=en,cjk    " スペルチェック言語
set autoindent          " 新しい行を開始した時インデントを合わせる
set diffopt+=vertical   " diffsplitした時、左右に開く
set formatoptions=q     " 自動改行をしない
let g:omni_sql_no_default_maps = 1 " ビルトインSQL補間を無効にする

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
set expandtab                " タブ文字の代わりにスペースを挿入
set tabstop=2                " タブ数を設定
set shiftwidth=2             " Shift + >> で何個タブを移動させるか
autocmd FileType markdown setlocal sw=2 sts=2 ts=2 et

" --------------------------------------------------
" 検索
" --------------------------------------------------

set incsearch                          " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase                         " 検索パターンに大文字小文字を区別しない
set smartcase                          " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set wrapscan                           " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する。
set hlsearch                           " 検索結果をハイライト
autocmd QuickFixCmdPost *grep* cwindow " vimgrepすると新しいwindowで開く

" 検索後のハイライト
hi Search ctermbg=brown

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
inoremap <c-ｃ> <Esc>
vnoremap <c-ｃ> <Esc>

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
nnoremap K <nop>
nnoremap L :redraw!<CR>

" terminal
if has('terminal')
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <silent> <C-g> <C-\><C-n>
endif

" --------------------------------------------------
" alias
" --------------------------------------------------

command Q q
command W w

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

" --------------------------------------------------
" netrw
" --------------------------------------------------
let g:netrw_liststyle=1 " ファイルツリーの表示形式、1にするとls -laのような表示になります
let g:netrw_sizestyle="H" " サイズを(K,M,G)で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S" " 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する

" --------------------------------------------------
" プラグイン別設定
" --------------------------------------------------

let splt = split(glob("~/.config/nvim/init/" . "*.vim"))
for file in splt
  execute 'source' file
endfor
