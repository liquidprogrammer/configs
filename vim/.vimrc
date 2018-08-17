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
set listchars=tab:▸\ ,eol:¬

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

" SYNTAX HIGHLIGHTING
syntax on							" Turn on syntax highlighting
filetype plugin on					" Enable plugins (for netrw)
autocmd BufNewFile,BufRead *.ts set syntax=javascript
autocmd BufNewFile,BufRead *.tsx set syntax=javascript

