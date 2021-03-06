" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

"------------------
" Syntax and indent
"------------------

syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them
set autoindent

" colorscheme settings
set bg=dark
set term=screen-256color
colorscheme PaperColor

"---------------------
" Basic editing config
"---------------------

set shortmess+=I " Disable the default Vim startup message.
set number " Show line numbers.
set relativenumber " This enables relative line numbering mode.
set laststatus=2 " Always show the status line at the bottom, even if you only have one window open.
set backspace=indent,eol,start " Allow backspacing over everything
set hidden " Allow auto-hiding of edited buffers
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set mouse+=a " enable mouse mode (scrolling, selection, etc)

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters.
set ignorecase
set smartcase

" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

"--------------------
" Misc configurations
"--------------------

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Try to prevent bad habits like using the arrow keys for movement.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

"---------------------
" Plugin configuration
"---------------------

"Airline
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
