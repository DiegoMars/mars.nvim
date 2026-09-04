return {
  name = 'Python',
  filetypes = { 'python' },
  -- Currently, this give me a bunch of weird errors
  -- mason_tools = { 'basedpyright' },
  -- servers = {
  --   basedpyright = {
  --     analysis = {
  --       autoSearchPaths = true,
  --       diagnosticMode = "openFilesOnly",
  --       useLibraryCodeForTypes = true,
  --
  --       -- This is the default for pyright. Read more about it here:
  --       -- https://docs.basedpyright.com/latest/configuration/language-server-settings/#neovim:~:text=basedpyright.analysis.-,typeCheckingMode,-%5B%22off%22%2C%20%22basic%22%2C%20%22standard
  --       typeCheckingMode = "recommended"
  --     }
  --   },
  -- },
  on_filetype = function(bufnr)
    require("which-key").add({
      { "<leader>r", group = "[r]un python" }
    })

    vim.keymap.set('n', '<Leader>rr', ':sp | term python %<CR>', { buffer = true, desc = '[R]un Python' })
    vim.keymap.set('n', '<Leader>rt', ':sp | term python3 %<CR>', { buffer = true, desc = '[R]un Python3' })
  end,
}
