-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<esc>'] = actions.close,
                ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
            },
        },
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                width = vim.o.columns - 4,
                height = math.floor(vim.o.lines * 0.9),
                prompt_position = "bottom",
                preview_height = 0.6,
            },
        },
    },
    extensions = {
        file_browser = {
            grouped = true,
            hijack_netrw = true,
            mappings = {
                i = {
                    ['<a-d>'] = false,
                    ['<c-A>'] = require('telescope').extensions.file_browser.actions.create_from_prompt,
                    ['<c-s-d>'] = require('telescope').extensions.file_browser.actions.remove,
                    ['<c-r>'] = require('telescope').extensions.file_browser.actions.rename,

                }
            }
        },
        fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["ui-select"] = {
            require("telescope.themes").get_cursor {
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
-- Enable telescope file browser, if installed
pcall(require('telescope').load_extension, 'file_browser')
-- Enable telescope project management
pcall(require('telescope').load_extension, 'project')
-- Enable telescope as vim.ui.select
pcall(require('telescope').load_extension, 'ui-select')

local dropdown = require('telescope.themes').get_dropdown
--local ivy = require('telescope.themes').get_ivy

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(dropdown {
      winblend = 10,
      previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>ft', require('telescope.builtin').quickfix, { desc = '' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind in [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind in current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind in [D]iagnostics' })
vim.keymap.set('n', '<leader>fp', require('telescope').extensions.project.project, { desc = '[F]ind in [D]iagnostics' })
vim.keymap.set('n', '<leader>cd', function()
  require('telescope').extensions.file_browser.file_browser({ hidden = true, })
end, { noremap = true, desc = '[C]hange [D]irectory' })

vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
