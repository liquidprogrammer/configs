"
"   ██╗   ██╗ ██╗ ███╗   ███╗ ██████╗   ██████╗
"   ██║   ██║ ██║ ████╗ ████║ ██╔══██╗ ██╔════╝
"   ██║   ██║ ██║ ██╔████╔██║ ██████╔╝ ██║
"   ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ██╔══██╗ ██║
" ██╗╚████╔╝  ██║ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗
" ╚═╝ ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝
"

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" General
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
" Plug 'jiangmiao/auto-pairs'

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar'

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
" With local-eslint opening JS files become veeery slow
" Plug 'mtscout6/syntastic-local-eslint.vim'

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

"Python
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Markdown
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }

" Add plugins to &runtimepath
call plug#end()


" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
let mapleader = ","

set encoding=utf-8  " uft-8 by default
set ls=2            " always show status bar
set incsearch
set hlsearch        " highlight search results
set nu              " show line numbers
set cursorline      " highlight current line

" disable backup/swap files
set nobackup
set nowritebackup
set noswapfile




" ----------------------------------------------------------------------------
" Clipboard - yank, put, etc. to clipboard instead of registers
" ----------------------------------------------------------------------------
set clipboard+=unnamedplus



" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nnoremap <F5> :bnext<CR>
nnoremap <F6> :bprev<CR>


" ----------------------------------------------------------------------------
" Tabbing - overridden by editorconfig, after/ftplugin
" ----------------------------------------------------------------------------

set expandtab                         " default to spaces instead of tabs
set shiftwidth=2                      " softtabs are 2 spaces for expandtab

" Alignment tabs are two spaces, and never tabs. Negative means use same as
" shiftwidth (so the 2 actually doesn't matter).
set softtabstop=2

" real tabs render width. Applicable to HTML, PHP, anything using real tabs.
" I.e., not applicable to JS.
set tabstop=2

" use multiple of shiftwidth when shifting indent levels.
" this is OFF so block comments don't get fudged when using ">>" and "<<"
set noshiftround

" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'. 'tabstop' or 'softtabstop' is used in other places.
set smarttab

set backspace=indent,eol,start        " bs anything



" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
if argc() == 0                        " Show NERDTree if vim started without params
  autocmd VimEnter * NERDTree
endif

map <F3> :NERDTreeToggle<CR>

" NERDTree files highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('jsx', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('html', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')

" ignore files in tree
let NERDTreeIgnore=['\.pyc$', '\~$']




" ----------------------------------------------------------------------------
" CtrlP
" ----------------------------------------------------------------------------
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
nnoremap <C-T> :CtrlPTag<cr>


" ----------------------------------------------------------------------------
" TagBar 
" ----------------------------------------------------------------------------
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0    " autofocus on Tagbar on opened




" ----------------------------------------------------------------------------
" Airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1



" ----------------------------------------------------------------------------
" YouCompleteMe
" ----------------------------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion = 1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>



" ----------------------------------------------------------------------------
" Syntastic
" ----------------------------------------------------------------------------
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
