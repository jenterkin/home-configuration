call plug#begin('~/.vim/plugged')
Plug '~/repos/vim-autosource'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'cespare/vim-toml'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'vimwiki/vimwiki'
call plug#end()

set autochdir

set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
filetype plugin on
syntax on

colorscheme nord

" disables opaque background -- allows for transparency
hi Normal ctermbg=none
hi NonText ctermbg=none

" Relative line numbers
set number relativenumber

"Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

nnoremap <C-P> :FZF<return>

let b:ale_linters = {
    \ 'rust': ['analyzer'],
    \ 'vim': ['vimls', 'vint'],
    \ }
"
" let b:ale_fixers = {
"     \ 'python': ['black'],
" 	\ 'rust': ['trim_whitespace', 'rustfmt'],
" 	\ 'typescript': ['trim_whitespace', 'prettier'],
"     \ }

let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc

let g:airline_powerline_fonts = 1

" Open file at last position
augroup lastpos
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | exe "normal! zz" | endif
augroup END

set mouse=a

" Set lower updatetime for faster gitgutter updates
set updatetime=100

let g:python_highlight_all = 1

let g:localvimrc_whitelist='/home/jenterkin/repos/**/.*'

" source ~/.config/nvim/plugins/source_parents.vim
