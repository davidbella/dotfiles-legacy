call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mileszs/ack.vim'

Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

call plug#end()

""" Some standard vim config
" Line numbers
set number

" All the indentations
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set backspace=2

" Show tabs and trailing spaces
set listchars=tab:>-,trail:.
set list!

" Allow buffer switching without saving them
set hidden

""" NERDTree
" Automagically open NERDTree on vim startup and default to file window instead of NERDTree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

" Automagically close NERDTree if it is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Adjust NERDTree window size
let NERDTreeWinSize=40

" Hide cursorline in NERDTree
let NERDTreeHighlightCursorline=0

" Don't wrap directories with single folder nodes
" This doesn't seem to work - there are open issues on NERDTree about this:
" https://github.com/scrooloose/nerdtree/issues/547
let NERDTreeCascadeOpenSingleChildDir=0

" Binding to locate current file in NERDTree
map <leader>l :NERDTreeFind<cr>

""" Buffergator
" Have Buffergator open from the right and make it bigger
let buffergator_viewport_split_policy="R"
let buffergator_split_size=80

""" ack.vim
" Set ack.vim to use ag
if executable('ag')
  let g:ackprg = 'ag'
endif

" Auto preview for ack.vim
let g:ackpreview=1

""" NERDCommentor
" filetype plugin on
filetype plugin on

" Add a space after the comment character
let NERDSpaceDelims = 1

" Keybinding for comment - TODO: make this better?
map <C-c> \c<space>
