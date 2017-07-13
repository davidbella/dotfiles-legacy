call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-fugitive'
Plug 'fousa/vim-flog'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'

Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'plasticboy/vim-markdown'
Plug 'neomake/neomake' " to replace syntastic, hopefully

Plug '0ax1/lxvc'

call plug#end()

""" Some standard vim config
" Line numbers
set number
set numberwidth=5

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

" leader-c to copy current file name into clipboard buffer
nmap <leader>c :let @+ = expand("%")<cr>

""" Buffergator
" Have Buffergator open from the right and make it bigger
let buffergator_viewport_split_policy="R"
let buffergator_split_size=80
let g:buffergator_show_full_directory_path=0

""" ack.vim
" Set ack.vim to use ag
if executable('ag')
  let g:ackprg = 'ag'
endif

" Auto preview for ack.vim turned off
let g:ackpreview=0

""" NERDCommentor
" filetype plugin on
filetype plugin on

" Add a space after the comment character
let NERDSpaceDelims = 1

" Keybinding for comment - TODO: make this better?
map <C-c> \c<space>

" Seems to be an issue with git gutter right now, disabling these for now...
" let g:gitgutter_eager = 1
" let g:gitgutter_realtime = 1

" neomake syntax highlighting
let g:neomake_ruby_rubocop_maker = {
  \ 'args': ['--config', 'config/.rubocop.yml']
  \ }
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']

let g:neomake_javascript_eslint_maker = {
  \ 'exe': './node_modules/.bin/eslint',
  \ 'args': ['--no-color', '--format', 'compact', '--config', './.eslintrc'],
  \ 'errorformat': '%f: line %l\, col %c\, %m'
  \ }
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake

" set javascript syntax for .es6 files
autocmd BufNewFile,BufRead *.es6 set syntax=javascript

let g:jsx_ext_required = 0

function! LinePercent()
  return line('.') * 100 / line('$') . '%'
endfunction

" statusline
set statusline=/%f
set statusline+=\ %m        " Modified flag
set statusline+=%=          " Switch to the right side
set statusline+=--->\       " this is an indicator for how far over you are
set statusline+=%c\ \ \ \   " Column
set statusline+=%l          " Current line
set statusline+=/           " Separator
set statusline+=%L\ \       " Total lines
set statusline+=%{LinePercent()}

" show me 80 character limit
highlight ColorColumn ctermbg=lightgrey
set colorcolumn=81

" ctrlp needs some more flexibility for the namely app
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" auto wrap .txt files
" set textwidth=80
" :au BufNewFile,BufRead *.txt set wrap
" :au BufNewFile,BufRead *.txt set linebreak

""" Vim Markdown
" disable folding
let g:vim_markdown_folding_disabled = 1

let g:rails_projections = { "app/lib/*.rb": { "alternate": ["spec/lib/%s_spec.rb"] } }
let g:rails_projections = { "app/assets/javascripts/*.es6": { "alternate": ["app/assets/test/%s.spec.es6"] } }
let g:rails_projections = { "app/assets/javascripts/ui/review_cycles/steps/*.es6": { "alternate": ["app/assets/test/ui/review_cycles/steps/%s.spec.es6"] } }
