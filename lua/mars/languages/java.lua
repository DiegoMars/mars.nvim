-- Lil set up for Java
-- Eventually will setup LSP here too
return {
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true

      require("which-key").add({
        { "<leader>r", group = "[r]un java" }
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
        local cmd = "mvn -q test"
        term(cmd)
      end, { buffer = true, desc = "[r]un [t]est" })

      vim.keymap.set("n", "<leader>rp", function()
        local cmd = "mvn -DskipTests package"
        term(cmd)
      end, { buffer = true, desc = "[r]run [p]ackage (skip tests)" })

      vim.keymap.set("n", "<leader>rr", function()
        -- derive FQCN: <package>.<Filename>
        local fname = vim.fn.expand("%:t:r")
        -- scan the first ~50 lines for `package ...;`
        local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(50, vim.api.nvim_buf_line_count(0)), false)
        local pkg
        for _, l in ipairs(lines) do
          local m = l:match("^%s*package%s+([%w_%.]+)%s*;")
          if m then
            pkg = m
            break
          end
        end
        local main = pkg and (pkg .. "." .. fname) or fname

        -- compile + run via exec:java
        term(string.format('mvn -q compile exec:java -Dexec.mainClass="%s"', main))
      end, { buffer = true, desc = "[r]un: [r]un main (auto FQCN)" })

      vim.keymap.set("n", "<leader>rj", function()
        local file = vim.fn.expand("%:t")
        local fileName = vim.fn.expand("%:t:r")
        local cmd = "javac " .. file .. " && " .. " java " .. fileName
        term(cmd)
      end, { buffer = true, desc = "[r]un: java" })
    end,
  })
}
