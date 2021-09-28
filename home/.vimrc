syntax enable           " enable syntax processing

"	UI Config
set number              " show line numbers
set showcmd
set cursorline
set lazyredraw
set showmatch

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set ruler
set colorcolumn=80
set autoindent
set smartindent

" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When on uses space instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab

" show tabs
set list
set listchars=tab:\|_

set ttyfast
set mouse=a
set ttymouse=xterm2

set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

" highlight unwanted spaces like trailing spaces, spaces before tab, tabs
" that aren't at the start of a line.
" (adopted from https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

