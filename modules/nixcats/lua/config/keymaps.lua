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
