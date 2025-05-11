require("config.lazy")

-- Editor Options
-- ===================
-- Use vim settings & not VI settings
vim.opt.compatible = false

-- Clipboard
-- If not working, try the following command in terminal:
-- sudo apt install vim-gtk3
vim.opt.clipboard = 'unnamedplus'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = auto

-- Highlight current line
vim.opt.cursorline = true

-- Set line length marker
vim.opt.colorcolumn = "88"
vim.opt.textwidth = 0

-- Keep the cursor off the bottom & top of the screen
vim.opt.scrolloff = 5

-- Search is case insensitive when all lowercase, but case sensitive when
-- search contains any caps.
vim.opt.ignorecase = true
vim.opt.smartcase = true	

-- Auto-indent, tabs as 4 spaces
vim.opt.ai = true
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.sts = 4
vim.opt.et = true

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- LSP and completion
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('TabbyML/vim-tabby')

-- Editor enhancements
Plug('tpope/vim-commentary')
Plug('easymotion/vim-easymotion')
Plug('junegunn/fzf', { ['do'] = function() 
    vim.fn['fzf#install()']()
end })
Plug('junegunn/fzf.vim')

-- GUI Enhancements
Plug('chriskempson/base16-vim')
Plug('itchyny/lightline.vim')
Plug('airblade/vim-gitgutter')
Plug('sheerun/vim-polyglot')
Plug('dstein64/nvim-scrollview')
Plug('christoomey/vim-tmux-navigator')

-- Language-specific
Plug('rust-lang/rust.vim')
Plug('rhysd/vim-clang-format')

vim.call('plug#end')


