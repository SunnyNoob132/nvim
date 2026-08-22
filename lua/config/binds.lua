-- Ensure correct <leader> is set before declaring keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<D-Left>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<D-Down>", "<C-w>j", { desc = "Focus lower window" })
vim.keymap.set("n", "<D-Up>", "<C-w>k", { desc = "Focus upper window" })
vim.keymap.set("n", "<D-Right>", "<C-w>l", { desc = "Focus right window" })
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy UI" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Lazy sync" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Lazy update" })
