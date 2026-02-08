-- Project-level command: CppInit
vim.api.nvim_create_user_command("CppInit", function()
  local function project_name()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end

  vim.fn.mkdir("src", "p")

  if vim.fn.filereadable("CMakeLists.txt") == 0 then
    local proj = project_name()
    local cmake = string.format([[
cmake_minimum_required(VERSION 3.16)
project(%s LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(%s
    src/main.cpp
)
]], proj, proj)

    vim.fn.writefile(vim.split(cmake, "\n"), "CMakeLists.txt")
  end

  if vim.fn.filereadable("src/main.cpp") == 0 then
    local main = [[
#include <iostream>

int main() {
    std::cout << "Hello, world!\n";
    return 0;
}
]]
    vim.fn.writefile(vim.split(main, "\n"), "src/main.cpp")
  end

  vim.notify("C++ project initialized", vim.log.levels.INFO)
end, {})

-- Buffer-local C++ UX
return {
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true

      require("which-key").add({
        { "<leader>r", group = "[r]un cpp" }
      })
      -- wk.add({
      --   ["<leader>c"] = { name = "[c]pp / cmake" },
      -- }, { buffer = 0 })

      -- =====================
      -- Helpers
      -- =====================

      local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

      local function project_name()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end

      local function exe_name()
        local name = project_name()
        return is_windows and (name .. ".exe") or name
      end

      local function exe_path()
        return is_windows
          and ("build\\" .. exe_name())
          or ("./build/" .. exe_name())
      end

      local function has_cmake()
        return vim.fn.filereadable("CMakeLists.txt") == 1
      end

      local function compiler()
        if vim.fn.executable("clang++") == 1 then
          return "clang++"
        end
        return "g++"
      end

      local function current_cpp()
        return vim.fn.expand("%:p")
      end

      local function term(cmd)
        vim.cmd("split")
        vim.cmd("terminal " .. cmd)
        vim.cmd("startinsert")
      end

      -- =====================
      -- CMake actions
      -- =====================

      vim.keymap.set("n", "<leader>rc", function()
        vim.fn.mkdir("build", "p")
        term("cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
      end, { buffer = 0, desc = "[r]un: [c]make configure" })

      vim.keymap.set("n", "<leader>rb", function()
        if has_cmake() then
          term("cmake --build build")
        else
          local cmd = string.format(
            "%s -std=c++20 -Wall -Wextra %s -o a.out",
            compiler(),
            current_cpp()
          )
          term(cmd)
        end
      end, { buffer = 0, desc = "[r]un: build" })

      vim.keymap.set("n", "<leader>rr", function()
        if has_cmake() then
          term("cmake --build build && " .. exe_path())
        else
          local exe = vim.loop.os_uname().sysname == "Windows_NT"
            and "a.exe"
            or "./a.out"

          local cmd = string.format(
            "%s -std=c++20 -Wall -Wextra %s -o %s && %s",
            compiler(),
            current_cpp(),
            is_windows and "a.exe" or "a.out",
            exe
          )
          term(cmd)
        end
      end, { buffer = 0, desc = "[r]un: [run]" })

      vim.keymap.set("n", "<leader>rt", function()
        term("ctest --test-dir build")
      end, { buffer = 0, desc = "[r]un: [t]est" })
    end,
  }),
}
