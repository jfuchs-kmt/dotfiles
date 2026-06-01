" General
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set number
set laststatus=2
set ruler
set showmode
set splitright
set splitbelow

" Styling
colorscheme slate
set background=dark

" Tabs/Indent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" Search
set incsearch
set hlsearch

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Remaps - move with hjkl in insert and command mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Custom leader remap
nnoremap <SPACE> <Nop>
let mapleader = " "

" Fortran
let fortran_free_source=1
let fortran_do_enddo=1
let fortran_have_tabs=0
let fortran_more_precise=1

" Filetypes
autocmd BufRead,BufNewFile *.hip set filetype=cuda

" Change shape of cursor for different modes
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"
set ttimeout
set ttimeoutlen=10
