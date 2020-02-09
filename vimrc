
set nocompatible               " be iMproved

"==============================================================
"> vim-plug
"==============================================================

" Check if vim-plug installed
if empty(glob('~/.vim/autoload/plug.vim'))
    echo "Installing vim-plug..."
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'vim-scripts/L9'
    Plug 'othree/vim-autocomplpop'
    Plug 'ctrlpvim/ctrlp.vim'
    if has("python") || has("python3")
        Plug 'SirVer/ultisnips'
    endif
    Plug 'honza/vim-snippets'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'L4ys/molokai'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'sheerun/vim-polyglot'
    Plug 'msanders/cocoa.vim'
call plug#end()

"==============================================================
">  General
"==============================================================

" Sets how many lines of history VIM has to remember
set history=200

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set leader key to ','
let mapleader = ","

" Set utf8 as standard encoding
let $LANG="en_US.utf-8"
set encoding=utf-8
set fileencodings=usc-bom,utf-8,big5,taiwan,chinese,default,latin1

set nomodeline

"==============================================================
">  VIM user interface
"==============================================================
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class,*.obj

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" show cmd
set showcmd

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" u got a fast terminal
set ttyfast

" Prevent long line lag
set synmaxcol=512

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" hold shift to select and copy text
set mouse=a

" Always show status line
set laststatus=2

"==============================================================
">  Colors and Fonts
"==============================================================

" Enable syntax highlighting
syntax enable

set shortmess=atI      " remove start screen
set background=dark
set number
set cursorline

set t_Co=256
let g:rehash256 = 1

if filereadable(expand('~/.vim/plugged/molokai/colors/molokai.vim'))
    let g:molokai_original = 1
    colorscheme molokai
endif

"==============================================================
">  Files, backups and undo
"==============================================================

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set undodir=~/.vim/undo/
set undofile

"==============================================================
">  Text, tab and indent related
"==============================================================

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai   " Auto indent
set si   " Smart indent
set ci   " C indent

" Remove preview window
set completeopt-=preview

" Turn off expand tab in makefile
autocmd FileType make setlocal noexpandtab

" Indent 2 for html / css
autocmd BufNewFile,BufRead *.html,*.htm,*.css setlocal tabstop=2 shiftwidth=2

" Auto save and load fold setting
au BufWinLeave *.* silent mkview
au BufWinEnter *.* silent loadview

" Hightlight from start of file
au BufEnter * :syntax sync fromstart

"==============================================================
">  Moving around, tabs, windows and buffers
"==============================================================
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <leader><CR> :noh<CR>

" Open a newtab with file
noremap <leader>t :tabedit <C-R>=expand("%:p:h")<CR>

" Switch to next tab
noremap <leader><leader> :tabnext<CR>
" Switch to previous tab
noremap <leader>. :tabprevious<CR>

" Switch between tabs
for i in range(1, 9)
    exec 'nmap <leader>'.i.' '.i.'gt<CR>'
endfor

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

"==============================================================
">  Editing mappings
"==============================================================

" Remap VIM 0 to first non-blank character
map 0 ^
"==============================================================
">  Other
"==============================================================

" Auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Copy to system clipboard by Ctrl-C
if has("mac") || has("macunix")
    vmap <silent><C-c> :w !pbcopy<CR><CR>
    noremap <silent><leader>c :w !pbcopy<CR><CR>
elseif has("windows")
    vmap <silent><C-c> :w !clip<CR><CR>
    noremap <silent><leader>c :w !clip<CR><CR>
endif

" Daily routines
noremap <leader>z :w<CR><C-Z>
noremap <leader>w :w<CR>
noremap <leader>x :x<CR>
noremap <leader>q :q!<CR>

noremap <leader>e :edit <C-R>=expand("%:p:h")<CR>/

" Split with file
noremap <leader>s :split <C-R>=expand("%:p:h")<CR>/
noremap <leader>v :vsplit <C-R>=expand("%:p:h")<CR>/

" Redraw, useful in terminal when screen getr messed up
nnoremap <leader>rr :redraw!<CR>

" Replace tab with space
nnoremap <leader><tab> :%s/\t/    /g<CR>

" Remove trailing whitespace
nnoremap <leader><space> :%s/\s\+$//e<CR>:noh<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
noremap <leader>M :%s/\r/\r/g<CR>

" No space when join lines
nnoremap J gJ

" keep selection after indent
vnoremap < <gv
vnoremap > >gv

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Disable F1
noremap <F1> <Esc>

" <F2> toggles paste mode
set pastetoggle=<F2>

" <F3> toggles line number
noremap <silent> <F3> :set nu!<CR>
imap <silent><F3> <C-O><F3>

" <F4> toggles line wrap
noremap <silent> <F4> :set wrap!<CR>
imap <silent><F4> <C-O><F4>

" <F6> syntax sync
noremap <F6> <Esc>:syntax sync fromstart<CR>
imap <silent><F6> <C-O><F6>

" <F7> spelling check
noremap <silent> <F7> :set spell!<CR>
imap <silent><F7> <C-O><F7>

" <F10> toggles foldenable
noremap <silent> <F10> :set foldenable!<CR>
imap <silent> <F10> <C-O><F10>

"==============================================================
"> Plugins
"==============================================================

" ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$:|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.dat$'
    \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_switch_buffer = 'Et'

" leader + b to open buffer list with ctrlp
nmap <leader>b :CtrlPBuffer<CR>

" airline
set ttimeoutlen=50
set noshowmode

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#whitespace#enabled = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:polyglot_disabled = ['python']
