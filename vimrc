set cin
set nocompatible
set background=dark

filetype indent on
    
set ts=4
set sw=4
"set tw=80
set expandtab
set autoindent
set incsearch
set wildmenu
set scrolloff=5
"set nowrap
set foldcolumn=0
let mapleader=","
set hlsearch

syntax on
filetype on
filetype plugin on

" Color
"if $TERM == 'xterm-256color'
"  set term=gnome-256color
"  colorscheme railscasts
"else
"  colorscheme default
  set background=dark
"endif 

" Couleur du fold
highlight Folded ctermbg=111 ctermfg=green term=bold

set backspace=indent,eol,start
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
map ,C :w<CR>:!aspell -c %<CR>:e %<CR>

"autocmd FileType xml source ~/.vim/script/demi_indent
autocmd FileType ruby source ~/.vim/script/ruby
autocmd FileType php source ~/.vim/script/php
autocmd FileType javascript source ~/.vim/script/js
autocmd FileType yml source ~/.vim/script/yml
autocmd FileType css source ~/.vim/script/css
autocmd FileType cpp source ~/.vim/script/cpp
autocmd FileType rhtml,html,eruby source ~/.vim/script/html

" Save folds before leave
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

" Style du fold 
set foldtext=MyFoldText()
function! Num2S(num, len)
    let filler = "                                                            "
    let text = '' . a:num
    return strpart(filler, 1, a:len - strlen(text)) . text
endfunction

function! MyFoldText()
    let linenum = v:foldstart
    while linenum <= v:foldend
        let linenum = linenum + 1
    endwhile
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    let sub2 = substitute(sub, '^ *', '', 'g')
    let diff = v:foldend - v:foldstart + 1
    return  '+' . v:folddashes . '[' . Num2S(diff,3) . ' lines] ' . sub2
endfunction

" To open the file under the cursor
map gf :tabe <cfile><CR>

set guioptions=a
set guicursor+=a:blinkon0
set guicursor+=a:block-Cursor
set mouse=

"set term=gnome-256color
"let g:molokai_original = 1
"let g:zenburn_high_Contrast=1
"colorscheme molokai
"colorscheme railscasts

inoremap Oq 1
inoremap Or 2
inoremap Os 3
inoremap Ot 4
inoremap Ou 5
inoremap Ov 6
inoremap Ow 7
inoremap Ox 8
inoremap Oy 9
inoremap Op 0
inoremap On .
inoremap Oo /
inoremap Oj *
inoremap Ok +
inoremap Om -

imap ^[OA <ESC>ki
imap ^[OB <ESC>ji
imap ^[OC <ESC>li
imap ^[OD <ESC>hi

