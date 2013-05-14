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

" Creates the directory for a file if it doesn't already exist.
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Session management
" Creates a session
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe "mksession! " . b:sessionfile
    echo "updating session"
  endif
endfunction

" Loads a session if it exists
function! LoadSession()
  if argc() == 0
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  else
    let b:sessionfile = ""
    let b:sessiondir = ""
  endif
endfunction

au VimEnter * nested :call LoadSession()
au VimLeave * :call UpdateSession()
map <leader>m :call MakeSession()<CR>
