-- Do need java and maven installed to use this

local commands_registered = false
local function register_commands()
  if commands_registered then return end
  commands_registered = true
  vim.api.nvim_create_user_command("InitJava", function()
    vim.ui.input({ prompt = "groupId: ", default = "com.diegomars" }, function(groupId)
      if not groupId or groupId == "" then return end
      vim.ui.input({ prompt = "artifactId: " }, function(artifactId)
        if not artifactId or artifactId == "" then return end
        local cmd = string.format(
          'mvn archetype:generate -DgroupId=%s -DartifactId=%s '
          .. '-DarchetypeArtifactId=maven-archetype-quickstart '
          .. '-DarchetypeVersion=1.5 -DinteractiveMode=false',
          groupId, artifactId
        )
        vim.cmd("split | terminal " .. cmd)
        vim.cmd("startinsert")
      end)
    end)
  end, { desc = "Scaffold a new Maven project" })
end

return {
  name = 'Java',
  filetypes = { 'java' },
  mason_tools = { 'jdtls' },
  servers = {
    jdtls = {},
  },
  on_activate = register_commands,
  on_filetype = function(bufnr)
    vim.bo[bufnr].tabstop = 4
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].expandtab = true

    require("which-key").add({
      { "<leader>r", group = "[r]un java" }
    })

    local function term(cmd)
      vim.cmd("split | terminal " .. cmd)
      vim.cmd("startinsert")
    end

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
    end, { buffer = true, desc = "[r]un [p]ackage (skip tests)" })

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
    end, { buffer = true, desc = "[r]un: [r]un main" })

    -- This is for basic running of java files
    vim.keymap.set("n", "<leader>rj", function()
      local file = vim.fn.expand("%:t")
      local fileName = vim.fn.expand("%:t:r")
      local cmd = "javac " .. file .. " && " .. " java " .. fileName
      term(cmd)
    end, { buffer = true, desc = "[r]un: [j]ava" })

  end,
}
