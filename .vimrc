set nocompatible

set number
set cursorline
set ruler
set showmatch

set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set backspace=2

set listchars=tab:>-,trail:.
set list!

set ignorecase
set smartcase
set incsearch
set hlsearch

set ttymouse=xterm2
set mouse=a
set scrolloff=8

set wildmode=longest,list

" vim will reread files when changed
set autoread

" save undo history when buffers are hidden
set hidden

syntax enable
set background=dark
colorscheme solarized

" Set swapfiles out of the way
set swapfile
set dir=~/tmp

" Set Buffergator to open on start
" autocmd vimenter * BuffergatorOpen
" autocmd vimenter * wincmd p

" Don't close Buffergator after selecting a buffer
" let buffergator_autodismiss_on_select=0

" Have Buffergator open from the right and make it bigger
let buffergator_viewport_split_policy="R"
let buffergator_split_size=80

" Automagically open NERDTree on vim startup and default to file window instead of NERDTree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

" Automagically close NERDTree if it is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Adjust NERDTree window size
let NERDTreeWinSize=40

" Binding to locate current file in NERDTree
map <leader>r :NERDTreeFind<cr>

" filetype plugin for use with NERDTree commenter
let NERDSpaceDelims = 1
filetype plugin on
map <C-c> \c<space>

" Automagically open quickfix window after some fugitive-vim commands
autocmd QuickFixCmdPost *grep* cwindow

" Allow ctrl-p to find dot files
let g:ctrlp_dotfiles = 1

" Show buffers in vim-airline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_min_count = 2

let g:airline_powerline_fonts = 1

" let g:airline#extensions#tabline#formatter = 'indent'

" Copy file name to clipboard with ctrl-shift-c
map <leader>c :let @+=expand("%")<CR>

" Run Pathogen
execute pathogen#infect()

" Bind control p file finder to Command-T's - I got used to it
" map <leader>t :ClearCtrlPCache<cr>\|:CtrlP<cr>
" moved to ~/.vim/after/mappings/...
