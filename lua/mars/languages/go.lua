return {
  name = 'Go',
  filetypes = { 'go', 'gomod' },
  mason_tools = { 'gopls' },
  servers = {
    gopls = {}
  },
  on_filetype = function(bufnr)
    vim.bo[bufnr].tabstop = 4
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].expandtab = true

    local function term(cmd)
      vim.cmd('10split | terminal ' .. cmd)
      vim.cmd('startinsert')
    end

    require("which-key").add({
      { "<leader>r", group = "[r]un" }
    })

    vim.keymap.set('n', '<Leader>rr', function()
      term('go run .')
    end, { buffer = true, desc = '[R]un Go' })
    vim.keymap.set('n', '<Leader>rt', function()
      term('go mod tidy')
    end, { buffer = true, desc = '[R]un Tidy' })
  end,
}
