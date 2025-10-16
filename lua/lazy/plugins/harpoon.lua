-- -- Giving this plug-in another shot
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = false,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[a]dd to harpoon" })
    vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "[e]xplore to harpoon" })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Buffer [1]" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Buffer [2]" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Buffer [3]" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Buffer [4]" })
  end,
}
