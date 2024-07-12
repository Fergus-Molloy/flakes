require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		lua = { "stylua" },
		nix = { "nixpkgs_fmt" },
		typescriptreact = { "prettier" },
		typescript = { "prettier" },
		javacriptreact = { "prettier" },
		javascript = { "prettier" },
		go = { "gofmt", "goimports-reviser" },
	},
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout = 500, lsp_fallback = true }
	end,
})
