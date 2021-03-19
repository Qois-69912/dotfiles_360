" =============== Neovim plugins =============== "
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall 
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'preservim/nerdcommenter'
Plug 'lambdalisue/fern.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'kassio/neoterm'
Plug 'vimwiki/vimwiki'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
call plug#end()


" =============== Neovim configuration =============== "
" Use system clipboard
set clipboard=unnamedplus

" Indention configuration
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

" Search configuration
set hlsearch
set ignorecase
set incsearch
set smartcase

" Text rendering configuration
set display+=lastline
set encoding=utf-8
set linebreak
syntax enable

" User interface configuration
colorscheme molokai

set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set number 
set mouse=a
set title

hi Normal guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE

" Random configuration
set lazyredraw 
set autochdir
set nocompatible
filetype plugin on
filetype indent plugin on

" =============== Mappings =============== "
" Switch Esc to 'jk'
inoremap jk <Esc>

" Switch 'gk' and 'gj' to 'k' and 'j'
nnoremap j gj
nnoremap k gk

" Switch 'ZZ' and 'ZQ' to 'zz' and 'zq'
nnoremap zz ZZ
nnoremap zq ZQ

" Switch between splits easily
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Resize splits easily
nnoremap <M-L> <C-w>>
nnoremap <M-H> <C-w><
nnoremap <M-J> <C-w>+
nnoremap <M-K> <C-w>-

" Use Ctrl+s to save
nnoremap <silent><C-s> :w<cr>

"C#
autocmd FileType cs nnoremap <silent><M-r> :echo "Compiling Program"<cr> :silent !dotnet build<cr>:silent !termite -t "Run Program" -e "bash -c 'dotnet run --no-build && echo   && echo   && read -n 1 -s -r -p Press_any_Keys_To_Continue...'" &> /dev/null<cr>
autocmd FileType cs nnoremap <silent><M-R> :echo "Running Program"<cr> :silent !termite -t "Run Program" -e "bash -c 'dotnet run --no-build && echo   && echo   && read -n 1 -s -r -p Press_any_Keys_To_Continue...'" &> /dev/null<cr>

" =============== Plugins configuration =============== "
" Vim airline
let g:airline_theme='night_owl'
let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

" Nerdcommenter configuration
map cc <Plug>NERDCommenterToggle

" Fern configuration
let g:fern#drawer_width = 30
let g:fern#default_hidden = 1
let g:fern#renderer#default#collapsed_symbol = "| "
let g:fern#renderer#default#expanded_symbol = "| "

nnoremap <silent> <M-e> :Fern %:h -drawer -toggle<cr>

function! s:init_fern() abort
    nmap <buffer> o <Plug>(fern-action-enter)
    nmap <buffer> u <Plug>(fern-action-leave)
    nmap <buffer> l <Plug>(fern-action-open-or-expand)
    nmap <buffer> e <Plug>(fern-action-open:rightest)
    nmap <buffer> m <Plug>(fern-action-move)
    nmap <buffer> n <Plug>(fern-action-new-path)
    nmap <buffer> r <Plug>(fern-action-reload:all)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> dd <Plug>(fern-action-remove)
    nmap <buffer> c <Plug>(fern-action-copy)
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

" Neoterm
nnoremap <silent> <M-t> :split<cr><C-w>j:resize 10<cr>:Ttoggle<cr>:resize 10<cr>a
tnoremap jk <C-\><C-n>

" Vimwiki
nmap <M-n> <Plug>VimwikiIndex
let g:vimwiki_list = [{'path': '~/Notes/'}]

autocmd FileType vimwiki map <buffer> <M-f> 0<cr>

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

let g:OmniSharp_popup = 1
