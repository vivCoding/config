-- require('onedark').setup {
--     style = 'darker',
--     -- transparent = true,
-- }
-- require('onedark').load()
require('onedarker').setup()

require('lualine').setup()
require 'nvim-tree'.setup {}

-- dashboard stuff
local dashboard = require('alpha.themes.dashboard')

local version = vim.version()
local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch

-- Banner
local banner = {
    "                                                    ",
    "                                                    ",
    "                                                    ",
    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                    ",
    "                      " .. print_version,
    "                                                    ",
    "                                                    ",
}
dashboard.section.header.val = banner

local function footer()
    local datetime = os.date('%I:%M %m/%d/%Y')
    return print_version .. ' ' .. datetime
end

-- dashboard.section.footer.val = footer()

require('alpha').setup(dashboard.config)
