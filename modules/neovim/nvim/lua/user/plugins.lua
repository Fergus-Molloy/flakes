local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local util = require('packer.util');

-- Have packer use a popup window
packer.init {
    compile_path = util.join_paths(vim.fn.stdpath('data'), 'packer', 'packer-compiled.lua'),
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
        -- My plugins here
        use { "wbthomason/packer.nvim" } -- Have packer manage itself
        use { "numToStr/Comment.nvim" } -- comment things easier
        use { "nvim-lualine/lualine.nvim" } -- better powerline
        use { "lukas-reineke/indent-blankline.nvim" } -- add indent guides to all lines
        use { "tpope/vim-sleuth" } -- better git commands in vim
        use { "windwp/nvim-autopairs" }
        --use { "kyazdani42/nvim-tree.lua" } -- new nerd tree
        use { "akinsho/bufferline.nvim", requires = { 'kyazdani42/nvim-web-devicons' } } -- buffers are tabs now
        use { "akinsho/toggleterm.nvim", tag = "*" } -- quick access to terminal
        use { "lewis6991/impatient.nvim" } -- faster load times

        -- greeter
        use {
            'goolord/alpha-nvim',
            config = function()
                require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
            end
        }

        -- Colorschemes
        use { "morhetz/gruvbox" } -- best color scheme

        -- Autocompletion plugins
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'L3MON4D3/LuaSnip', --snippet engine
                'saadparwaiz1/cmp_luasnip'
            },
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            requires = {
                -- Automatically install LSPs
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'j-hui/fidget.nvim', -- status updates for lsp
                'folke/neodev.nvim', -- extra lua configs
            },
        }

        -- syntax hightlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                pcall(require('nvim-treesitter.install').update { with_sync = true })
            end,
        }
        -- more text objects
        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter'
        }

        -- Git
        use { "lewis6991/gitsigns.nvim" } -- show git changes by numbers
        use { "tpope/vim-fugitive" } -- better git commands in vim

        -- Fuzzy finder
        use {
            "nvim-telescope/telescope.nvim",
            tag = '0.1.1',
            requires = { 'nvim-lua/plenary.nvim' }
        }
        -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
        -- Use telescope to browse files
        use { "nvim-telescope/telescope-file-browser.nvim" }
        -- Use telescope to manage projects
        use { "nvim-telescope/telescope-project.nvim" }
        -- use telescope for the default vim.ui.select
        use { "nvim-telescope/telescope-ui-select.nvim" }
        -- Lua
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end)
