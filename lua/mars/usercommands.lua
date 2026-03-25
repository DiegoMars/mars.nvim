vim.api.nvim_create_user_command(
  'LI', -- The name of your command
  ':LspInfo',
  {
    desc = 'LspInfo'
  }
)

vim.api.nvim_create_user_command(
  'DT', -- DiagnosticsToggle
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end,
  {
    desc = 'Toggle diagnostics on/off'
  }
)
