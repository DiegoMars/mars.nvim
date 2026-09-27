-- need java, cmake, and clang installed
-- windows installation of clang can be done through LLVM using `choco install llvm`

local function project_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

local function scaffold_gitignore()
  if vim.fn.filereadable('.gitignore') == 1 then return end
  vim.fn.writefile({
    'build/',
    '*.o',
    '*.obj',
    '*.exe',
    '*.out',
    '.cache/',
  }, '.gitignore')
end

local function scaffold_project()
  vim.fn.mkdir('src', 'p') -- Don't error if folder already exists

  if vim.fn.filereadable('CMakeLists.txt') == 0 then
    local proj = project_name()
    local cmake = string.format([[
cmake_minimum_required(VERSION 3.16)
project(%s LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Example code for implementing external libraries
# include(FetchContent)

# FetchContent_Declare(
#   fmt
#   GIT_REPOSITORY https://github.com/fmtlib/fmt.git
#   GIT_TAG 10.2.1
# )
#
# FetchContent_MakeAvailable(fmt json)

add_executable(%s
    src/main.cpp
)

# target_link_libraries(mediator_cpp PRIVATE fmt::fmt)
]], proj, proj)
    vim.fn.writefile(vim.split(cmake, '\n'), 'CMakeLists.txt')
  end

  if vim.fn.filereadable('src/main.cpp') == 0 then
    vim.fn.writefile(vim.split([[
#include <iostream>

int main() {
    std::cout << "Hello, world!\n";
    return 0;
}
]], '\n'), 'src/main.cpp')
  end

  scaffold_gitignore()
  vim.notify('C++ project initialized', vim.log.levels.INFO)
end

local function register_commands()
  vim.api.nvim_create_user_command('CppInit', scaffold_project, { desc = 'Scaffold a CMake C++ project' })
end

return {
  name = 'Cpp',
  filetypes = { 'c', 'cpp' },
  mason_tools = { 'clangd' },
  servers = {
    clangd = {},
  },
  on_activate = register_commands,
  on_filetype = function(bufnr)
    vim.bo[bufnr].tabstop = 4
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].expandtab = true

    require('which-key').add({
      { '<leader>r', group = '[r]un cpp' },
    })

    local is_windows = vim.uv.os_uname().sysname == 'Windows_NT'

    local function has_cmake()
      return vim.fn.filereadable('CMakeLists.txt') == 1
    end

    local function exe_path()
      local name = is_windows and (project_name() .. '.exe') or project_name()
      return is_windows and ('build\\debug\\' .. name) or ('./build/' .. name)
    end

    local function term(cmd)
      vim.cmd('split | terminal ' .. cmd)
      vim.cmd('startinsert')
    end

    -- Single-file fallback when there's no CMakeLists.txt at all
    local function compile_single_file(run_after)
      local out = is_windows and 'a.exe' or './a.out'
      local cmd = string.format('clang++ -std=c++20 -Wall -Wextra %s -o %s',
        vim.fn.expand('%:p'), out)
      if run_after then cmd = cmd .. ' && ' .. out end
      term(cmd)
    end

    vim.keymap.set('n', '<leader>rc', function()
      vim.fn.mkdir('build', 'p')
      term('cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON')
    end, { buffer = bufnr, desc = '[c]make configure' })

    vim.keymap.set('n', '<leader>rb', function()
      if has_cmake() then term('cmake --build build') else compile_single_file(false) end
    end, { buffer = bufnr, desc = '[b]uild' })

    vim.keymap.set('n', '<leader>rr', function()
      if has_cmake() then term('cmake --build build && ' .. exe_path()) else compile_single_file(true) end
    end, { buffer = bufnr, desc = '[r]un' })

    -- Will implement later
    -- vim.keymap.set('n', '<leader>rt', function()
    --   term('ctest --test-dir build')
    -- end, { buffer = bufnr, desc = '[t]est' })
  end,
}
