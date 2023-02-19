-- faster load times
require('impatient').enable_profile()

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'gruvbox_dark',
        component_separators = '|',
        section_separators = '',
    },
}

require('Comment').setup()

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

require('bufferline').setup {
    options = {
        separator_style = 'slant',
        diagnostics = "nvim_lsp",
        sort_by = 'directory',
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close', 'pin' }
        }
    }
}

require('toggleterm').setup {
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_terminals = false,
    autochdir = true,
    direction = 'float',
    float_opts = {
        border = 'curved',
        winblend = 3
    }
}

require('todo-comments').setup {
    search = {
        pattern = [[\b(KEYWORDS):?]]
    }
}

require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
-- to write lua snippets put them in $MYVIMRC/lua/user/snippets/<lang>.lua
-- then uncomment the line below changing the module to the appropriate paths
-- in those lua files simply `return { <snippets> }`
-- require('luasnip').add_snippets("<lang>" , require('user.snippets.<lang>'))
vim.keymap.set('i', '<c-c>', require('luasnip.extras.select_choice'), { noremap = true })
vim.keymap.set("i", "<C-f>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("s", "<C-f>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("i", "<C-d>", "<Plug>luasnip-prev-choice", {})
vim.keymap.set("s", "<C-d>", "<Plug>luasnip-prev-choice", {})
