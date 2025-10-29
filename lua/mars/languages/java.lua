-- Lil set up for Java
-- Eventually will setup LSP here too
return {
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      require("which-key").add({
        { "<leader>r", group = "[r]un java"}
      })

      -- Small helper: open a horizontal split terminal and run a command
      local function term(cmd)
        vim.cmd("split | terminal " .. cmd)
        vim.cmd("startinsert")
      end

      -- 1) Compile (no tests) -> like your “build” button
      vim.keymap.set("n", "<leader>rc", function()
        local cmd = "mvn -DskipTests compile"
        term(cmd)
      end, { buffer = true, desc = "[r]un [c]ompile (skip tests)" })

      vim.keymap.set("n", "<leader>rt", function()
        local cmd = "mvn test"
        term(cmd)
      end, { buffer = true, desc = "[r]un [t]est" })

      vim.keymap.set("n", "<leader>rp", function()
        local cmd = "mvn -DskipTests package"
        term(cmd)
      end, { buffer = true, desc = "[r]run [p]ackage (skip tests)" })

      vim.keymap.set("n", "<leader>rr", function()
        local main = vim.b.java_main_class
        if not main or main == "" then
          main = vim.fn.input("Fully-qualified main class (e.g. com.example.App): ")
          if main == "" then return end
          vim.b.java_main_class = main
        end
        -- Ensure classes are compiled, then run
        local cmd = string.format('mvn -q compile exec:java -Dexec.mainClass="%s"', main)
        term(cmd)
      end, { buffer = true, desc = "[r]run [r]un (exec:java)" })
    end,
})
}
