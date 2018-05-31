"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

"" General {{{1

set nocompatible            " use Vim in more useful way
set clipboard=unnamed       " share clipboard with other systems

"set rtp+=~/.vim/vundle.git/
"call vundle#rc()
set rtp+=~/.vim/neobundle.vim
call neobundle#begin(expand('~/.vim/neobundle'))
nmap <Insert> :a!<CR>

""" Bundle
"Bundle "Bundle/desert.vim"
autocmd ColorScheme * hi Folded gui=bold term=standout ctermbg=Black ctermfg=DarkBlue guibg=Grey30 guifg=Grey80
autocmd ColorScheme * hi FoldColumn gui=bold term=standout ctermbg=Black ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
colorscheme desert
"colorscheme default

NeoBundle 'buftabs'
set laststatus=2
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1
let g:buftabs_active_highlight_group="Visual"
autocmd WinEnter * let w:original_statusline = matchstr(&statusline, "%=.*") | call Buftabs_enable()

map <ESC>[A <C-Up>
map <ESC>[B <C-Down>
map <ESC>[C <C-Right>
map <ESC>[D <C-Left>
"nmap <C-Up> :NERDTreeToggle<CR>
nmap <C-v> :Bclose<CR>
nmap <C-n> :bn<CR>
nmap <C-b> :bp<CR>
imap <C-Space> <C-x><C-o>

NeoBundle 'SuperTab'
NeoBundle 'AutoComplPop'
NeoBundle 'rbgrouleff/bclose.vim'

NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
autocmd FileType ruby set expandtab tabstop=2 shiftwidth=2 softtabstop=2
" fold
autocmd FileType ruby set foldmethod=indent foldlevel=2 foldcolumn=3

"Bundle 'davidhalter/jedi-vim'
NeoBundle 'jmcantrell/vim-virtualenv'
autocmd FileType python let b:did_ftplugin = 1

"pythoncomplete
NeoBundle 'pythoncomplete'
autocmd FileType python set omnifunc=pythoncomplete#Complete
"hi Pmenu ctermbg=0
"hi PmenuSel ctermbg=1
"hi PmenuSbar ctermbg=2
"hi PmenuThumb ctermfg=3
"hi SpellBad term=reverse ctermbg=6
"Bundle 'davidhalter/jedi-vim'
"let g:jedi#auto_initialization = 1
"let g:jedi#rename_command = "<leader>R"
"let g:jedi#popup_on_dot = 1
"autocmd FileType python let b:did_ftplugin = 1

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=4 shiftwidth=4 softtabstop=4

filetype plugin on
setlocal omnifunc=syntaxcomplete#Complete

"NeoBundle 'kevinw/pyflakes-vim'
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'python']
            \}
NeoBundle 'ivanov/vim-ipython'

NeoBundle 'thinca/vim-quickrun'
set splitright
nmap <C-e> :QuickRun<CR>
nmap <C-f> :only!<CR>
let g:quickrun_config = {}
let g:quickrun_config['ruby'] = {'command': 'rspec', 'cmdopt': "%{line('.')}", 'exec': ["bundle exec %c %s:%o"], 'outputter': 'buffered:target=buffer'}
let g:quickrun_config['cucumber'] = {'command': 'rspec', 'exec': ["bundle exec %c"]}

"AnsiEsc
"Bundle 'vim-scripts/AnsiEsc.vim'
"Bundle 'powerman/vim-plugin-AnsiEsc'

"Bundle "skwp/vim-rspec.git"
"let g:rspec_command = "!bundle exec rspec -f d -c --tty {spec}"

NeoBundle 'airblade/vim-gitgutter'
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

"haml
NeoBundle 'tpope/vim-haml'
autocmd FileType haml set expandtab tabstop=2 shiftwidth=2 softtabstop=2

"markdown
NeoBundle 'Markdown'
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'tpope/vim-markdown'
"Bundle 'tyru/open-browser.vim'
"Bundle 'thinca/vim-quickrun'
"let g:quickrun_config = {}
"let g:quickrun_config['markdown'] = {
"      \   'outputter': 'browser'
"      \ }

"Bundle 'nathanaelkane/vim-indent-guides'
"autocmd FileType python IndentGuidesEnable
"let g:indent_guides_start_level = 1
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd  ctermbg=1
"hi IndentGuidesEven ctermbg=4
"let g:indent_guides_guide_size = 1

"neocomplecache repo
"Bundle "Shougo/neocomplete.vim.git"
"inoremap <expr><Nul> "\<C-x>\<C-o>"

"jinja
NeoBundle "jinja"
autocmd BufNewFile,BufRead *.twig set filetype=htmljinja


"coffeescript
NeoBundle "kchmck/vim-coffee-script"
autocmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee

autocmd BufRead,BufNewFile Gemfile set filetype=ruby
autocmd BufRead,BufNewFile *.ruby set filetype=ruby
autocmd BufRead,BufNewFile *.json set filetype=javascript

autocmd FileType javascript set expandtab tabstop=2 shiftwidth=2 softtabstop=2
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 1
au BufRead,BufNewFile *.js set filetype=javascript.jsx

NeoBundle 'neomake/neomake'
autocmd! BufWritePost *.js Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

"NeoBundle 'scrooloose/syntastic'
"let g:syntastic_check_on_open=0
"let g:syntastic_check_on_save=1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_loc_list_height=6
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_mode_map = {
"      \ 'mode': 'active',
"      \ 'active_filetypes': ['javascript'],
"      \ 'passive_filetypes': []
"      \ }

"yaml
autocmd FileType yaml set expandtab tabstop=2 shiftwidth=2 softtabstop=2

call neobundle#end()

"ESC
imap <c-j> <esc>

"auto mkdir
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

"" Text Formatting {{{1

set autoindent              " automatic indent new lines
set smartindent             " be smart about it
inoremap # X<BS>#
set wrap                    " wrap lines
set sidescroll=5
set softtabstop=4
set shiftwidth=4
set shiftround
set tabstop=4
set expandtab               " expand tabs to spaces
set nosmarttab              " fuck tabs
set formatoptions+=n        " support for numbered/bullet lists
set textwidth=79            " wrap at 79 chars by default
if v:version >= 703
  setlocal colorcolumn=80
endif
set wrapmargin=0
set virtualedit=block       " allow virtual edit in visual block ..

"" Remapping {{{1

let mapleader=','           " Lead with ,
" Jump to vimrc
nnoremap <space><space> :<C-u>edit $HOME/.vimrc<CR>
" Reload vimrc setting
nnoremap <space>s       :<C-u>source $HOME/.vimrc<CR>
" Create new tab
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>

"" UI {{{1

set ruler                   " show the cursor position all the time
" highlight cursor line in current window{{{2
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine ctermbg=black
" }}}2
set showcmd                 " display incomplete commands
set number                  " line numbers
set nolazyredraw            " don't redraw while executing macros
set wildmenu                " turn on wild menu
set wildmode=list:longest,full
set cmdheight=1             " command line height
" Enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set shortmess=filtIoOA      " shorten messages
set report=0                " tell us about changes
set nostartofline           " don't jum to the start of line when scrolling
set showmatch               " brackets/braces that is
set matchtime=3             " duration to show matching brace (1/10 sec)
set laststatus=2            " The last window always have status line
set scrolloff=5             " Keep at least 5 lines above and below the cursor
set visualbell t_vb=        " No beep sound
" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats-=octal,hex
if has("mouse") " Enable the use of the mouse in all modes
  set mouse=a
endif

syntax on
"" Colorize {{{2


" highlight whitespaces
highlight WhitespaceEOL ctermbg=red
matc WhitespaceEOL /\s\+$/

" highlight comments
"highlight Comment ctermfg=DarkCyan

"" Backup {{{1

" backup current file, deleted afterwards
set nobackup
set writebackup
if !filewritable($HOME."/.vim-backup")
    call mkdir($HOME."/.vim-backup", "p")
endif
set backupdir=$HOME/.vim-backup
if !filewritable($HOME."/.vim-swap")
    call mkdir($HOME."/.vim-swap", "p")
endif
set directory=$HOME/.vim-swap

"" Search {{{1

set history=100             " keep 100 lines of command line histories
set ignorecase
set smartcase
set wrapscan                " Searches wrap around the end of the file
" While typing a search command, show where the pattern matches
set incsearch
set hlsearch                " highlighting matches
" turn off highlight by Esc x 2
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"" Character encoding {{{1

set encoding=utf-8          " Use utf-8
set termencoding=utf-8      " ..
set fileencodings=utf-8     " ..
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

"" Source {{{1


if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

