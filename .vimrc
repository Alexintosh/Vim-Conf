colorscheme monokai
set ai
set number
set noswapfile
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

let g:DisableAutoPHPFolding = 1

"autocmd vimenter * NERDTree"
"autocmd vimenter * if !argc() | NERDTree | endif"
map <C-n> :NERDTreeToggle % <CR>
map <F9>  :tabn<Cr>
map <F8>  :tabp<Cr>
map cc <C-y>,
