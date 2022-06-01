-- shortcut functions to make key mappings
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

function vmap(shortcut, command)
    map('v', shortcut, command)
end

vim.g.mapleader = " "

-- explorer tree
nmap('<leader>e', ':NvimTreeToggle<cr>')

-- saving, quitting, closing
nmap('<leader>w', ':w<cr>')
nmap('<leader>q', ':q<cr>')
nmap('<leader>c', ':bd<cr>')
nmap('<leader>h', ':noh<cr>')

-- moving between windows using ctrl+hjkl
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- resize windows
-- TODO: figure out way to do it with ctrl+shift+hjkl
nmap("<C-Up>", ":resize -2<CR>")
nmap("<C-Down>", ":resize +2<CR>")
nmap("<C-Left>", ":vertical resize -2<CR>")
nmap("<C-Right>", ":vertical resize +2<CR>")

-- moving between tabs using shift+hl
nmap('H', 'gT')
nmap('L', 'gt')

-- commenting
vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', {})
vim.api.nvim_set_keymap('v', '<leader>/', 'gc', {})

-- moving lines up/down (like vscode)
nmap('<A-j>', ':m +1<cr>')
nmap('<A-k>', ':m -2<cr>')
-- can do it in insert mode too
imap('<A-j>', "<Esc>:m .+1<CR>==gi")
imap('<A-k>', "<Esc>:m .-2<CR>==gi")
-- moving blocks of code
vmap('<A-j>', ":m '>+1<CR>gv-gv")
vmap('<A-k>', ":m '<-2<CR>gv-gv")

-- better indenting
vmap('<', '<gv')
vmap('>', '>gv')
