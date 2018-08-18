"
"   ██╗   ██╗ ██╗ ███╗   ███╗ ██████╗   ██████╗
"   ██║   ██║ ██║ ████╗ ████║ ██╔══██╗ ██╔════╝
"   ██║   ██║ ██║ ██╔████╔██║ ██████╔╝ ██║
"   ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ██╔══██╗ ██║
" ██╗╚████╔╝  ██║ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗
" ╚═╝ ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝

set nocompatible					" Turn of compatibility
set nobk							" Don't create backup files
set ai								" Turn on auto indentation
set si								" Turn on smart indentation
set ru								" Turn on ruler
set sc								" Show commands
set smarttab						" Turn on smart tabs
set ts=4 sts=4 sw=4 noexpandtab		" TAB === X spaces
set backspace=indent,eol,start		" Allow backspace/delete in insert mode
set hlsearch						" Highlight search results
set incsearch						" Turn on incremental searching
set history=100						" Keep X commands in history
set number							" set line number
set t_Co=256						" Enable 256 colors
set noswapfile
set listchars=tab:��,trail:�

set background=dark
colorscheme liquid

" FOCUS BETWEEN WINDOWS
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" FILES SEARCHING
set path+=**						" Search down into filefolders
set wildmenu						" Display all matching files when we tab complete
set wildignore+=*/node_modules/*	" Ignore some directories for searching

" FILE BROWSING
let g:netrw_banner = 0				" Hide the top banner
let g:netrw_liststyle = 3			" Tree view
let g:netrw_browse_split = 4		" Open files in prior window
let g:netrw_altv = 1				" Open splits to the right
let g:netrw_winsize = 25			" Tree width

" SNIPPETS
" 
" Help comment for future:
" nnoremap ,html :-1read $HOME/.vim/snippets/...html<CR>3j...

" SYNTAX HIGHLIGHTING
syntax on							" Turn on syntax highlighting
filetype plugin on					" Enable plugins (for netrw)
autocmd BufNewFile,BufRead *.ts set syntax=javascript
autocmd BufNewFile,BufRead *.tsx set syntax=javascript

" Highlight the 81 column
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Swap v and CTRL-V, because Block mode is more useful that Visual mode
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v
