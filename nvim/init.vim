" Don't forget to run :UpdateRemotePlugins everytime you change remote plugins
" like tscwatch.py


let mapleader = " "

" ==========================================
" ==========================================
" ================= Plugins ================
" ==========================================
" ==========================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Open ranger inside vim
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
Plug 'rbgrouleff/bclose.vim' " Bclose is needed for ranger
Plug 'francoiscabrol/ranger.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" coc for tslinting, auto complete and prettier
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colors
Plug 'arzg/vim-plan9'

" coc extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-yank', 'coc-prettier']

" git
Plug 'tpope/vim-fugitive'

" lightline
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'gitbranch' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" https://github.com/easymotion/vim-easymotion/issues/323

call plug#end()

" ==========================================
" ==========================================
" ================= Basics =================
" ==========================================
" ==========================================
if empty(glob('~/.local/share/nvim/undodir'))
  silent !mkdir ~/.local/share/nvim/undodir
endif

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" No need to show status because of lightline
set noshowmode

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

set nocompatible
set encoding=utf-8
set number relativenumber

" Search
set ignorecase
set smartcase

" Persistent undo
set undofile
set undodir=~/.local/share/nvim/undodir

" Autocomplete
set wildmode=longest,list,full

" Change default split windows positioning
set splitbelow splitright

" Indentation
filetype plugin indent on
set copyindent
set preserveindent
set tabstop=4 	 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set noexpandtab  " Do not convert tab to spaces
set softtabstop=0

set listchars=tab:\|\ " Space after slash
" set list

" ==========================================
" ==========================================
" ================ Commands ================
" ==========================================
" ==========================================
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Typescript filetype
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" Source vim configuration upon save
augroup vimrc
	autocmd! BufWritePost $MYVIMRC nested source % | echom "Reloaded " . $MYVIMRC | redraw
augroup END<Paste>

" ==========================================
" ==========================================
" =============== Mappings =================
" ==========================================
" ==========================================

" Completion
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Vim
map <leader>ve :e $MYVIMRC<CR>
map <leader>vs :so $MYVIMRC<CR>

" Ranger bindings
map <leader>rr :Ranger<CR>
map <leader>rt :vs<CR> <bar> :Ranger<CR>

" Jumps?
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <C-s> :w<CR>
map <leader>ff :Files<CR>
map <leader>bd :bd<CR>
map <leader>bb :Buffers<CR>
map <leader>nh :nohl<CR>


" Fzf actions
function! s:build_location_list(lines)
  call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
  lopen
  lc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_location_list'),
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" quickfix navigation
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>

" Change default splits navigation, saving a one keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Stay the cursor after yank
vmap y ygv<Esc>

" Colors
set termguicolors
set background=dark
set cursorline
"colorscheme plan9
colorscheme liquidprogrammer
