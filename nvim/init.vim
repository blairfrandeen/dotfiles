" Mappings
" =============
let mapleader =","

" Use tab to switch to matching bracket
nnoremap <tab> %
vnoremap <tab> %

"Quickly edit .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

"Quickly source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>


" Editor Options
"===================
" Use vim settings and not VI settings. Required for polylot
set nocompatible

" Show line numbers and relative line numbers
set number
set relativenumber
set signcolumn=auto

" Highlight current line
set cursorline

" Set line length marker
set colorcolumn=88

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


" Plugins
" ================
call plug#begin()

" Editor enhancements
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'

"" GUI Enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'

" Language-specific
Plug 'rust-lang/rust.vim'

call plug#end()

" Theme
" ================
set termguicolors
colorscheme base16-gigavolt

" Plugin-specific Settings
" ================
" coc.nvim
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location lis
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
"
" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Install coc extensions automatically:
let g:coc_global_extensions = ['coc-calc', 'coc-css', 'coc-git', 'coc-sh', 'coc-html', 'coc-json', 'coc-pyright', 'coc-rust-analyzer']

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

autocmd BufNew,BufEnter *.md call s:md_settings()
" autocmd BufNew,BufEnter *.md set colorcolumn=0 nnoremap j gj nnoremap k gk

