-- Need a different colorscheme, or make one with this tool eventually
-- return {
--   "tjdevries/colorbuddy.nvim",
--   config = function()
--     vim.cmd.colorscheme("gruvbuddy")
--   end
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
  },
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end
}

