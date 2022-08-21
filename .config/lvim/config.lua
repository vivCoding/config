--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.transparent_window = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-Left>"] = ":BufferLineMovePrev<cr>"
lvim.keys.normal_mode["<S-Right>"] = ":BufferLineMoveNext<cr>"

-- disable copying when changing or cutting
lvim.keys.normal_mode["c"] = { '"_c', noremap = true }
lvim.keys.normal_mode["C"] = { '"_C', noremap = true }
lvim.keys.normal_mode["x"] = { '"_x', noremap = true }
-- lvim.keys.normal_mode["d"] = { '"_d', noremap = true }
-- lvim.keys.normal_mode["D"] = { '"_D', noremap = true }

lvim.keys.visual_mode["c"] = { '"_c', noremap = true }
lvim.keys.visual_mode["C"] = { '"_C', noremap = true }
lvim.keys.visual_mode["x"] = { '"_x', noremap = true }
-- lvim.keys.normal_mode["d"] = { '"_d', noremap = true }
-- lvim.keys.visual_mode["D"] = { '"_D', noremap = true }

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["o"] = { ":SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings["z"] = { ":set wrap!<cr>", "Word Wrap" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["l"]["p"]["r"] = { ":Telescope lsp_references<cr>", "References" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    t = { "<cmd>TodoTrouble<cr>", "TODOs" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["s"]["t"] = { ":Telescope current_buffer_fuzzy_find<cr>", "Text" }
lvim.builtin.which_key.mappings["g"]["S"] = { ":Telescope git_status<cr>", "Status" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    'bash',
    'c',
    'cpp',
    'css',
    'fish',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'make',
    'python',
    "rust",
    'typescript',
    'tsx',
    'vim',
    'vue',
    'yaml'

}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
lvim.plugins = {
    { 'simrat39/symbols-outline.nvim' },
    {
        'folke/todo-comments.nvim',
        requires = "nvim-lua/plenary.nvim",
    },
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

local version = vim.version()
local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
-- using https://texteditor.com/multiline-text-art/
lvim.builtin.alpha.dashboard.section.header = {
    type = "text",
    val = {
        [[                                                                         ]],
        [[                                                                         ]],
        [[  __                                           __     __ __              ]],
        [[                                                                         ]],
        [[ |  \                                         |  \   |  \  \             ]],
        [[ | ▓▓      __    __ _______   ______   ______ | ▓▓   | ▓▓\▓▓______ ____  ]],
        [[ | ▓▓     |  \  |  \       \ |      \ /      \| ▓▓   | ▓▓  \      \    \ ]],
        [[ | ▓▓     | ▓▓  | ▓▓ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\]],
        [[ | ▓▓     | ▓▓  | ▓▓ ▓▓  | ▓▓/      ▓▓ ▓▓   \▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓]],
        [[ | ▓▓_____| ▓▓__/ ▓▓ ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓        \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓]],
        [[ | ▓▓     \\▓▓    ▓▓ ▓▓  | ▓▓\▓▓    ▓▓ ▓▓         \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓]],
        [[  \▓▓▓▓▓▓▓▓ \▓▓▓▓▓▓ \▓▓   \▓▓ \▓▓▓▓▓▓▓\▓▓          \▓    \▓▓\▓▓  \▓▓  \▓▓]],
        [[                                                                         ]],
        "                                  " .. print_version,
        [[                                                                         ]],
        [[                                                                         ]],
    },
    opts = {
        position = "center",
        hl = "Label",
    },
}

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0
-- lualine reconfig
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.options = {
    section_separators = { left = '', right = '' },
}
lvim.builtin.lualine.sections.lualine_z = { "location" }
lvim.builtin.lualine.inactive_sections.lualine_z = {}

-- symbols outline config
vim.g.symbols_outline = {
    auto_preview = false,
}

require("todo-comments").setup {}
require("trouble").setup {}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Additional misc settings

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

-- enable folding by default
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a' -- enable mouse click
vim.opt.termguicolors = true
