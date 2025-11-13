-- Setting Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<Leader>E', vim.cmd.Ex, { desc = '[E]xplore' })
vim.keymap.set('n', '<Leader>c', ':bd!<CR>', { desc = '[C]lose buffer' })
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix list' })

vim.keymap.set('n', '<leader>v', ':vs<CR>', { desc = 'split [v]ertical' })
vim.keymap.set('n', '<leader>z', ':sv<CR>', { desc = 'split hori[z]ontal' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- vim.keymap.set({'v', 'n'}, '<leader>y', '"+y', { desc = '[y]ank to cb' })
vim.keymap.set('i', '<C-space>', '<C-x><C-o>', { desc = 'omni-completion' })
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "[P]aste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete without yanking" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<leader>s", ":s/", { desc = "[s]ubstitute" })
