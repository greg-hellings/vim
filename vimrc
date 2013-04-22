execute pathogen#infect()
set nocompatible
filetype plugin indent on
syntax enable
set number

let g:php_folding=2
set foldmethod=syntax

inoremap <M-Right>   <Esc>gti
inoremap <M-Left>    <Esc>gTi
inoremap <M-t>       <Esc>:tabnew<Cr>
nnoremap <M-Right>   gt
nnoremap <M-Left>    gT
nnoremap <M-t>       :tabnew<Cr>

map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

map <F4> <Esc>:NERDTreeToggle<Cr>

let Tlist_Ctags_Cmd 		= "/usr/bin/ctags"
let Tlist_WinWidth  		= 50
let Tlist_Exit_OnlyWindow 	= 1
let Tlist_Use_Right_Window 	= 1
map <F3>       <Esc>:TlistToggle<Cr>
map <S-F5>     <Esc>:!/usr/bin/ctags -R --fields=+ialS --extra=+q . <Cr>

map <F2>	<Esc>\be
set hidden
