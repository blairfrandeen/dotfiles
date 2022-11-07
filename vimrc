" Mappings
"===================
" Leader key
let mapleader = ","

" Move lines up or down
nnoremap <c-j> ddjP
nnoremap <c-k> ddkP
inoremap <c-j> <esc>ddjPi
inoremap <c-k> <esc>ddkPi

" Shift-Tab to remove indent
inoremap <s-tab> <esc><<a

" Use spacebar to fold & unfold
nnoremap <space> za

"Quickly edit .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

"Quickly source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"Show tabs & whitespace
nnoremap <leader>ws :set listchars=space:_,tab:>~ list<cr>

" Get rid of 'Q' functionality
nmap Q <Nop>

" Use tab to switch to matching bracket
nnoremap <tab> %
vnoremap <tab> %

" Editor Options
"===================
" Show line numbers and relative line numbers
set number
set relativenumber

" Highlight current line
set cursorline

" Set line length marker
set colorcolumn=100

" Start showing search as soon as you start typing
set incsearch

" Search is case insensitive when all lowercase, but case sensitive when
" search contains any caps.
set ignorecase
set smartcase

" Cursor in insert & normal modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Code folding
set foldmethod=syntax

" Stop code from unfoldign when I start a comment block
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Use system clipboard
set clipboard=unnamedplus
" If not working, try the following command in terminal:
" sudo apt install vim-gtk3

" Allow scrolling with mousewheel
set mouse=a

" Autoindent, tabs as four spaces
set ai ts=4 sw=4 sts=4 et

" Fix indentation for lines starting with #
set cindent
set cinkeys-=0#
set indentkeys-=0#

autocmd BufNewFile,BufRead * setlocal formatoptions=tcq


" Plugin Settings
"===================

" EasyMotion 
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Nerdcommenter
let NERDSpaceDelims=1   " spaces around delimeters
let g:NERDAltDelims_c=1 " use // instead of /* */ for C comments

" File Specific Settings
"===================
" Enable filetype plugins
filetype plugin on

" Markdown 
" ------------------
au BufRead,BufNewFile *.md set lbr nonumber 

" Python 
" ------------------
au BufRead,BufNewFile *.py set foldmethod=indent
augroup black_on_save
  autocmd!
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent! loadview
  autocmd BufWritePre *.py Black
augroup end

" Run Python Files
command P w | !python3 %

" Run pytest
command PT w | !pytest
command Pt w | !pytest

" Add macrcos for debugging with f-strings
" small word
nnoremap <leader>p yiwoprint(f"{<esc>pa=}")<esc>
" big Word
nnoremap <leader>P yiWoprint(f"{<esc>pa=}")<esc>
" selection
vnoremap <leader>p yoprint(f"{<esc>pa=}")<esc>
" RESULT: print(f"{nnoremap=}")

syntax on

let g:python_highlight_all = 1

" C
" ------------------
" Compile & run C files
command C w | !gcc -Wall -g %
command R !./a.out
command CR w | !gcc -Wall -g % && ./a.out

" Rust
" ------------------
" Run rust program
command U w | !cargo run

" Enable color scheme
set t_Co=256
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox


