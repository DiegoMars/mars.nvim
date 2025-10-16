-- Setting Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<Leader>E', vim.cmd.Ex, { desc = '[E]xplore' })
vim.keymap.set('n', '<Leader>c', ':bd!<CR>', { desc = '[C]lose buffer' })
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({'v', 'n'}, '<leader>y', '"+y', { desc = '[y]ank to cb' })
