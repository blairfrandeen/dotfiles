" Remap the escape key on the keyboard or through the OS ;)

" Leader key
let mapleader = ","

"Quickly edit .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

"Quickly source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"Show tabs & whitespace
nnoremap <leader>ws :set listchars=space:_,tab:>~ list<cr>

" Move lines up or down
nnoremap <c-j> ddjP
nnoremap <c-k> ddkP
inoremap <c-j> <esc>ddjPi
inoremap <c-k> <esc>ddkPi

" Shift-Tab to remove indent
inoremap <s-tab> <esc><<a

" Use spacebar to fold & unfold
nnoremap <space> za

" Show line numbers and relative line numbers
set number
set relativenumber

" Start showing search as soon as you start typing
set incsearch

" Search is case insensitive when all lowercase, but case sensitive when
" search contains any caps.
set ignorecase
set smartcase

" Get rid of 'Q' functionality
nmap Q <Nop>

" Markdown Specific settings
au BufRead,BufNewFile *.md set lbr nonumber 

" Stop code from unfoldign when I start a comment block
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" Format optoins setting, see help fo-table

" Cursor in insert & normal modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Enable filetype plugins
filetype plugin on

let g:python_highlight_all = 1

" Enable color scheme
set t_Co=256
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

autocmd BufNewFile,BufRead * setlocal formatoptions=tcq

" Autoindent, tabs as four spaces
set ai ts=4 sw=4 sts=4 et

" Remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Code folding
set foldmethod=syntax

" Compile & run C files
command C w | !gcc -Wall -g %
command R !./a.out
command CR w | !gcc -Wall -g % && ./a.out

" Run Python Files
command P w | !python3 %

" Clipboard
" If not working, try the following command in terminal:
" sudo apt install vim-gtk3
set clipboard=unnamedplus

" Allow scrolling with mousewheel
set mouse=a

" Nerdcommenter options
let NERDSpaceDelims=1   " spaces around delimeters
let g:NERDAltDelims_c=1 " use // instead of /* */ for C comments
