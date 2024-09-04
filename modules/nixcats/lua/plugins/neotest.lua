require("neotest").setup({
	adapters = {
		require("neotest-golang")({ go_test_args = { "-v", "-race", "-cover", "-count=1" } }),
	},
})

vim.keymap.set("n", "<leader>nt", "<cmd>Neotest summary<cr>", { desc = "Toggle neotest summary" })
