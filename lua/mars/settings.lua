vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- This is for the signs that appear left to the line numbers
vim.o.signcolumn = 'yes'

-- This is stuff like for LSPs, where the stuff being shown to the screen is updated every
-- 250ms. The default is 4000
vim.o.updatetime = 250

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show a live feed of your subsitutions
vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.opt.colorcolumn = "100"

-- Already shown in mini.nvim
vim.o.showmode = false

vim.opt.swapfile = false

vim.o.confirm = true

-- Clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.wrap = false                               -- Don't wrap lines
vim.opt.autoread = true                            -- Auto reload files changed outside vim
