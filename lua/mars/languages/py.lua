return {
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
      require("which-key").add({
        { "<leader>r", group = "[r]un java" }
      })

      vim.keymap.set('n', '<Leader>rr', ':sp | term python %<CR>', { buffer = true, desc = '[R]un Python' })
      vim.keymap.set('n', '<Leader>rt', ':sp | term python3 %<CR>', { buffer = true, desc = '[R]un Python3' })
    end,
  }),
}
