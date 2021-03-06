set tabstop=4
set shiftwidth=4
set expandtab

execute pathogen#infect()
set nocompatible
set mouse=a
filetype plugin indent on
syntax enable
set number

let g:php_folding=2
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_ignore = 'control/tmp'
set foldmethod=indent

map <F2>	<Esc>\be
map <F3> <Esc>:%s/\t/        /g
map <F4> <Esc>:NERDTreeToggle<Cr>
map <F6> <Esc>:CtrlP<Cr>

" Allows use of Ctrl-hjkl to swich splits without resizing them
map <C-j> <C-w>j<C-w><Cr>
map <C-k> <C-w>k<C-w><Cr>
map <C-h> <C-w>h<C-w><Cr>
map <C-l> <C-w>l<C-w><Cr>

set hidden

" Creates the directory for a file if it doesn't already exist.
function! s:MkNonExDir(file, buf)
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
    let b:args = []
    let b:loadsession = 1
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    for arg in argv()
        if (!isdirectory(arg) && filereadable(arg))
            let b:loadsession = 0
        endif
    endfor
    if ( b:loadsession == 1 && filereadable(b:sessionfile) )
        exe 'source ' b:sessionfile
    endif
endfunction

au VimEnter * nested :call LoadSession()
au VimLeave * :call UpdateSession()
map <F9> :call MakeSession()<CR>
