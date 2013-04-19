execute pathogen#infect()
syntax on
filetype plugin indent on

inoremap <M-Right>   <Esc>gt
inoremap <M-Left>    <Esc>gT
nnoremap <M-Right>   gt
nnoremap <M-Left>    gT

map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

map <F4> <Esc>:NERDTreeToggle<Cr>
