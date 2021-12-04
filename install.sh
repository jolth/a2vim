#!/usr/bin/env sh
# 
# Jolth <jolthgs@gmail.com> 
# https://github.com/jolth/a2vim
# License: MIT
#
Color_off='\033[0m'       # Text Reset

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

msg () {
	  printf "%b${Color_off}\n" "$1" >&2
  }

success() {
	  msg "${Green}[✔]: ${1}${2}"
  }

error () {
	  msg "${Red}[✘]: ${1}${2}"
  }

output_color () {
	  printf "%b" "${1}"
  }

output_clear () {
	  printf "%b" "${Color_off}"
  }

A2VIMDIR=$HOME/.vim
VIMRC=$HOME/.vimrc

if [ -d $HOME/.vim ]; then
	mv $HOME/.vim{,_$(date +"%s")};
fi

vim_plu() {
    echo "Install vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  

success "Installed " "vim-plug"
cat << EOF > $VIMRC
call plug#begin()
Plug 'preservim/NERDTree'
call plug#end()
" --------------------------
EOF
}

vim_conf() {
cat << EOF > $VIMRC
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
" Enable type file detection. Vim will be able to try to detect the type of file in use.
"filetype on
" Enable plugins and load plugin for the detected file type.
"filetype plugin on
" Load an indent file for the detected file type.
"filetype indent on
filetype plugin indent on
" Turn syntax highlighting on.
syntax on
" Add numbers to each line on the left-hand side.
set number
" Highlight cursor line underneath the cursor horizontally.
"set cursorline
" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn
" Set shift width to 4 spaces.
set shiftwidth=4
" Set tab width to 4 columns.
set tabstop=4
" Use space characters instead of tabs.
set expandtab
" Enabling Automatic Indentation
set autoindent
" Do not save backup files.
set nobackup
" Removing Multiple Spaces on Single Backspace
set softtabstop=4
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Ignore capital letters during search.
set ignorecase
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
" Show matching words during a search.
set showmatch
" Use highlighting when doing a search.
set hlsearch
" Show partial command you type in the last line of the screen.
set showcmd
" Show the mode you are on the last line.
set showmode
" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Set the commands to save in history default number is 20.
set history=1000
"colorscheme: default, blue, darkblue, delek, desert, 
"elford, evening, industry, koehler, morning, murphy, 
"pablo, peachpuff, ron, shine, slate, torte, zellner  
colorscheme default

" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" Change the mapleader from \ to ,
let mapleader = ","
let g:mapleader = ","
" exit to normal mode with 'jk'
inoremap jk <esc>
" allow quit via single keypress (Q). If you have unsaved buffers, it'll prompt you before exiting.
map Q :qa<CR>
" normal mode: saves the file and exits. keypress ,,
nnoremap <leader><leader> :x<cr>
" insert mode: saves the file and exits. keypress ,,
inoremap <leader><leader> <esc>:xa<cr>
"----- Keymaps in Insert mode:
"ctrl + q: to exit discarding changes.
inoremap <c-q> <esc>:qa!<cr>                " quit discarding changes
"ctrl + s: to save.
inoremap <c-s> <esc>:w<cr>a
"ctrl + d: to save and exit
inoremap <c-d> <esc>:wq!<cr>               " save and exit
"----- Keymaps in Normal mode:
"ctrl + d: to save and exit
nnoremap <c-d> :wq!<cr>
"ctrl + s: to save.
"nmap <c-s> :w<cr>
nnoremap <c-s> :w<cr>
"ctrl + q: to exit discarding changes.
nnoremap <c-q> :qa!<cr>

" You can toggle the syntax on/off with keyup <F7>:
map <F7> :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>
" This appends the current date and time after the cursor:
"map <F2> a<C-R>=strftime("%c")<CR><Esc>
" use <leader>N toggle line numbers on/off
nnoremap <leader>N :setlocal number!<cr>
" use <leader>l to toggle display of whitespace
"nmap l :set list!<CR>
nmap <leader>l :set list!<CR>

EOF

echo "bind -r '\C-s' ; stty -ixon" >> $HOME/.bashrc && source $HOME/.bashrc
success "loaded vimrc basic " "config"
}

#nerdtree_conf() {
#}


#main() {


vim_conf
#vim_plu

#}
