syntax on
let mapleader =" "
set encoding=utf-8
set nocompatible
filetype plugin on
set list

set updatetime=300

" Easy Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Indentation
" set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab
set tabstop=8 softtabstop=0 shiftwidth=8

" Searching
set smartcase

" Backups
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile

" Right column at 80 lines for good coding practice.
set colorcolumn=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" QoL
set showmatch " Show matching Brackets
set number relativenumber " Side numbers

" Fuzzy finding by allowing searching into subfolders
set path+=**
set wildmenu
" use :find to find, and * to make it fuzzy.
" Also make use of :b.

" Delete trailing white space and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Easy copy and pasting to external programs
map <C-y> "+yy
map <C-p> "+P

autocmd BufRead,BufNewFile *.md call WritingMode()
autocmd BufRead,BufNewFile *.tex call WritingMode()
autocmd BufRead,BufNewFile *.svx call WritingMode()

autocmd BufRead,BufNewFile *.py call PythonMode()

function! WritingMode()
  setlocal textwidth=80
  setlocal wrap linebreak nolist
  setlocal whichwrap+=<,>,h,l
  nnoremap j gj
  nnoremap k gk
  setlocal spell spelllang=en_us
endfunction
function! PythonMode()
  setlocal foldmethod=indent
  setlocal foldlevel=99
endfunction
