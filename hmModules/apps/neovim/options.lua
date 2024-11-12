-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.list = true
vim.bo.filetype = "on"
vim.opt.updatetime = 300

-- Indentations
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true

-- Style
vim.opt.colorcolumn = "80"
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Easy Split Navigation
-- nnoremap <C-J> <C-W><C-J>
-- nnoremap <C-K> <C-W><C-K>
-- nnoremap <C-L> <C-W><C-L>
-- nnoremap <C-H> <C-W><C-H>

-- Searching
vim.opt.smartcase = true

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = '/home/pan/.config/nvim/undodir'

-- Easy copy and pasting to external programs
-- map <C-y> "+yy
-- map <C-p> "+P

-- autocmd BufRead,BufNewFile *.md call WritingMode()
-- autocmd BufRead,BufNewFile *.tex call WritingMode()
-- autocmd BufRead,BufNewFile *.svx call WritingMode()

-- autocmd BufRead,BufNewFile *.py call PythonMode()

-- function! WritingMode()
  -- setlocal textwidth=80
  -- setlocal wrap linebreak nolist
  -- setlocal whichwrap+=<,>,h,l
  -- nnoremap j gj
  -- nnoremap k gk
  -- setlocal spell spelllang=en_us
-- endfunction
-- function! PythonMode()
  -- setlocal foldmethod=indent
  -- setlocal foldlevel=99
-- endfunction
