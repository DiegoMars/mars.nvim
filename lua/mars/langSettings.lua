-- For Astro files
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'astro', 'tsx', 'ts', 'css', 'js'},
  callback = function()
    vim.o_local.tabstop = 2
    vim.o_local.shiftwidth = 2
    vim.o_local.expandtab = true
  end,
})
