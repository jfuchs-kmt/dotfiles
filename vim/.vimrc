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
nnoremap <leader>e :Ex<CR>

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

let s:plug_path = expand('~/.vim/autoload/plug.vim')
if filereadable(s:plug_path)
    call plug#begin()

    Plug 'tpope/vim-fugitive'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    call plug#end()

    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fh :History<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>fr :Rg<Space>

    if executable('fortls')
        augroup LspFortran
            autocmd!
            autocmd User lsp_setup call lsp#register_server({
                        \ 'name': 'fortls',
                        \ 'cmd': {server_info -> [
                        \   'fortls',
                        \   '--notify_init',
                        \   '--hover_signature',
                        \   '--hover_language=fortran',
                        \   '--use_signature_help',
                        \   '--autocomplete_no_snippets'
                        \ ]},
                        \ 'allowlist': ['fortran'],
                        \ })
        augroup END
    endif

    if executable('clangd')
        augroup LspClangd
            autocmd!
            autocmd User lsp_setup call lsp#register_server({
                        \ 'name': 'clangd',
                        \ 'cmd': {server_info -> [
                        \   'clangd',
                        \   '--background-index',
                        \   '--clang-tidy',
                        \   '--completion-style=detailed'
                        \ ]},
                        \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cuda'],
                        \ })
        augroup END
    endif

    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes

        if exists('+tagfunc')
            setlocal tagfunc=lsp#tagfunc
        endif

        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gs <plug>(lsp-document-symbol-search)
        nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> <leader>rn <plug>(lsp-rename)
        nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)
    endfunction

    augroup lsp_install
        autocmd!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END
endif


