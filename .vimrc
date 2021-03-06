" Filetypes
filetype plugin on
filetype indent on

" Reload file when changed on disk
set autoread

" Default to UNIX line-endings
set ffs=unix,dos,mac

"Default to UTF8 encoding
set encoding=utf8

set nocompatible
set showcmd

" Indent
set autoindent
set smartindent

set backspace=2

" Line numbers
set number

" Search (Incremental and Highlight)
set incsearch
set hlsearch
set ignorecase
set smartcase

" Tab width to 4
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Use spaces instead of tabs
set expandtab
set smarttab

" Show matching brackets
set showmatch

" GUI
syntax enable
colorscheme molokai
let &t_Co=256

set foldmethod=marker

function! g:ToggleNuMode()
    if(&nu == 1)
        set nonu
    else
        set nu
    endif
endfunc

function! g:TogglePasteMode()
    if(&paste == 1)
        set nopaste
    else
        set paste
    endif
endfunc

nnoremap <C-L> :call g:ToggleNuMode()<cr>
nnoremap <C-P> :call g:TogglePasteMode()<cr>
