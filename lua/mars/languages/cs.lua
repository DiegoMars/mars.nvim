-- This is for C#
-- need to install dotnet and roslyn_ls for this to work
return {
  name = 'CS',
  filetypes = { 'cs' },
  mason_tools = {},
  servers = {
    roslyn_ls = {
      cmd = {
        'roslyn-language-server',
        '--logLevel', 'Information',
        '--extensionLogDirectory', vim.fs.joinpath(vim.uv.os_tmpdir(), 'roslyn_ls', 'logs'),
        '--stdio',
      },
    },
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
--
-- Afterwards, install roslyn using:
-- `dotnet tool install -g roslyn-language-server --prerelease --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json`
