set nocompatible
filetype off


" Start vundle script
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin ()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
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
