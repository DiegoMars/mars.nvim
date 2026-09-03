# Set up files for:
- [ ] java
- [ ] markdown
- [ ] cpp
- [ ] python
- [ ] astro
- [ ] rust

## Example code
```
return {
  name = 'Java',              -- Required. Builds the command name: :SetupJava
  filetypes = { 'java' },     -- Required if you want on_filetype/servers to activate on buffers
  mason_tools = { 'jdtls' },  -- Optional. Mason package names to install. Omit/empty if nothing to install.
  servers = {                 -- Optional. lspconfig server name -> opts (same shape as a normal
    jdtls = {},                --   lspconfig[server].setup(opts) call, minus `capabilities` —
  },                           --   the loader merges that in for you.
  on_filetype = function(bufnr)
    -- Optional. Runs once per matching buffer: buffer-local options, keymaps, etc.
  end,
}
```
