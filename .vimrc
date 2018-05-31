"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed 
else
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif



" neobundle
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
" NeoBundleを'runtimepath'に追加し初期化を行う
if has('vim_starting')
execute "set runtimepath+=" . s:neobundle_root
endif
call neobundle#begin(expand(s:bundle_root))

" NeoBundle自身をNeoBundleで管理させる
NeoBundleFetch 'Shougo/neobundle.vim'

" 非同期通信を可能にする
" 'build'が指定されているのでインストール時に自動的に
" 指定されたコマンドが実行され vimproc がコンパイルされる
NeoBundle "Shougo/vimproc", {
\ "build": {
\   "windows"   : "make -f make_mingw32.mak",
\   "cygwin"    : "make -f make_cygwin.mak",
\   "mac"       : "make -f make_mac.mak",
\   "unix"      : "make -f make_unix.mak",
\ }}

" (ry

" インストールされていないプラグインのチェックおよびダウンロード
NeoBundleCheck

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/neomru.vim'
"let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> <C-y> :<C-u>Unite history/yank<CR>
nnoremap <silent> <C-j> :<C-u>Unite file_mru buffer<CR>

NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
nnoremap <C-h> :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  
  " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
  " 2013-08-14 追記
  let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction

NeoBundleLazy "mattn/gist-vim", {
      \ "depends": ["mattn/webapi-vim"],
      \ "autoload": {
      \   "commands": ["Gist"],
      \ }}

" vim-fugitiveは'autocmd'多用してるっぽくて遅延ロード不可
NeoBundle "tpope/vim-fugitive"
NeoBundleLazy "gregsexton/gitv", {
      \ "depends": ["tpope/vim-fugitive"],
      \ "autoload": {
      \   "commands": ["Gitv"],
      \ }}

NeoBundle 'vim-scripts/Align'

NeoBundleLazy "Shougo/neocomplete.vim", {
      \ "autoload": {
      \    "insert": 1,
      \ }}
let g:neocomplete#enable_at_startup = 1
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
let g:acp_enableAtStartup = 0
let g:neocomplet#enable_smart_case = 1
" NeoCompleteを有効化
" NeoCompleteEnable
endfunction

NeoBundle "scrooloose/syntastic", {
      \ "build": {
      \   "mac": ["pip install flake8", "npm -g install coffeelint"],
      \   "unix": ["pip install flake8", "npm -g install coffeelint"],
      \ }}

NeoBundle 'simnalamburt/vim-mundo'
nnoremap <C-g> :MundoToggle<CR>
set undofile
set undodir=~/.vim/undo

NeoBundleLazy "thinca/vim-quickrun", {
      \ "autoload": {
      \   "mappings": [['nxo', '<Plug>(quickrun)']]
      \ }}
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config = {
      \ "*": {"runner": "remote/vimproc"},
      \ }
endfunction

"lightline
set t_Co=256
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'base16'

" Color schema
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'tomasr/molokai'
syntax on
autocmd ColorScheme * highlight Comment ctermfg=111
autocmd ColorScheme * highlight LineNr ctermfg=244
autocmd ColorScheme * highlight NonText ctermfg=244

" Old customs
nmap <C-e> :QuickRun<CR>
nmap <C-f> :only!<CR>
nmap <C-n> :bn<CR>
nmap <C-b> :bp<CR>
map <ESC>[A <C-Up>
map <ESC>[B <C-Down>
map <ESC>[C <C-Right>
map <ESC>[D <C-Left>
let mapleader = "<Space>"

" Python
set smarttab
set expandtab
setlocal tabstop=4
setlocal shiftwidth=4
set virtualedit=block
set ambiwidth=double
let g:python_highlight_all = 1

call neobundle#end()

colorscheme iceberg
