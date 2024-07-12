-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v", "i", "t" }, "<F1>", "<Nop>", { silent = true })

-- center when searching or doing big jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

-- common tasks
vim.keymap.set("n", "<c-h>", "<cmd>nohl<cr>", { desc = "hide highlights" })
vim.keymap.set("n", "<leader>fm", "<cmd>Format<cr>", { desc = "Run formatter" })
vim.keymap.set("n", "<leader>ls", "<cmd>LspStart<cr>", { desc = "Start Lsp" })
vim.keymap.set("n", "<leader>ld", "<cmd>LspStop<cr>", { desc = "Stop Lsp" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Buffer movement
vim.keymap.set("n", "<leader>j", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>k", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "delete buffer" })

-- better pasting
vim.keymap.set("x", "p", "pgvy", { silent = true })
vim.keymap.set("x", "P", "Pgvy", { silent = true })
