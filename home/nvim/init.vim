" Enable 24-bit color.
set termguicolors

" Use the system clipboard.
set clipboard+=unnamedplus

" Enable mouse support.
set mouse=a

" Show line numbers.
set number
highlight LineNr guifg=#aaaaaa

" no more delays
set timeoutlen=1000 ttimeoutlen=0

" statusline
highlight StatusLine guifg=#232323
highlight StatusLineNC guifg=#181818

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" set tab width to 2
set tabstop=2
set shiftwidth=0

" show whitespace characters
set listchars=tab:»\ ,eol:¬
set list

" autoreload files changed outside vim
set autoread

" enable syntax highlighting
syntax enable

" enable file type identification
filetype plugin indent on

" do not copy when pasting
xn p pgvy

" J and K to move up and down.
nmap J }
nmap K {
vmap J }
vmap K {

" H and L to move to the beginning and end of a line.
nmap H _
nmap L $
vmap H _
vmap L $

function Q()
	if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		:q
	else
		:bw
	endif
endfunction

nn <C-f> /
nn <C-g> :Rg<CR>
nn <C-h> :bp<CR>
nn <C-l> :bn<CR>
nn <C-p> :Commands<CR>
nn <C-q> :q<CR>
nn <C-s> :w<CR>
nn <C-t> :Files<CR>
" nn <C-w> :call Q()<CR>
nn u :undo<CR>
nn U :redo<CR>

call plug#begin(stdpath('data') . '/plugged')
" FZF integration.
Plug 'junegunn/fzf.vim'
" Collection of common configurations for the Nvim LSP client.
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints.
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP.
Plug 'nvim-lua/completion-nvim'
call plug#end()

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-u> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
" set signcolumn=yes
