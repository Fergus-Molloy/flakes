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
