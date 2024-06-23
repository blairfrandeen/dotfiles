" Mappings
" =============
let mapleader =","

"Quickly edit .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

"Quickly source vimrc
nnoremap <leader>v :source $MYVIMRC<cr>

" Editor Options
"===================
" Use vim settings and not VI settings. Required for polyglot
set nocompatible

" Show line numbers and relative line numbers
set number
set relativenumber
set signcolumn=auto
set nowrap

" Auto-indent, tabs as 4 spaces
set ai ts=4 sw=4 sts=4 et

" Highlight current line
set cursorline

" Set line length marker
set colorcolumn=88
set textwidth=0

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

" Use fzf to switch to an exiting tab
nnoremap <silent> <c-p> :exe "Windows"<cr>

" Use fzf as command finder
nnoremap <silent> <leader>p :exe "Commands"<cr>

" Use fzf to search for files in the current directory. Use ctrl+t to open in a new tab,
" and use enter to open in current tab
nnoremap <silent> <c-t> :exe "Files"<cr>

" Use fzf to search for files in your home directory. Use ctrl+t to open in a new tab,
" and use enter to open in current tab
command! -bang AllFiles call fzf#vim#files('~/', <bang>0)
nnoremap <silent> <leader>t :exe "AllFiles"<cr>

let g:python3_host_prog = '/usr/bin/python3'

" Wrap and linebreak for Markdown
nnoremap <leader>w :set lbr wrap<cr>
nnoremap <leader>W :set nolbr nowrap<cr>

nnoremap <leader>l :nohl<cr>

" Plugins
" ================
call plug#begin()

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Editor enhancements
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" GUI Enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'dstein64/nvim-scrollview'
Plug 'christoomey/vim-tmux-navigator'

" Language-specific
Plug 'rust-lang/rust.vim'
Plug 'psf/black', {'branch': 'stable' }
Plug 'rhysd/vim-clang-format'

call plug#end()
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" Theme
" ================
set termguicolors
colorscheme base16-gruvbox-dark-hard

" Plugin-specific Settings
" ================

" LSP Config
" -----------------------------

lua << END
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.tsserver.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.cssls.setup {}
require'lspconfig'.eslint.setup {}
require'lspconfig'.jsonls.setup {}
require'lspconfig'.vimls.setup {}

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
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
END

" Completion
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
EOF

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
endfunction

autocmd BufWritePre * silent! lua vim.lsp.buf.format()

" C/C++ auto formatting
let g:clang_format#auto_format = 1

" Everything Else
function! s:code_settings()
	nmap j <Down>
	nmap k <Up>
	set colorcolumn=88
	set cursorline
	set nolbr
endfunction

autocmd BufNew,BufEnter * call s:code_settings()
autocmd BufNew,BufEnter *.md call s:md_settings()

