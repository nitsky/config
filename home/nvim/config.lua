-- Plugins.
local packer = require("packer")
packer.startup(function()
  use("b3nj5m1n/kommentary")
  use("christoomey/vim-tmux-navigator")
  use("kyazdani42/nvim-web-devicons")
  use("neovim/nvim-lspconfig")
  use("nvim-lua/completion-nvim")
  use("nvim-lua/lsp_extensions.nvim")
  use("nvim-lua/lsp-status.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope-symbols.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-treesitter/nvim-treesitter")
  use("wbthomason/packer.nvim")
end)

-- Enable 24-bit color.
vim.o.termguicolors = true

-- Do not show the startup message.
vim.o.shortmess = vim.o.shortmess .. "I"

-- Use the system clipboard.
vim.o.clipboard = "unnamedplus"
-- autocmd TextYankPost * if v:event.operator is "y" && v:event.regname is "" | OSCYankReg " | endif

-- Enable mouse support.
vim.o.mouse = "a"

-- Always show the tabline.
vim.o.showtabline = 2

-- Set the statusline.
vim.o.statusline = "%!luaeval('statusline_lsp()')"

--Do not show the mode in the command line.
vim.o.showmode = false
-- Do not show the last command in the command line.
vim.o.showcmd = false

-- Show line numbers.
vim.wo.number = true
vim.o.number = true

-- Eliminate delays.
vim.o.timeout = false
vim.o.timeoutlen = 0
vim.o.ttimeout = false
vim.o.ttimeoutlen = 0

-- Disable backup and swap files.
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Show whitespace characters.
vim.wo.list = true
vim.o.list = true
vim.o.listchars = "space:·,tab:» ,eol:¬"

-- Set the tab width to 2.
vim.bo.tabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.bo.expandtab = false
vim.o.expandtab = false

-- Autoreload files changed outside vim.
vim.o.autoread = true

-- Do not copy when pasting.
vim.api.nvim_set_keymap("x", "p", "pgvy", { noremap = true })

-- J and K to move up and down.
vim.api.nvim_set_keymap("n", "J", "}", { noremap = true })
vim.api.nvim_set_keymap("n", "K", "{", { noremap = true })
vim.api.nvim_set_keymap("v", "J", "}", { noremap = true })
vim.api.nvim_set_keymap("v", "K", "{", { noremap = true })

-- H and L to move to the beginning and end of a line.
vim.api.nvim_set_keymap("n", "H", "_", { noremap = true })
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true })
vim.api.nvim_set_keymap("v", "H", "_", { noremap = true })
vim.api.nvim_set_keymap("v", "L", "$", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-f>", "/", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-g>", ":Rg<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-t>", ":Telescope fd<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "u", ":undo<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true })

-- Create splits with s and S.
vim.api.nvim_set_keymap("n", "<C-w>s", ":vsplit<CR>:wincmd l<CR>", { noremap = true })

-- Move between splits.
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap("n", "<M-h>", "TmuxNavigateLeft<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-j>", "TmuxNavigateDown<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-k>", "TmuxNavigateUp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-l>", "TmuxNavigateRight<CR>", { noremap = true })

-- Create, close, and move between tabs.
vim.api.nvim_set_keymap("n", "<M-N>", ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-n>", ":tabprevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-m>", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-M>", ":tabclose<CR>", { noremap = true })

-- Save all.
vim.api.nvim_set_keymap("n", "<C-M-s>", ":wa<CR>", { noremap = true })

-- Hide cmdline after entering a command.
vim.cmd([[
  augroup cmdline
    autocmd!
    autocmd CmdlineLeave : echo ""
  augroup end
]])

-- tree-sitter
local treesitter = require("nvim-treesitter.configs")
treesitter.setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
})

-- Disable filetype detection.
vim.cmd [[
  filetype off
  filetype plugin indent off
]]

-- Configure completion menu.
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

-- Set time for CursorHold.
vim.o.updatetime = 500

-- Show diagnostics on CursorHold.
vim.cmd [[
  autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
]]

-- Always show diagnostics column.
vim.o.signcolumn = "no"

-- Configure LSP
local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local completion = require("completion")

lsp_status.register_progress()

local on_attach = function(client)
  completion.on_attach(client)
 	lsp_status.on_attach(client)
end

lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    ["rust-analyzer"] = {}
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    update_in_insert = false,
  }
)

-- Format on save.
vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END
]])

-- Commenting.
require('kommentary.config').use_extended_mappings()
vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-a>", "<Plug>kommentary_visual_default", {})

vim.api.nvim_set_keymap("n", "<C-s>", ":silent w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-i>", "<C-o>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-i>", { noremap = true })

-- Configure the popup menu.
vim.api.nvim_set_keymap(
  "i",
  "<Up>",
  'pumvisible() ? "<C-p>" : "<Up>"',
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<Down>",
  'pumvisible() ? "<C-n>" : "<Down>"',
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  'pumvisible() ? "<C-y>" : "<CR>"',
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "c",
  "<Up>",
  'pumvisible() ? "<C-p>" : "<Up>"',
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "c",
  "<Down>",
  'pumvisible() ? "<C-n>" : "<Down>"',
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "c",
  "<CR>",
  'pumvisible() ? "<C-y>" : "<CR>"',
  { noremap = true, expr = true }
)

-- Use <Tab> and <S-Tab> for the completion menu.
vim.api.nvim_set_keymap("i", "<Tab>", "<Plug>(completion_smart_tab)", { noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "<Plug>(completion_smart_s_tab)", { noremap = true })

vim.cmd([[
  let mapleader = "<space>"
]])

vim.api.nvim_set_keymap("n", "<M-v>", "<C-v>", { noremap = true })

-- Code navigation shortcuts
vim.api.nvim_set_keymap(
  "n",
  "<C-space>",
  "<cmd>Telescope<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-d>",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-M-d>",
  "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-u>",
  "<cmd>lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-r>",
  "<cmd>Telescope lsp_references<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-t>",
  "<cmd>Telescope fd<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-e>",
  "<cmd>Telescope lsp_workspace_diagnostics<CR>",
  { noremap = true, silent = true }
)

colors = {
  background = "#111111",
  muted = "#aaaaaa",
  text = "#dddddd",
  surface = "#181818",
  header = "#232323",
  hover = "#333333",
  border = "#212121",

  --heading_text = "#ffffff",
  --fun_text = "#111111",

  blue = "#0a84ff",
  gray = "#8e8e93",
  green = "#30d158",
  indigo = "#5e5ce6",
  orange = "#ff9f0a",
  pink = "#ff375f",
  purple = "#bf5af2",
  red = "#ff453a",
  teal = "#4dd0e1",
  yellow = "#ffd60a",
}

function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  vim.cmd("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp)
end

-- Colors.
highlight("EndOfBuffer", { fg = colors.background })
highlight("LineNr", { fg = colors.muted })
highlight("NonText", { fg = colors.text })
highlight("Pmenu", { bg = colors.header, fg = colors.muted })
highlight("PmenuSbar", { fg = colors.header })
highlight("PmenuSel", { bg = colors.surface, fg = colors.text, style = "bold" })
highlight("PmenuThumb", { fg = colors.hover })
highlight("StatusLine", { bg = colors.header, fg = colors.muted })
highlight("StatusLineNC", { bg = colors.header, fg = colors.muted })
highlight("TabLine", { bg = colors.header, fg = colors.muted })
highlight("TabLineFill", { bg = colors.header })
highlight("TabLineSel", { bg = colors.hover, fg = colors.text , style = "bold"})
highlight("Title", { fg = colors.muted })
highlight("VertSplit", { bg = colors.background, fg = colors.hover })
highlight("Visual", { bg = colors.hover })
highlight("Whitespace", { fg = colors.hover })

-- Syntax colors.
vim.o.syntax = "off"
highlight("Comment", { fg = colors.muted })
highlight("Constants", { fg = colors.blue })
highlight("String", { fg = colors.green })
highlight("Character", { fg = colors.green })
highlight("Number", { fg = colors.green })
highlight("Boolean", { fg = colors.green })
highlight("Float", { fg = colors.green })
highlight("Identifier", { fg = colors.text })
highlight("Function", { fg = colors.blue })
highlight("Statement", { fg = colors.text })
highlight("Conditional", { fg = colors.purple })
highlight("Repeat", { fg = colors.purple })
highlight("Label", { fg = colors.purple })
highlight("Operator", { fg = colors.text })
highlight("Keyword", { fg = colors.purple })
highlight("Exception", { fg = colors.purple })
highlight("PreProc", { fg = colors.text })
highlight("Include", { fg = colors.text })
highlight("Define", { fg = colors.text })
highlight("Macro", { fg = colors.text })
highlight("PreCondit", { fg = colors.text })
highlight("Type", { fg = colors.teal })
highlight("StorageClass", { fg = colors.teal })
highlight("Structure", { fg = colors.teal })
highlight("TypeDef", { fg = colors.orange })
highlight("Special", { fg = colors.text })
highlight("SpecialChar", { fg = colors.text })
highlight("Tag", { fg = colors.text })
highlight("Delimiter", { fg = colors.text })
highlight("SpecialComment", { fg = colors.text })
highlight("Debug", { fg = colors.text })
highlight("Underlined", { fg = colors.blue })
highlight("Ignore", { fg = colors.muted })
highlight("Error", { fg = colors.red })
highlight("Todo", { fg = colors.yellow })

highlight("TSAnnotation", { fg = colors.muted })
highlight("TSAttribute", { fg = colors.text })
highlight("TSBoolean", { fg = colors.orange })
highlight("TSCharacter", { fg = colors.green })
highlight("TSComment", { fg = colors.muted })
highlight("TSConditional", { fg = colors.purple })
highlight("TSConstant", { fg = colors.pink })
highlight("TSConstBuiltin", { fg = colors.text })
highlight("TSConstMacro", { fg = colors.text })
highlight("TSConstructor", { fg = colors.text })
highlight("TSError", { fg = colors.text })
highlight("TSException", { fg = colors.text })
highlight("TSField", { fg = colors.text })
highlight("TSFloat", { fg = colors.orange })
highlight("TSFunction", { fg = colors.blue })
highlight("TSFuncBuiltin", { fg = colors.text })
highlight("TSFuncMacro", { fg = colors.blue })
highlight("TSInclude", { fg = colors.purple })
highlight("TSKeyword", { fg = colors.purple })
highlight("TSKeywordFunction", { fg = colors.purple })
highlight("TSKeywordOperator", { fg = colors.text })
highlight("TSLabel", { fg = colors.text })
highlight("TSMethod", { fg = colors.orange })
highlight("TSNamespace", { fg = colors.indigo })
highlight("TSNone", { fg = colors.text })
highlight("TSNumber", { fg = colors.text })
highlight("TSOperator", { fg = colors.text })
highlight("TSParameter", { fg = colors.text })
highlight("TSParameterReference", { fg = colors.text })
highlight("TSProperty", { fg = colors.text })
highlight("TSPunctDelimiter", { fg = colors.text })
highlight("TSPunctBracket", { fg = colors.text })
highlight("TSPunctSpecial", { fg = colors.text })
highlight("TSRepeat", { fg = colors.purple })
highlight("TSString", { fg = colors.green })
highlight("TSStringRegex", { fg = colors.text })
highlight("TSStringEscape", { fg = colors.text })
highlight("TSSymbol", { fg = colors.text })
highlight("TSTag", { fg = colors.text })
highlight("TSTagDelimiter", { fg = colors.text })
highlight("TSText", { fg = colors.text })
highlight("TSStrong", { fg = colors.text })
highlight("TSEmphasis", { fg = colors.text })
highlight("TSUnderline", { fg = colors.text })
highlight("TSStrike", { fg = colors.text })
highlight("TSTitle", { fg = colors.text })
highlight("TSLiteral", { fg = colors.text })
highlight("TSURI", { fg = colors.text })
highlight("TSMath", { fg = colors.text })
highlight("TSTextReference", { fg = colors.text })
highlight("TSEnviroment", { fg = colors.text })
highlight("TSEnviromentName", { fg = colors.text })
highlight("TSNote", { fg = colors.text })
highlight("TSWarning", { fg = colors.text })
highlight("TSDanger", { fg = colors.text })
highlight("TSType", { fg = colors.teal })
highlight("TSTypeBuiltin", { fg = colors.text })
highlight("TSVariable", { fg = colors.text })
highlight("TSVariableBuiltin", { fg = colors.text })

highlight("StatusLineErrors", { bg = colors.header, fg = colors.red })
highlight("StatusLineWarnings", { bg = colors.header, fg = colors.yellow })
highlight("StatusLineInfo", { bg = colors.header, fg = colors.text })

function statusline_lsp()
  if #vim.lsp.buf_get_clients() == 0 then
    return ""
  end
  local diagnostics = lsp_status.diagnostics()
  return table.concat {
    "%f",
    "%=",
    "%#StatusLineErrors#", diagnostics.errors,
    " ",
    "%#StatusLineWarnings#", diagnostics.warnings,
    " ",
    "%#StatusLineInfo#", diagnostics.info,
  }
end
