" echom "Welcome to the desert of the real."
" Some debugging notes:
"  Check called scripts with   -  :scriptnames
"  Check buffer syntax with    -  :setlocal syntax?
"  For a deeper look at syntax -  :syntax list
"  Also                        -  :verbose set ft?
"  ...and                      -  :e $VIMRUNTIMWE/ftplugin

filetype plugin indent on
syntax on
" highlight search patterns
set hlsearch
" turn on incremental search
set incsearch

" light only
colorscheme default
" colorscheme delek
" dark only
" colorscheme evening
" colorscheme solarized

" Use when displaying bad whitespace
highlight BadWhitespace ctermbg=gray

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" turn off auto-commenting when going to a new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.cxx,*.pl,*.sh,*.js,*.hs set fileformat=unix
"
" Set the default file encoding to UTF-8:
set encoding=utf-8

" Show matching brackets
set showmatch

" automaitcally write before compiling. Undo with :set noautowrite
set autowrite

" Keep the last 200 commands (default is 20)
set history=200
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" show me more of the command window (for linters, etc.)
set cmdheight=2

" make backspace a more flexible
set backspace=indent,eol,start

" -------- rempas -----------
" see http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" You cannot copy and paste these commands?
" map {C-v}{Shift-Down} O{C-v}{Esc}j, etc.
"  This seems to work even w/o shift...nnoremap OB Oj

" set the leader (and local leader?) for more complex mappings
let mapleader="-"

nnoremap <Up> ddkP
nnoremap <Down> ddp
nnoremap <Left> :bp<cr>
nnoremap <Right> :bn<cr>
" indent plain text for markdown code font
nnoremap <leader>pp 0j0i<tab><tab><esc>0

" mode specific mappings
inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
inoremap jk <esc>
inoremap <leader>zz <esc>zza
inoremap <leader>zt <esc>zta
inoremap <leader>zb <esc>zba
inoremap <leader>jj <esc>:call JsBeautify()<cr>a

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" wrap the currently visually selected block in quotes
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>f"

" get a split of the previous buffer
nnoremap <leader>pb :execute "rightbelow vsplit " . bufname("#")<cr>

" automatically make searches magic
nnoremap <leader>/ /\v
nnoremap <leader>? ?\v

" show invisible characters since this is always forgotten
nnoremap <leader>inv :setlocal list!<cr>

" toggle line numbers conveniently
nnoremap <leader>n :setlocal number!<cr>

" foldcolumn toggle
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" quickfix toggle - uses a global var!
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
" we have to initialzie the global var
let g:quickfix_is_open = 0

function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open=0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open=1
  endif
endfunction

" remove trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
endfunction

nnoremap <leader>wsp :call TrimWhiteSpace()<cr>

"""""""""""""""""""""""""""""
" regex's
" note: nnoremap interprets <cr> before exe does, so we need
" to use <lt> as a literal < to get the regex to work.
nnoremap <leader>c :noh<cr>
nnoremap <leader>w :execute "normal! gg" . '/\v\s+$' . "\<lt>cr>"<cr>

"""""""""""""""""""""""""""""
" Status Line
set laststatus=2
set statusline=%f
set statusline+=\ -\
set statusline+=%c
set statusline+=\ -\
set statusline+=%l/%L
set statusline+=\ -\
set statusline+=%n
set statusline+=\ -\
set statusline+=%y


"""""""""""""""""""""""""""""
" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
set tabstop=2

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
set shiftwidth=2
set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab


"""""""""""""""""""""""""""""
" use this function and the one below to restore cursor position when restarting a session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    normal! zz
    return 1
  endif
endfunction
" use this function and the one above to restore cursor position when restarting a session
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" just to keep things tidy...
noh
