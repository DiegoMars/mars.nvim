return {
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
      vim.keymap.set('n', '<Leader>r', ':sp | term python %<CR>', { buffer = true, desc = '[R]un Python' })
    end,
  }),
}
