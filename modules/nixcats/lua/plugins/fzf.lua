local fzf = require("fzf-lua")
fzf.setup()

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fw", fzf.live_grep, { desc = "Find Word" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>gr", fzf.lsp_references, { desc = "Find references" })
vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "Find document symbols" })
vim.keymap.set("n", "<leader>dd", fzf.lsp_document_diagnostics, { desc = "Find document diagnostics" })
