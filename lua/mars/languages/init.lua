-- lua/mars/languages/init.lua
local M = {}

local state_file = vim.fn.stdpath('data') .. '/mars_languages.json'
local group = vim.api.nvim_create_augroup('MarsLanguages', { clear = true })

local function load_state()
  local f = io.open(state_file, 'r')
  if not f then return {} end
  local content = f:read('*a')
  f:close()
  local ok, decoded = pcall(vim.json.decode, content)
  return (ok and type(decoded) == 'table') and decoded or {}
end

local function save_state(state)
  local f = io.open(state_file, 'w')
  if not f then return end
  f:write(vim.json.encode(state))
  f:close()
end

local function discover()
  local modules = {}
  local dir = debug.getinfo(1, 'S').source:sub(2):match('(.*/)')
  for _, file in ipairs(vim.fn.globpath(dir, '*.lua', false, true)) do
    local modname = vim.fn.fnamemodify(file, ':t:r')
    if modname ~= 'init' then
      modules[modname] = require('mars.languages.' .. modname)
    end
  end
  return modules
end

-- Call this from nvim-lsp.lua BEFORE mason-lspconfig.setup(), so its
-- handler is the single source of truth for lspconfig[server].setup().
function M.collect_servers()
  local merged = {}
  for _, lang in pairs(discover()) do
    for name, opts in pairs(lang.servers or {}) do
      merged[name] = opts
    end
  end
  return merged
end

local function install_tools(lang, on_done)
  local ok_mr, mr = pcall(require, 'mason-registry')
  if not ok_mr then
    if on_done then on_done() end
    return
  end
  local pending, any_new = 0, false
  for _, tool in ipairs(lang.mason_tools or {}) do
    local ok_pkg, pkg = pcall(mr.get_package, tool)
    if ok_pkg and not pkg:is_installed() then
      any_new = true
      pending = pending + 1
      vim.notify(('Installing %s...'):format(tool), vim.log.levels.INFO)
      pkg:install():once('closed', function()
        vim.schedule(function()
          if pkg:is_installed() then
            vim.notify(('%s installed'):format(tool), vim.log.levels.INFO)
          else
            vim.notify(('Failed to install %s'):format(tool), vim.log.levels.ERROR)
          end
          pending = pending - 1
          if pending == 0 and on_done then on_done() end
        end)
      end)
    end
  end
  if not any_new and on_done then on_done() end 
end

local function activate(lang, capabilities)
  for server_name, opts in pairs(lang.servers or {}) do
    opts = vim.deepcopy(opts)
    opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
    vim.lsp.config(server_name, opts)
    vim.lsp.enable(server_name)
  end
  if lang.on_activate then lang.on_activate() end
end

local function setup_filetype_hook(modname, lang)
  if not lang.on_filetype or not lang.filetypes then return end
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = lang.filetypes,
    callback = function(ev) lang.on_filetype(ev.buf) end,
    desc = 'Mars language setup: ' .. modname,
  })
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains(lang.filetypes, vim.bo[buf].filetype) then
      lang.on_filetype(buf)
    end
  end
end

local function enable(modname, lang, capabilities, silent)
  setup_filetype_hook(modname, lang)
  install_tools(lang, function() activate(lang, capabilities) end)

  local state = load_state()
  if not state[modname] then
    state[modname] = true
    save_state(state)
  end
  if not silent then
    vim.notify('Language set up: ' .. (lang.name or modname), vim.log.levels.INFO)
  end
end

function M.setup(capabilities)
  local modules = discover()
  local state = load_state()
  for modname, lang in pairs(modules) do
    local cmd = 'Setup' .. (lang.name or (modname:sub(1, 1):upper() .. modname:sub(2)))
    vim.api.nvim_create_user_command(cmd, function()
      enable(modname, lang, capabilities, false)
    end, { desc = 'Set up ' .. (lang.name or modname) .. ' language support' })

    if state[modname] then
      enable(modname, lang, capabilities, true)
    end
  end
end

return M
