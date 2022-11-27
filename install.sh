#!/usr/bin/env sh
# 
# Copyright (c) 2021 Jolth <jolthgs at gmail.com>
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

a2vimdir() {
  if [ -d $HOME/.vim ]; then
    mv $HOME/.vim{,_$(date +"%s")};
  fi
  mkdir $A2VIMDIR
}

vim_plu() {
    echo "Install vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  

success "Installed " "vim-plug"
cat << EOF > $VIMRC
" -------------------------- vim-plug
call plug#begin()
"-- NERDTree
"Plug 'preservim/NERDTree'
"-- vim-airline
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
call plug#end()

"### plugin conf 

" --------------------------
EOF
}

vim_support() {
  #vim --version|grep --color -E 'python|lua|statusline'
  vim --version|grep --color -E 'statusline'
  success "verificated vim support"
}

vim_conf() {
cat << EOF > $VIMRC
"===========================================================================
" General
"===========================================================================
set nocompatible                        "Use Vim settings, rather then Vi settings (it influences other options)
set backspace=indent,eol,start          "Allow backspacing over indention, line breaks and insertion start.
set history=1000                        " Set the commands to save in history default number is 20.
set showcmd                             "Show incomplete commands at the bottom
set showmode                            "Show current mode at the bottom
set hidden                              "Manage multiple buffers effectively
set cursorcolumn                       " Highlight cursor line underneath the cursor vertically.

"===========================================================================
" Interface
"===========================================================================
set ruler                               "Always show cursor position
set wildmenu                            "Display command line's tab complete options as a menu
set tabpagemax=40                       "Maximum number of tab pages that can be opened from the command line
"set cursorline                         "Highlight the line currently under cursor
set number                              "Show line numbers on sidebar
set relativenumber
set noerrorbells                        "Disable beep on errors.
set visualbell                          "Flash the screen instead of beeping on errors
set mouse=a                             "Enable mouse for scrolling and resizing
set title                               "Set the window’s title, reflecting the file currently being edited
set background=dark                     "Use colors that suit a dark background
"colorscheme: default, blue, darkblue, delek, desert, 
"elford, evening, industry, koehler, morning, murphy, 
"pablo, peachpuff, ron, shine, slate, torte, zellner  
colorscheme elflord

"===========================================================================
"  Indentation
"===========================================================================
set autoindent                          " automatic indent new lines, align the new line indent with the previous line
filetype off 
" Enable type file detection. Vim will be able to try to detect the type of file in use.
"filetype on
" Enable plugins and load plugin for the detected file type.
"filetype plugin on
" Load an indent file for the detected file type.
"filetype indent on
filetype plugin indent on               "Smart auto indentation (instead of old smartindent option)

"===========================================================================
"  Formatting
"===========================================================================
set autoread               " set to auto read when a file is changed from the outside
set encoding=utf-8         " set utf8 as standard encoding and en_US as the standard language
"inoremap # X<BS>#
set nowrap                 " Dot not wrap lines. to display long lines as just one line (i.e. you have to scroll horizontally to see the entire line)
set ffs=unix,dos,mac       " use Unix as the standard file type
set softtabstop=2          " insert/delete # spaces when hitting a TAB/BACKSPACE (Indent by 2 spaces when hitting tab. For python 'set softtabstop=4')
set tabstop=4              " Show existing tab with 4 space width
set shiftwidth=4           " operation >> indents 4 columns; << unindents 4 columns (Indent by 4 spaces when auto-indenting)
set smartindent            " be smart about it. like above but more generic
set expandtab              " use space characters instead of TAB, insert spaces when hitting TABs
set nosmarttab             " fuck tabs
set textwidth=180           " lines longer than 179 columns will be broken
set colorcolumn=+1         " color column 180

"===========================================================================
"  Search
"===========================================================================
set incsearch                           "Find the next match as we type the search
set hlsearch                            "Highlight searches by default.
set ignorecase
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase                           " ... unless you type a capital.
set showmatch                           " Show matching words during a search.

"===========================================================================
" Text rendering options:
"===========================================================================
set linebreak                           "Wrap lines at convenient points, avoid wrapping a line in the middle of a word.
set scrolloff=10                        "The number of screen lines to keep above and below the cursor
set sidescrolloff=5                     "The number of screen columns to keep to the left and right of the cursor.
syntax enable                           "Enable syntax highlighting.

"===========================================================================
"  Miscellaneous 
"===========================================================================
set confirm                             "Display a confirmation dialog when closing an unsaved file.
set nomodeline                          "Ignore file’s mode lines; use vimrc configurations instead.
set nrformats-=octal                    "Interpret octal as decimal when incrementing numbers.
"set shell==/usr/bin/zsh                "The shell used to execute commands.
"set spell                              "Enable spellchecking.

"===========================================================================
"  Remapping
"===========================================================================
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

"===========================================================================
" statusline
"===========================================================================
set laststatus=2            " Show the statusline in all buffers (0 - disabled)
set statusline=                          " left align
set statusline+=%2*\                     " blank char
set statusline+=%2*\%{StatuslineMode()}
set statusline+=%2*\
set statusline+=%1*[
set statusline+=%1*\%f                  " short filename
set statusline+=%1*]
set statusline+=%=                       " right align
set statusline+=%*
set statusline+=%3*\%h%m%r               " file flags (help, read-only, modified)
set statusline+=%4*\%{b:gitbranch}       " include git branch
set statusline+=%3*\%.25F                " long filename (trimmed to 25 chars)
set statusline+=%3*\::
set statusline+=%3*\%l/%L\\|             " line count
set statusline+=%3*\%y                   " file type
hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
hi User2 ctermbg=green ctermfg=black guibg=green guifg=black
hi User3 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen

"" statusline functions
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
      return "NORMAL"
  elseif l:mode==?"v"
      return "VISUAL"
  elseif l:mode==#"i"
      return "INSERT"
  elseif l:mode==#"R"
      return "REPLACE"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    lcd %:p:h
    let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
    lcd -
    if l:gitrevparse!~"fatal: not a git repository"
      let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
    endif
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"===========================================================================
"  Python
"===========================================================================
augroup .py
    autocmd!
    autocmd FileType foo setlocal softtabstop=0 noexpandtab nosmarttab shiftwidth=4 tabstop=4 textwidth=79
augroup END
"===========================================================================
"  HMTL
"===========================================================================
autocmd FileType html setlocal textwidth=500

"===========================================================================
"  Others
"===========================================================================
" Persistent undo
set undofile                  " Maintain undo history between sessions
set undodir=~/.vim/undodir    " Dedicated directory for these undo history files

" Swap file
"set noswapfile                " Disable swap file
set swapfile
set directory=~/.vim/swp//    " Swap file organizaion. save all the swap files in location. 

" Backup files
set nobackup
set nowb
"set backup
"set writebackup
"set backupdir=~/.vim/.backup//

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

EOF

echo "bind -r '\C-s' ; stty -ixon" >> $HOME/.bashrc && source $HOME/.bashrc
success "loaded vimrc basic " "config"

}

swap_file() {
  mkdir $A2VIMDIR/swp
}

persistent_undo() {
  mkdir $A2VIMDIR/undodir
}

#nerdtree_conf() {
#}


#main() {
a2vimdir
vim_support;
vim_conf
persistent_undo
swap_file
#vim_plu

#}
