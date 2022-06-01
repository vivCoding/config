-- searching options
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

-- sidebar
vim.opt.number = true -- line number on the left
vim.opt.numberwidth = 3 -- always reserve 3 spaces for line number
vim.opt.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.opt.modelines = 0
vim.opt.showcmd = true

vim.opt.syntax = 'on'
vim.opt.wildmode = { 'longest', 'list' }
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.cursorline = true

require('Comment').setup()
require("which-key").setup {}
