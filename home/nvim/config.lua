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
vim.o.statusline = "%f %= %{LspStatus()}"
vim.cmd([[
  function! LspStatus() abort
    if luaeval("#vim.lsp.buf_get_clients() > 0")
      return luaeval('require("lsp-status").status()')
    endif
    return ""
  endfunction
]])

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
vim.api.nvim_set_keymap("n", "<M-h>", ":vsplit<CR>:wincmd l<CR>", { noremap = true })
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
vim.api.nvim_set_keymap("n", "<C-c>", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-c>", "<Plug>kommentary_visual_default", {})

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
  "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-M-e>",
  "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
  { noremap = true, silent = true }
)

colors = {
  background = "#111111",
  muted = "#aaaaaa",
  text = "#dddddd",

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
highlight("LineNr", { fg = colors.background })
vim.cmd [[
  hi LineNr guifg=#aaaaaa
  hi NonText guifg=#444444
  hi Pmenu guibg=#222222 guifg=#aaaaaa
  hi PmenuSbar guifg=#333333
  hi PmenuSel gui=bold guibg=#333333 guifg=#dddddd
  hi PmenuThumb guifg=#444444
  hi StatusLine guibg=#aaaaaa guifg=#232323
  hi StatusLineNC guibg=#aaaaaa guifg=#181818
  hi TabLine gui=NONE guibg=#222222 guifg=#aaaaaa
  hi TabLineFill guifg=#222222
  hi TabLineSel gui=bold guibg=#333333 guifg=#aaaaaa
  hi Title guifg=#aaaaaa
  hi VertSplit guibg=#333333 guifg=#111111
  hi Visual gui=NONE guibg=#333333
  hi Whitespace guifg=#444444
]]

-- Syntax colors.
vim.o.syntax = "off"
vim.cmd [[
  hi Comment guifg=#aaaaaa
  hi Constant guifg=#0a84ff
  hi String guifg=#30d158
  hi Character guifg=#30d158
  hi Number guifg=#ff9f0a
  hi Boolean guifg=#ff9f0a
  hi Float guifg=#ff9f0a
  hi Identifier guifg=#dddddd
  hi Function guifg=#0a84ff
  hi Statement guifg=#dddddd
  hi Conditional guifg=#bf5af2
  hi Repeat guifg=#bf5af2
  hi Label guifg=#bf5af2
  hi Operator guifg=#dddddd
  hi Keyword guifg=#bf5af2
  hi Exception guifg=#bf5af2
  hi PreProc guifg=#dddddd
  hi Include guifg=#5e5ce6
  hi Define guifg=#dddddd
  hi Macro guifg=#dddddd
  hi PreCondit guifg=#dddddd
  hi Type guifg=#ff9f0a
  hi StorageClass guifg=#ff9f0a
  hi Structure guifg=#ff9f0a
  hi TypeDef guifg=#ff9f0a
  hi Special guifg=#dddddd
  hi SpecialChar guifg=#dddddd
  hi Tag guifg=#dddddd
  hi Delimiter guifg=#dddddd
  hi SpecialComment guifg=#dddddd
  hi Debug guifg=#dddddd
  hi Underlined guifg=#0a84ff
  hi Ignore guifg=#aaaaaa
  hi Error guifg=#ff453a
  hi Todo guifg=#ffd60a
]]
vim.cmd [[
  highlight TSAnnotation guifg=#aaaaaa
  highlight TSAttribute guifg=#aaaaaa
  highlight TSBoolean guifg=#aaaaaa
  highlight TSCharacter guifg=#aaaaaa
  highlight TSComment guifg=#aaaaaa
  highlight TSConditional guifg=#aaaaaa
  highlight TSConstant guifg=#aaaaaa
  highlight TSConstBuiltin guifg=#aaaaaa
  highlight TSConstMacro guifg=#aaaaaa
  highlight TSConstructor guifg=#aaaaaa
  highlight TSError guifg=#aaaaaa
  highlight TSException guifg=#aaaaaa
  highlight TSField guifg=#aaaaaa
  highlight TSFloat guifg=#aaaaaa
  highlight TSFunction guifg=#aaaaaa
  highlight TSFuncBuiltin guifg=#aaaaaa
  highlight TSFuncMacro guifg=#aaaaaa
  highlight TSInclude guifg=#aaaaaa
  highlight TSKeyword guifg=#aaaaaa
  highlight TSKeywordFunction guifg=#aaaaaa
  highlight TSKeywordOperator guifg=#aaaaaa
  highlight TSLabel guifg=#aaaaaa
  highlight TSMethod guifg=#aaaaaa
  highlight TSNamespace guifg=#aaaaaa
  highlight TSNone guifg=#aaaaaa
  highlight TSNumber guifg=#aaaaaa
  highlight TSOperator guifg=#aaaaaa
  highlight TSParameter guifg=#aaaaaa
  highlight TSParameterReference guifg=#aaaaaa
  highlight TSProperty guifg=#aaaaaa
  highlight TSPunctDelimiter guifg=#aaaaaa
  highlight TSPunctBracket guifg=#aaaaaa
  highlight TSPunctSpecial guifg=#aaaaaa
  highlight TSRepeat guifg=#aaaaaa
  highlight TSString guifg=#aaaaaa
  highlight TSStringRegex guifg=#aaaaaa
  highlight TSStringEscape guifg=#aaaaaa
  highlight TSSymbol guifg=#aaaaaa
  highlight TSTag guifg=#aaaaaa
  highlight TSTagDelimiter guifg=#aaaaaa
  highlight TSText guifg=#aaaaaa
  highlight TSStrong guifg=#aaaaaa
  highlight TSEmphasis guifg=#aaaaaa
  highlight TSUnderline guifg=#aaaaaa
  highlight TSStrike guifg=#aaaaaa
  highlight TSTitle guifg=#aaaaaa
  highlight TSLiteral guifg=#aaaaaa
  highlight TSURI guifg=#aaaaaa
  highlight TSMath guifg=#aaaaaa
  highlight TSTextReference guifg=#aaaaaa
  highlight TSEnviroment guifg=#aaaaaa
  highlight TSEnviromentName guifg=#aaaaaa
  highlight TSNote guifg=#aaaaaa
  highlight TSWarning guifg=#aaaaaa
  highlight TSDanger guifg=#aaaaaa
  highlight TSType guifg=#aaaaaa
  highlight TSTypeBuiltin guifg=#aaaaaa
  highlight TSVariable guifg=#aaaaaa
  highlight TSVariableBuiltin guifg=#aaaaaa
]]
