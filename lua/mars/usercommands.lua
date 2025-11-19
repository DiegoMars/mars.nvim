vim.api.nvim_create_user_command(
  'LI', -- The name of your command
  ':LspInfo',
  {
    desc = 'LspInfo'
  }
)
