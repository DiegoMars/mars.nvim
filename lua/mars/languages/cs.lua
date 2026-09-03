-- This is for C#
-- need to install dotnet for this to work
return {
  name = 'CS',
  filetypes = { 'cs' },
  mason_tools = { 'roslyn-language-server' },
  servers = {
    roslyn_ls = {},
  },
  on_filetype = function(bufnr)
    -- Optional. Runs once per matching buffer: buffer-local options, keymaps, etc.
  end,
}

-- To install dotnet (.NET) on windows, you can use chocolately from admin
-- `choco install dotnet-sdk`
--
-- For linux, do:
-- `sudo pacman -S dotnet-sdk`
