set nocompatible
filetype off


" Start vundle script
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin ()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'

" End vundle script
call vundle#end ()


set nowrap
syntax on
set t_Co=256
colorscheme gruvbox
set background=dark
set nu
highlight Normal ctermbg=None
highlight NonText ctermbg=None
set shiftwidth=4
set tabstop=4
set smarttab
set autoindent
set sessionoptions=tabpages
set foldenable
set foldmethod=indent
set foldignore=
set expandtab
set softtabstop=4
set cursorline
set splitright

filetype on
filetype plugin on
filetype indent on
set hlsearch
vnoremap // y/<C-R>"<CR>
nnoremap <space> za
vnoremap <space> zf

" for next tab easily
nnoremap <C-n> gt
nnoremap <C-p> gT
set colorcolumn=80

" for visual highlightning
set encoding=utf-8
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" disable highlighting for yaml, because its so f*cking slow
au BufNewFile,BufRead *.yml let b:isYmlFile = 1
au BufNewFile,BufRead *     if exists ('b:isYmlFile') | setlocal syntax=off | endif

" nerdtree configuration
" toggle
map <C-e> :NERDTreeToggle<CR>
" if no file specified, open browser
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" for airline status
let g:airline_powerline_fonts = 0
let g:airline_theme='base16'
let g:airline_symbols_ascii = 1

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
