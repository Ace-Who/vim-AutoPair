" Auto-close parenthsis, brackets and braces {{{
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ) <C-\><C-o>:call autoclose#Close(')')<CR>
inoremap ] <C-\><C-o>:call autoclose#Close(']')<CR>
inoremap } <C-\><C-o>:call autoclose#Close('}')<CR>

function! autoclose#Close(mapChar)

  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  let l:feedkey = (l:nextChar ==# a:mapChar) ? "\<Right>" : a:mapChar
  call feedkeys(l:feedkey, 'n')

endfunction
" }}}

" New line between braces {{{
" Must not use <Esc> here. That changes the value of "@.".
inoremap <CR> <C-o>:call autoclose#InsertBlankLine(@.)<CR>

function! autoclose#InsertBlankLine(prevInput)

  let l:prevInsTwoChars = strpart(a:prevInput, strlen(a:prevInput) - 2)
  let l:charsAround = strpart(getline('.'), col('.') - 2, 2)
  let l:keySeq = "\<CR>"
  let l:keySeq .=
  \ (l:prevInsTwoChars == '{}' && l:charsAround == '{}') ||
  \ (l:prevInsTwoChars == '[]' && l:charsAround == '[]')
  \ ? "\<Esc>O" : ''
  " Belows also work. Notice the 'S' command makes proper indent automatically.
  "\<CR>\<Esc>kS"
  "\<Esc>kA\<CR>"
  call feedkeys(l:keySeq, 'n')

endfunction
" }}}
