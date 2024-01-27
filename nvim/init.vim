" Mappings
" =============
let mapleader =","

" Use tab to switch to matching bracket
" note that this doesn't work since <TAB> and <C-i> are the
" Same thing in vim. Would rather have <C-i> and <C-o> functionality
" For moving forward and backward.
" nnoremap <tab> %
" vnoremap <tab> %

"Quickly edit .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

"Quickly source vimrc
nnoremap <leader>v :source $MYVIMRC<cr>


" Editor Options
"===================
" Use vim settings and not VI settings. Required for polylot
set nocompatible

" Show line numbers and relative line numbers
set number
set relativenumber
set signcolumn=auto

" Auto-indent, tabs as 4 spaces
set ai ts=4 sw=4 sts=4 et

" Highlight current line
set cursorline

" Set line length marker
set colorcolumn=88
set textwidth=88

" Don't automatically add comments on newlines
au FileType * set fo -=r fo -=o

" Use system clipboard
" If not working, try the following command in terminal:
" sudo apt install vim-gtk3
set clipboard=unnamedplus

" Keep the cursor off the bottom & top of the screen
set scrolloff=5

" Search is case insensitive when all lowercase, but case sensitive when
" search contains any caps.
set ignorecase
set smartcase

" Status line set by lightline.vim, so turn off -- INSERT -- text
set noshowmode

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> gl :exe "tabn ".g:lasttab<cr>
vnoremap <silent> gl :exe "tabn ".g:lasttab<cr>


" Plugins
" ================
call plug#begin()

" Editor enhancements
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" GUI Enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'dstein64/nvim-scrollview'

" Language-specific
Plug 'rust-lang/rust.vim'

call plug#end()

" Theme
" ================
set termguicolors
colorscheme base16-gigavolt

" Plugin-specific Settings
" ================

" LSP Config
" -----------------------------

lua << END
require'lspconfig'.pyright.setup{}

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      imports = {
        group = {
          enable = false,
        },
      },
      completion = {
        postfix = {
          enable = false,
        },
      },
    },
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
END

" FZF
" Initialize configuration dictionary
let g:fzf_vim = {}
let g:fzf_vim.buffers_jump = 1

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" rust.vim
syntax enable
filetype plugin indent on
let g:rustfmt_autosave=1

" GitGutter 
highlight GitGutterAdd guifg=#00FF00
highlight GitGutterChange guifg=#00FFFF
highlight GitGutterDelete guifg=#FF0000
nmap <leader>gp <Plug>(GitGutterPreviewHunk)

" Filetypes
" ==================
"
" Markdown
function! s:md_settings()
	nmap j gj
	nmap k gk
	set colorcolumn=0
	set nocursorline
	set lbr
	execute "silent! CocDisable"
	colorscheme base16-atelier-forest
endfunction

" Everything Else
function! s:code_settings()
	nmap j <Down>
	nmap k <Up>
	set colorcolumn=88
	set cursorline
	set nolbr
	execute "silent! CocEnable"
	colorscheme base16-gigavolt
endfunction

" autocmd BufNew,BufEnter * call s:code_settings()
" autocmd BufNew,BufEnter *.md call s:md_settings()

