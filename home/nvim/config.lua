-- Use space as the leader.
vim.g.mapleader = " "

-- Do not show the startup message.
vim.opt.shortmess:append("I")

-- Use the system clipboard.
vim.opt.clipboard = "unnamedplus"

-- Enable mouse support.
vim.opt.mouse = "a"

-- Show signs in the number column.
vim.opt.signcolumn = "yes:1"

-- Show line numbers.
vim.opt.number = true

-- Hide the tabline.
vim.opt.showtabline = 1

--Do not show the mode in the command line.
vim.opt.showmode = false

-- Do not show the visual mode selection column/line counts.
vim.opt.showcmd = false

-- Set default split direction.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Open help vertically.
vim.cmd([[
autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif
]])

-- Eliminate delays.
vim.opt.timeout = false
vim.opt.timeoutlen = 0
vim.opt.ttimeout = false
vim.opt.ttimeoutlen = 0

-- Disable backup and swap files.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Show whitespace characters.
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "» ", eol = "¬" }

-- Enable smart indentation.
vim.opt.smartindent = true

-- Use tabs.
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Indent commands.
vim.cmd([[
command! IndentTabs2 setlocal noexpandtab shiftwidth=2 tabstop=2
command! IndentTabs4 setlocal noexpandtab shiftwidth=4 tabstop=4
command! IndentSpaces2 setlocal expandtab shiftwidth=2
command! IndentSpaces4 setlocal expandtab shiftwidth=4
]])

-- Autoreload files changed outside vim.
vim.opt.autoread = true

-- Disable filetype detection.
vim.cmd([[
filetype off
filetype plugin indent off
]])

-- Configure completion menu.
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess:append("c")

-- Clear search highlighting on escape.
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR><Esc>", { noremap = true })

-- Undo/redo.
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", {})
vim.api.nvim_set_keymap("n", "u", ":undo<CR>", {})

-- Do not copy when pasting.
vim.api.nvim_set_keymap("x", "p", "pgvy", { noremap = true })

-- g to jump to top of file.
vim.api.nvim_set_keymap("n", "g", "gg", { noremap = true, nowait = true })

-- J and K to move up and down.
vim.api.nvim_set_keymap("n", "J", "}", {})
vim.api.nvim_set_keymap("n", "K", "{", {})
vim.api.nvim_set_keymap("v", "J", "}", {})
vim.api.nvim_set_keymap("v", "K", "{", {})

-- H and L to move to the beginning and end of a line.
vim.api.nvim_set_keymap("n", "H", "_", {})
vim.api.nvim_set_keymap("n", "L", "$", {})
vim.api.nvim_set_keymap("v", "H", "_", {})
vim.api.nvim_set_keymap("v", "L", "$", {})

-- Manage tabs.
vim.api.nvim_set_keymap("n", "<leader>,", ":tabprevious<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>.", ":tabnext<CR>", {})
vim.api.nvim_set_keymap("n", "<leader><", ":tabclose<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>>", ":tabnew<CR>", {})

-- Manage windows.
vim.api.nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", {})
vim.api.nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", {})
vim.api.nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>h", ":wincmd h<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>j", ":wincmd j<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>k", ":wincmd k<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>l", ":wincmd l<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>H", ":wincmd H<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>J", ":wincmd J<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>K", ":wincmd K<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>L", ":wincmd L<CR>", {})

-- Leader keybindings.
vim.api.nvim_set_keymap("n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>G", ":Telescope live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>N", ":split<CR>:wincmd j<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>R", ":source $MYVIMRC<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>S", ":wa<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>U", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>a", ":NvimTreeToggle<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", ":lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>e", ":Telescope lsp_workspace_diagnostics<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope fd<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>g", "/", {})
vim.api.nvim_set_keymap("n", "<leader>h", ":Telescope command_history<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>n", ":vsplit<CR>:wincmd l<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>p", ":", {})
vim.api.nvim_set_keymap("n", "<leader>q", ":qa<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>r", ":Telescope lsp_references<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>s", ":silent w<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>t", ":vsplit<CR>:term<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>T", ":split<CR>:term<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>u", ":lua vim.lsp.buf.hover()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>w", ":q<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>x", ":lua vim.lsp.buf.rename()<CR>", {})

-- Control keybindings.
vim.api.nvim_set_keymap("n", "<C-f>", "/", {})
vim.api.nvim_set_keymap("n", "<C-i>", "<C-o>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-i>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-q>", ":qa<CR>", {})
vim.api.nvim_set_keymap("n", "<C-s>", ":silent w<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-w>", ":q<CR>", {})

-- Hide cmdline after entering a command.
vim.cmd([[
autocmd! CmdlineLeave : echo ""
]])

-- Tree.
-- Telescope.
local telescope = require("telescope")
telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = { prompt_position = "top" }
		},
	},
})

-- Git Signs.
require("gitsigns").setup()

-- Treesitter.
local treesitter = require("nvim-treesitter.configs")
treesitter.setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
})

-- Commenting.
require("Comment").setup({})
vim.api.nvim_set_keymap("n", "<leader>/", ":lua require('Comment').toggle()<CR>", {})
vim.api.nvim_set_keymap("v", "<leader>/", ":lua require('Comment').toggle()<CR>", {})
vim.cmd([[
autocmd! BufEnter *.rs :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
autocmd! BufEnter *.lua :lua vim.api.nvim_buf_set_option(0, "commentstring", "-- %s")
]])

-- Autocomplete.
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
	},
	mapping = {
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Configure LSP
local lsp = require("lspconfig")
local lsp_status = require("lsp-status")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

local on_attach = function(client)
	lsp_status.on_attach(client)
end

lsp_status.register_progress()

lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				loadOutDirsFromCheck = true
			},
			procMacro = {
				enable = true
			},
		}
	}
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = false,
		update_in_insert = false,
	}
)

require("rust-tools").setup({})

-- Format on save.
vim.cmd([[
autocmd! BufWritePost *.rs :lua vim.lsp.buf.formatting_sync(nil, 1000)
]])

-- Terminal.

vim.cmd([[
autocmd! TermOpen term://* setlocal nonumber norelativenumber
autocmd! TermOpen term://* startinsert
autocmd! TermClose term://* :q
]])

-- Configure the popup menu.
vim.api.nvim_set_keymap("i", "<Up>", 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true })
vim.api.nvim_set_keymap("i", "<Down>", 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true })
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "<C-y>" : "<CR>"', { expr = true })
vim.api.nvim_set_keymap("c", "<Up>", 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true })
vim.api.nvim_set_keymap("c", "<Down>", 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true })
vim.api.nvim_set_keymap("c", "<CR>", 'pumvisible() ? "<C-y>" : "<CR>"', { expr = true })

-- Configure the statusline.
vim.opt.statusline = "%!luaeval('statusline_function()')"
function statusline_function()
	if vim.fn.expand('%f') == "NvimTree" then
		return ""
	end
	t = {}
	table.insert(t, "%f")
	table.insert(t, "%=")
	if #vim.lsp.buf_get_clients() > 0 then
		table.insert(t, "%#StatusLineProgress#")
		table.insert(t, lsp_status.status_progress())
		table.insert(t, "%#StatusLineErrors#") 
		table.insert(t, "  ")
		table.insert(t, lsp_status.diagnostics().errors)
		table.insert(t, "%#StatusLineWarnings#")
		table.insert(t, "  ")
		table.insert(t, lsp_status.diagnostics().warnings)
		table.insert(t, "%#StatusLineInfo#")
		table.insert(t, "  ")
		table.insert(t, lsp_status.diagnostics().info)
	end
	return table.concat(t)
end

-- Theme.
colors = {
	background = "#111111",
	muted = "#aaaaaa",
	text = "#dddddd",
	surface = "#181818",
	header = "#232323",
	hover = "#333333",
	border = "#212121",

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

groups = {

	-- UI
	EndOfBuffer = { fg = colors.background },
	IncSearch = { fg = colors.yellow },
	LineNr = { fg = colors.muted },
	NonText = { fg = colors.text },
	Pmenu = { fg = colors.muted, bg = colors.header },
	PmenuSbar = { fg = colors.header },
	PmenuSel = { fg = colors.text, bg = colors.surface },
	PmenuThumb = { fg = colors.hover },
	Search = { fg = colors.yellow },
	SignColumn = { bg = colors.background },
	StatusLine = { fg = colors.muted, bg = colors.header },
	StatusLineNC = { fg = colors.muted, bg = colors.header },
	TabLine = { fg = colors.muted, bg = colors.header },
	TabLineFill = { bg = colors.header },
	TabLineSel = { fg = colors.text, bg = colors.hover },
	Title = { fg = colors.muted },
	VertSplit = { fg = colors.hover, bg = colors.background },
	Visual = { bg = colors.hover },
	Whitespace = { fg = colors.hover },

	-- Treesitter.
	TSAnnotation = { fg = colors.muted },
	TSAttribute = { fg = colors.text },
	TSBoolean = { fg = colors.orange },
	TSCharacter = { fg = colors.green },
	TSComment = { fg = colors.muted },
	TSConditional = { fg = colors.purple },
	TSConstBuiltin = { fg = colors.text },
	TSConstMacro = { fg = colors.orange },
	TSConstant = { fg = colors.pink },
	TSConstructor = { fg = colors.text },
	TSDanger = { fg = colors.red },
	TSEmphasis = { fg = colors.text, st = "bold" },
	TSEnviroment = { fg = colors.text },
	TSEnviromentName = { fg = colors.text },
	TSError = { fg = colors.red },
	TSException = { fg = colors.red },
	TSField = { fg = colors.teal, st = 'italic' },
	TSFloat = { fg = colors.orange },
	TSFuncBuiltin = { fg = colors.text },
	TSFuncMacro = { fg = colors.blue },
	TSFunction = { fg = colors.blue },
	TSInclude = { fg = colors.purple },
	TSKeyword = { fg = colors.purple },
	TSKeywordFunction = { fg = colors.purple },
	TSKeywordOperator = { fg = colors.text },
	TSLabel = { fg = colors.text },
	TSLiteral = { fg = colors.text },
	TSMath = { fg = colors.muted },
	TSMethod = { fg = colors.orange },
	TSNamespace = { fg = colors.indigo },
	TSNone = { fg = colors.text },
	TSNote = { fg = colors.text },
	TSNumber = { fg = colors.orange },
	TSOperator = { fg = colors.text },
	TSParameter = { fg = colors.teal },
	TSParameterReference = { fg = colors.teal },
	TSProperty = { fg = colors.text },
	TSPunctBracket = { fg = colors.text },
	TSPunctDelimiter = { fg = colors.text },
	TSPunctSpecial = { fg = colors.text },
	TSRepeat = { fg = colors.purple },
	TSStrike = { fg = colors.text },
	TSString = { fg = colors.green },
	TSStringEscape = { fg = colors.text },
	TSStringRegex = { fg = colors.text },
	TSStrong = { fg = colors.text },
	TSStructure = { fg = colors.blue },
	TSSymbol = { fg = colors.text },
	TSTag = { fg = colors.text },
	TSTagDelimiter = { fg = colors.text },
	TSText = { fg = colors.text },
	TSTextReference = { fg = colors.text },
	TSTitle = { fg = colors.text },
	TSType = { fg = colors.blue },
	TSTypeBuiltin = { fg = colors.orange },
	TSURI = { fg = colors.text },
	TSUnderline = { fg = colors.text },
	TSVariable = { fg = colors.teal },
	TSVariableBuiltIn = { fg = colors.teal },
	TSWarning = { fg = colors.yellow },

	-- Git Signs
	GitSignsAdd = { fg = colors.green },
	GitSignsChange = { fg = colors.yellow },
	GitSignsDelete = { fg = colors.red },
	GitSignsAddLn = { fg = colors.green },
	GitSignsChangeLn = { fg = colors.yellow },
	GitSignsDeleteLn = { fg = colors.green },

	-- LSP.
	StatusLineErrors = { fg = colors.red, bg = colors.header },
	StatusLineWarnings = { fg = colors.yellow, bg = colors.header },
	StatusLineInfo = { fg = colors.text, bg = colors.header },

}

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("hi clear")
vim.cmd("syntax reset")
for group, color in pairs(groups) do
	local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
	local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
	local st = color.st and "gui=" .. color.st or "gui=NONE"
	local sp = color.sp and "guisp=" .. color.sp or ""
	vim.cmd("highlight " .. group .. " " .. fg .. " " .. bg .. " " .. st .. " " .. sp)
end
