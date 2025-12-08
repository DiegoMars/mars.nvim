-- Need a different colorscheme, or make one with this tool eventually
return {
  "tjdevries/colorbuddy.nvim",
  config = function()
  local colorbuddy = require("colorbuddy")

  -- Register colorscheme
  colorbuddy.colorscheme("crimson-moon")

  local Color  = colorbuddy.Color
  local colors = colorbuddy.colors
  local Group  = colorbuddy.Group
  local groups = colorbuddy.groups
  local styles = colorbuddy.styles

  -----------------------------------------------------------------------
  -- Palette
  -----------------------------------------------------------------------
  -- Core background / foreground
  Color.new("bg",          "#12090c") -- very dark crimson
  Color.new("bg_alt",      "#1b1014") -- slightly lighter for statusline / splits
  Color.new("bg_dim",      "#22131a") -- dim sections / line nr background

  Color.new("fg",          "#e6dde0") -- main text
  Color.new("fg_dim",      "#c2b3b7") -- less important text
  Color.new("fg_muted",    "#a28c92") -- comments / subtle

  -- Reds (primary theme colors)
  Color.new("crimson",     "#e05c6e") -- main accent red
  Color.new("crimson_dark","#b3374b") -- stronger / error / statements
  Color.new("crimson_dim", "#7f3946") -- subtle red, used in bg accents

  -- Warm accents
  Color.new("amber",       "#e5b567") -- yellow-ish for constants
  Color.new("rust",        "#d97a4a") -- operators / special

  -- Cool accents (for balance)
  Color.new("sage",        "#8fbf6c") -- green for strings
  Color.new("teal",        "#66b8c6") -- functions, hints
  Color.new("iris",        "#b58adf") -- keywords, types

  -- UI / misc
  Color.new("gutter",      "#4a2f37")
  Color.new("cursorline",  "#211219")
  Color.new("selection",   "#3a1b26")
  Color.new("visual_red",  "#522030")

  Color.new("border",      "#41303a")
  Color.new("shadow",      "#080405")

  Color.new("error_red",   "#ff6b81")
  Color.new("warn_yellow", "#f2c97d")
  Color.new("info_blue",   "#8cb4ff")
  Color.new("hint_teal",   "#7adfd5")

  -----------------------------------------------------------------------
  -- Base editor groups
  -----------------------------------------------------------------------
  Group.new("Normal",         colors.fg,        colors.bg)
  Group.new("NormalFloat",    colors.fg,        colors.bg_alt)
  Group.new("Cursor",         colors.bg,        colors.crimson)
  Group.new("CursorLine",     nil,             colors.cursorline)
  Group.new("CursorColumn",   nil,             colors.cursorline)
  Group.new("ColorColumn",    nil,             colors.bg_dim)

  Group.new("LineNr",         colors.fg_muted,  colors.bg)
  Group.new("CursorLineNr",   colors.amber,     colors.bg,        styles.bold)
  Group.new("SignColumn",     colors.gutter,    colors.bg)

  Group.new("VertSplit",      colors.border,    colors.bg)
  Group.new("StatusLine",     colors.fg,        colors.bg_alt)
  Group.new("StatusLineNC",   colors.fg_muted,  colors.bg_dim)
  Group.new("TabLine",        colors.fg_muted,  colors.bg_dim)
  Group.new("TabLineSel",     colors.fg,        colors.bg_alt,    styles.bold)
  Group.new("TabLineFill",    colors.bg_dim,    colors.bg_dim)

  Group.new("Pmenu",          colors.fg,        colors.bg_alt)
  Group.new("PmenuSel",       colors.bg,        colors.crimson)
  Group.new("PmenuSbar",      nil,             colors.bg_dim)
  Group.new("PmenuThumb",     nil,             colors.crimson_dim)

  Group.new("Visual",         nil,             colors.selection)
  Group.new("VisualNOS",      nil,             colors.selection)
  Group.new("MatchParen",     colors.crimson,   colors.bg_dim,    styles.bold)

  Group.new("Search",         colors.fg,        colors.crimson_dark)
  Group.new("IncSearch",      colors.bg,        colors.amber,     styles.bold)
  Group.new("CurSearch",      colors.bg,        colors.amber,     styles.bold + styles.underline)

  Group.new("Folded",         colors.fg_muted,  colors.bg_dim)
  Group.new("FoldColumn",     colors.gutter,    colors.bg)

  Group.new("NonText",        colors.crimson_dim, colors.bg)
  Group.new("Whitespace",     colors.crimson_dim, colors.bg)
  Group.new("SpecialKey",     colors.crimson_dim, colors.bg)

  -----------------------------------------------------------------------
  -- Syntax groups
  -----------------------------------------------------------------------
  Group.new("Comment",        colors.fg_muted,  nil,              styles.italic)
  Group.new("Todo",           colors.crimson,   nil,              styles.bold + styles.italic)

  Group.new("Identifier",     colors.fg,        nil)
  Group.new("Function",       colors.teal,      nil,              styles.bold)
  Group.new("Keyword",        colors.iris,      nil,              styles.bold)
  Group.new("Statement",      colors.crimson_dark, nil)
  Group.new("Conditional",    colors.crimson_dark, nil)
  Group.new("Repeat",         colors.crimson_dark, nil)
  Group.new("Label",          colors.rust,      nil)
  Group.new("Operator",       colors.rust,      nil)
  Group.new("Exception",      colors.crimson_dark, nil)

  Group.new("PreProc",        colors.iris,      nil)
  Group.new("Include",        colors.iris,      nil)
  Group.new("Define",         colors.iris,      nil)
  Group.new("Macro",          colors.iris,      nil,              styles.bold)
  Group.new("PreCondit",      colors.iris,      nil)

  Group.new("Type",           colors.crimson, nil)
  Group.new("StorageClass",   colors.crimson_dark, nil)
  Group.new("Structure",      colors.crimson, nil)
  Group.new("Typedef",        colors.crimson, nil)

  Group.new("Constant",       colors.amber,     nil)
  Group.new("String",         colors.sage,      nil)
  Group.new("Character",      colors.sage,      nil)
  Group.new("Number",         colors.amber,     nil)
  Group.new("Boolean",        colors.amber,     nil)
  Group.new("Float",          colors.amber,     nil)

  Group.new("Special",        colors.crimson,   nil)
  Group.new("SpecialChar",    colors.crimson,   nil)
  Group.new("Tag",            colors.iris,      nil)
  Group.new("Delimiter",      colors.fg,        nil)
  Group.new("SpecialComment", colors.fg_muted,  nil,              styles.italic)
  Group.new("Debug",          colors.rust,      nil)

  -----------------------------------------------------------------------
  -- Diagnostics (LSP / vim.diagnostic)
  -----------------------------------------------------------------------
  Group.new("Error",          colors.error_red, nil,              styles.bold)
  Group.new("Warning",        colors.warn_yellow, nil)
  Group.new("Information",    colors.info_blue, nil)
  Group.new("Hint",           colors.hint_teal, nil)

  Group.new("DiagnosticError",   groups.Error)
  Group.new("DiagnosticWarn",    colors.warn_yellow, nil)
  Group.new("DiagnosticInfo",    colors.info_blue,   nil)
  Group.new("DiagnosticHint",    colors.hint_teal,   nil)

  Group.new("DiagnosticUnderlineError", colors.error_red, nil, styles.undercurl)
  Group.new("DiagnosticUnderlineWarn",  colors.warn_yellow, nil, styles.undercurl)
  Group.new("DiagnosticUnderlineInfo",  colors.info_blue, nil, styles.undercurl)
  Group.new("DiagnosticUnderlineHint",  colors.hint_teal, nil, styles.undercurl)

  -----------------------------------------------------------------------
  -- Git / Version control
  -----------------------------------------------------------------------
  Color.new("git_add",    "#8fbf6c")
  Color.new("git_change", "#e5b567")
  Color.new("git_delete", "#e05c6e")

  Group.new("DiffAdd",       colors.git_add:light(),    colors.bg_dim)
  Group.new("DiffChange",    colors.git_change:light(), colors.bg_dim)
  Group.new("DiffDelete",    colors.git_delete:light(), colors.bg_dim)
  Group.new("DiffText",      colors.git_change,         colors.bg_dim, styles.bold)

  Group.new("GitSignsAdd",   colors.git_add,   nil)
  Group.new("GitSignsChange",colors.git_change,nil)
  Group.new("GitSignsDelete",colors.git_delete,nil)

  -----------------------------------------------------------------------
  -- Telescope
  -----------------------------------------------------------------------
  Group.new("TelescopeNormal",      groups.Normal)
  Group.new("TelescopeBorder",      colors.border,        colors.bg_alt)
  Group.new("TelescopeTitle",       colors.crimson,       colors.bg_alt,  styles.bold)
  Group.new("TelescopePromptBorder",colors.border,        colors.bg_alt)
  Group.new("TelescopePromptNormal",colors.fg,            colors.bg_alt)
  Group.new("TelescopeSelection",   colors.bg,            colors.crimson)

  -----------------------------------------------------------------------
  -- Treesitter-ish groups (if you use nvim-treesitter)
  -----------------------------------------------------------------------
  Group.new("@comment",        groups.Comment)
  Group.new("@string",         groups.String)
  Group.new("@number",         groups.Number)
  Group.new("@boolean",        groups.Boolean)
  Group.new("@float",          groups.Float)

  Group.new("@function",       groups.Function)
  Group.new("@function.call",  groups.Function)
  Group.new("@method",         groups.Function)
  Group.new("@field",          colors.fg,        nil)
  Group.new("@property",       colors.fg,        nil)

  Group.new("@constant",       groups.Constant)
  Group.new("@constant.builtin", colors.amber:light(), nil, styles.bold)
  Group.new("@variable",       groups.Identifier)
  Group.new("@variable.builtin",colors.crimson, nil, styles.bold)

  Group.new("@type",             colors.crimson, nil)
  Group.new("@type.builtin",     colors.crimson_dark, nil, styles.bold)
  Group.new("@keyword",          colors.iris, nil, styles.bold)
  Group.new("@keyword.function", colors.crimson_dark, nil, styles.bold)

  -----------------------------------------------------------------------
  -- Markdown / inline code
  -----------------------------------------------------------------------
  -- Built-in markdown HL group
  Group.new("markdownInlineCode", groups.String)

  -- Treesitter text/markup groups for inline code
  Group.new("@text.literal",                    groups.String)
  Group.new("@text.literal.markdown_inline",    groups.String)
  Group.new("@markup.raw",                      groups.String)
  Group.new("@markup.raw.markdown_inline",      groups.String)

  -----------------------------------------------------------------------
  -- Misc / Neovim UI niceties
  -----------------------------------------------------------------------
  Group.new("Title",           colors.crimson,   nil, styles.bold)
  Group.new("Directory",       colors.teal,      nil, styles.bold)
  Group.new("ErrorMsg",        colors.bg,        colors.error_red, styles.bold)
  Group.new("WarningMsg",      colors.bg,        colors.warn_yellow, styles.bold)
  Group.new("MoreMsg",         colors.teal,      nil, styles.bold)
  Group.new("ModeMsg",         colors.iris,      nil)
  Group.new("Question",        colors.teal,      nil, styles.bold)

  -- Underline / links
  Group.new("Underlined",      colors.teal,      nil, styles.underline)
  Group.new("Ignore",          colors.bg_dim,    nil)

  -- Wild menu
  Group.new("WildMenu",        colors.bg,        colors.crimson, styles.bold)

  -----------------------------------------------------------------------
  -- LSP Semantic Token Overrides (Java-focused)
  -----------------------------------------------------------------------
  -- LSP modifiers like `public`, `private`, `static` = purple
  Group.new("@lsp.type.modifier",      colors.iris, nil, styles.bold)
  Group.new("@lsp.type.modifier.java", colors.iris, nil, styles.bold)

  -- Keywords (public, class, static, return...)
  Group.new("@lsp.type.keyword",          colors.iris, nil, styles.bold)
  Group.new("@lsp.type.keyword.java",     colors.iris, nil, styles.bold)
  Group.new("@lsp.modifier",              colors.iris, nil)
  Group.new("@lsp.modifier.java",         colors.iris, nil)

  -- Types (BSTExercises, Integer, String, int...) = red
  Group.new("@lsp.type.class",            colors.crimson, nil)
  Group.new("@lsp.type.class.java",       colors.crimson, nil)
  Group.new("@lsp.type.interface",        colors.crimson, nil)
  Group.new("@lsp.type.interface.java",   colors.crimson, nil)
  Group.new("@lsp.type.enum",             colors.crimson, nil)
  Group.new("@lsp.type.enum.java",        colors.crimson, nil)
  Group.new("@lsp.type.type",             colors.crimson, nil)
  Group.new("@lsp.type.type.java",        colors.crimson, nil)

  -- Functions / methods = teal
  Group.new("@lsp.type.method",           colors.teal, nil, styles.bold)
  Group.new("@lsp.type.method.java",      colors.teal, nil, styles.bold)
  Group.new("@lsp.type.function",         colors.teal, nil, styles.bold)
  Group.new("@lsp.type.function.java",    colors.teal, nil, styles.bold)

  -- Variables / fields
  Group.new("@lsp.type.variable",         colors.fg, nil)
  Group.new("@lsp.type.variable.java",    colors.fg, nil)
  Group.new("@lsp.type.property",         colors.fg_dim, nil)
  Group.new("@lsp.type.property.java",    colors.fg_dim, nil)

  -----------------------------------------------------------------------
  -- End
  -----------------------------------------------------------------------

  end
}

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   opts = {
--     flavour = "mocha",
--   },
--   config = function()
--     vim.cmd.colorscheme "catppuccin"
--   end
-- }
