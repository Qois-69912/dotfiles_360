" =============== Neovim plugins =============== "
" Plugins list 
call plug#begin(system('echo -n "$HOME/.config/nvim/plugged"'))

" Syntax checking 
Plug 'dense-analysis/ale'

" Other utillities
Plug 'preservim/nerdcommenter'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'kassio/neoterm'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax color
Plug 'sheerun/vim-polyglot'

" Rust
Plug 'rust-lang/rust.vim'

call plug#end()


" =============== Neovim configuration =============== "
" Use custom clipboard (xclip)
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

" Theme configuration
colorscheme molokai
syntax enable

" UI Configuration
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set number 
set mouse=a
set showtabline=2
set title
set signcolumn=auto

" Modify Theme
hi Normal guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE
hi TabLineFill cterm=NONE
hi TabLine ctermbg=NONE ctermfg=NONE cterm=NONE
hi SignColumn guibg=NONE ctermbg=NONE

" Other configuration
set lazyredraw 
set autochdir
filetype plugin on
filetype indent plugin on


" =============== Custom Function =============== "
" Neoterm
let term = 0
function CallTerminal(vertical)
    if g:term == 0
        if a:vertical == "0"
            :27 sp
            :exe "normal \<M-j>"
        elseif a:vertical == "1"
            :vsplit
            :exe "normal \<M-l>"
        endif

        :Tnew
        let g:term = 1
    elseif g:term == 1
        :Tclose!
        let g:term = 0
    endif
endfunction

" Rust compile
function RustCompile()
    echo g:term
    if g:term == 1
        :T cargo run
    elseif g:term == 0
        :exe "normal \<M-t>"
        :T cargo run
    endif
endfunction


" =============== General Key Mappings =============== "
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

" Bind Ctrl + p to Alt + p on insert mode
inoremap <M-p> <C-p>

" Active 'nohl'
nnoremap <silent><M-f> :nohl<cr>

" Tab shortcut 
nnoremap <silent><C-t> :tabnew<cr>
nnoremap <silent><C-w> :tabclose<cr>
nnoremap <silent><M-1> 1gt<cr>
nnoremap <silent><M-2> 2gt<cr>
nnoremap <silent><M-3> 3gt<cr>
nnoremap <silent><M-4> 4gt<cr>
nnoremap <silent><M-5> 5gt<cr>
nnoremap <silent><M-6> 6gt<cr>


" =============== Specific filetype Mappings =============== "
" Rust
autocmd FileType rust nnoremap <silent><M-r> :call RustCompile()<cr> 


" =============== Plugins configuration =============== "
" Vim airline
let g:airline_theme='night_owl'
let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
let g:airline#extensions#hunks#enabled = 0 

" Nerdcommenter configuration
let g:NERDSpaceDelims = 1
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
    nmap <buffer> t <Plug>(fern-action-open:tabedit)
    nmap <buffer> m <Plug>(fern-action-move)
    nmap <buffer> n <Plug>(fern-action-new-path)
    nmap <buffer> r <Plug>(fern-action-reload:all)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> dd <Plug>(fern-action-remove)
    nmap <buffer> c <Plug>(fern-action-copy)
    nmap <buffer> zq :q!<cr>
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

" Neoterm
nnoremap <silent> <M-t> :call CallTerminal("0")<cr>
nnoremap <silent> <M-T> :call CallTerminal("1")<cr>
tnoremap jk <C-\><C-n>

" Vimwiki
let g:vimwiki_list = [{'path': '~/Notes/'}]
autocmd FileType vimwiki map <buffer> <M-f> 0<cr>
nmap <M-m> :VimwikiIndex<cr>

" Fugitive
nnoremap <silent> ga :echo "'s' stage file, 'u' unstage file, 'cc' commit change"<cr>:Git<cr> 

" Ale
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
