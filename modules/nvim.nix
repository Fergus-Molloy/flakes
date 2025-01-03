{ config, pkgs, lib, ... }:
let
  cfg = config.packages.nvim-custom;
in
with lib;
{
  options.packages.nvim-custom = {
    enable = mkEnableOption (lib.mdDoc "neovim");
  };

  config = mkIf cfg.enable {
    # standard nvim
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [ stylua nixpkgs-fmt ];
      plugins = with pkgs.vimPlugins; [
        oil-nvim
        comment-nvim
        undotree
        vim-lastplace
        vim-sneak
        fzf-lua
        nvim-treesitter.withAllGrammars
        conform-nvim

        # colorschemes
        gruvbox-material
      ];
      extraLuaConfig =
        #lua
        ''
          vim.g.mapleader  = " "
          vim.g.maplocalleader  = " "

          vim.cmd.colorscheme("gruvbox-material")

          -- Better searching
          vim.o.hlsearch = true
          vim.o.smartcase = true
          vim.o.ignorecase = true
          vim.o.gdefault = true

          -- Minimal number of screen lines to keep above and below the cursor.
          vim.opt.scrolloff = 8
          vim.opt.sidescrolloff = 8
          vim.opt.cursorline = true
          vim.opt.colorcolumn = "100"

          -- Make line numbers default
          vim.wo.number = true
          vim.wo.relativenumber = true

          -- Enable mouse mode
          vim.o.mouse = "a"

          -- Indent
          -- stops line wrapping from being confusing
          vim.o.breakindent = true
          vim.o.expandtab = true
          vim.o.joinspaces = false
          vim.o.tabstop = 4
          vim.o.softtabstop = 4
          vim.o.shiftwidth = 4

          -- Save undo history
          vim.o.undofile = true

          -- Keep signcolumn on by default
          vim.wo.signcolumn = "yes"

          -- Decrease update time
          vim.o.updatetime = 250
          vim.o.timeoutlen = 300

          -- Set completeopt to have a better completion experience
          vim.o.completeopt = "menuone,noselect,popup"

          -- NOTE: You should make sure your terminal supports this
          vim.o.termguicolors = true

          -- do not sync OS clipboard
          vim.o.clipboard = ""

          -- use this font
          vim.o.guifont = "JetBrains Mono:h16"

          -- don't show mode in command bar
          vim.o.showmode = false

          -- split in sane directions
          vim.o.splitbelow = true
          vim.o.splitright = true

          -- [[ Highlight on yank ]]
          -- See `:help vim.highlight.on_yank()`
          local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
          vim.api.nvim_create_autocmd("TextYankPost", {
          	callback = function()
          		vim.highlight.on_yank()
          	end,
          	group = highlight_group,
          	pattern = "*",
          })

          -- Keymaps for better default experience
          vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
          vim.keymap.set({ "n", "v", "i", "t" }, "<F1>", "<Nop>", { silent = true })
          vim.keymap.set("n", "<c-h>", "<cmd>nohl<cr>", { desc = "hide highlights" })

          -- center when searching or doing big jumps
          vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
          vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
          vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
          vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

          -- Remap for dealing with word wrap
          vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
          vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

          -- Buffer movement
          vim.keymap.set("n", "<leader>j", "<cmd>bprev<CR>", { desc = "Previous buffer" })
          vim.keymap.set("n", "<leader>k", "<cmd>bnext<CR>", { desc = "Next buffer" })
          vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>", { desc = "Last buffer" })
          vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
          vim.keymap.set("n", "<c-w>b", "<cmd>w<bar>%db<bar>e#<bar>bd#<CR>", { desc = "Delete all buffers apart from current" })

          -- better pasting
          vim.keymap.set("x", "p", "pgvy", { silent = true })
          vim.keymap.set("x", "P", "Pgvy", { silent = true })

          -- disable annoying keybind
          vim.keymap.set("n", "q:", "<nop>", { silent = true })

          local configs = require("nvim-treesitter.configs")
          configs.setup({
          	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          	auto_install = false,

          	highlight = { enable = true },
          	indent = { enable = true },
          })
                require("oil").setup({
          	skip_confirm_for_simple_edits = true,
          })
          vim.keymap.set("n", "<leader>fo", "<cmd>Oil --float<cr>", { desc = "Folder Open" })
                require("conform").setup({
          	formatters_by_ft = {
          		lua = { "stylua" },
          		nix = { "nixpkgs_fmt" },
          	},
          	format_on_save = function(bufnr)
          		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          			return
          		end
          		local cwd = vim.fn.getcwd()
          		if string.find(cwd, "cashout") then
          			return
          		end
          		return { timeout = 500, lsp_fallback = true }
          	end,
          })

          vim.api.nvim_create_user_command("FormatToggle", function(args)
          	local toggleOff = false
          	if vim.g.disable_autoformat then
          		vim.g.disable_autoformat = false
          		toggleOff = true
          	end
          	if vim.b.disable_autoformat then
          		vim.b.disable_autoformat = false
          		toggleOff = true
          	end

          	if not toggleOff then
          		if args.bang then
          			vim.b.disable_autoformat = true
          		else
          			vim.g.disable_autoformat = true
          		end
          	end
          end, {
          	desc = "Toggle autoformatting on save",
          	bang = true,
          })

          -- Create a command `:Format`
          vim.api.nvim_create_user_command("Format", function(args)
          	require("conform").format({ bufnr = args.buf })
          end, { desc = "Format current buffer with conform" })

          -- Format keymap
          vim.keymap.set("n", "<leader>fm", "<cmd>Format<cr>", { desc = "Run formatter" })
          			'';
    };
  };
}

# vim: sw=2 ts=2
