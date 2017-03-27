" Auto-close parenthsis {{{
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ) <C-\><C-o>:call autoparen#Close(')')<CR>
inoremap ] <C-\><C-o>:call autoparen#Close(']')<CR>
inoremap } <C-\><C-o>:call autoparen#Close('}')<CR>

function! autoparen#Close(mapChar)

  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  let l:feedkey = (l:nextChar ==# a:mapChar) ? "\<Right>" : a:mapChar
  call feedkeys(l:feedkey, 'n')

endfunction
" }}}

" New line between braces {{{
" Must not use <Esc> here. That changes the value of "@.".
inoremap <CR> <C-o>:call autoparen#InsertNewlineInBraces(@.)<CR>

function! autoparen#InsertNewlineInBraces(prevInput)

  let l:prevInsTwoChars = strpart(a:prevInput, strlen(a:prevInput) - 2)
  let l:charsAround = strpart(getline('.'), col('.') - 2, 2)
  call feedkeys("\<CR>", 'n')
  if l:prevInsTwoChars == '{}' && l:charsAround == '{}'
    " All belows work. Notice the 'S' command makes proper indent automatically.
    call feedkeys("\<C-o>O", 'n')
    " call feedkeys("\<CR>\<Esc>kS", 'n')
    " call feedkeys("\<Esc>kA\<CR>", 'n')
  endif

endfunction
" }}}
