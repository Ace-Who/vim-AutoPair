" Auto-close parenthsis {{{
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ) <C-\><C-o>:call autoparen#Close(')')<CR>
inoremap ] <C-\><C-o>:call autoparen#Close(']')<CR>
inoremap } <C-\><C-o>:call autoparen#Close('}')<CR>

function! autoparen#Close(mapChar)

  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  echo l:nextChar
  if l:nextChar ==# a:mapChar
    call feedkeys("\<Right>", 'n')
  else
    call feedkeys(a:mapChar, 'n')
  endif

endfunction
" }}}

" New line between braces {{{
" Must not use <Esc> here. That changes the value of "@.".
inoremap <CR> <C-o>:call autoparen#InsertNewlineInBraces(@.)<CR>

function! autoparen#InsertNewlineInBraces(prevInput)

  let l:prevInsTwoChars = strcharpart(a:prevInput, strlen(a:prevInput) - 2)
  let l:charsAround = strcharpart(getline('.'), getcurpos()[2] - 2, 2)
  call feedkeys("\<CR>", 'n')
  if l:prevInsTwoChars == '{}' && l:charsAround == '{}'
    " Both below work. Notice the 'S' command makes proper indent automatically.
    call feedkeys("\<CR>\<Esc>kS", 'n')
    "call feedkeys("\<Esc>kA\<CR>", 'n')
  endif

endfunction
" }}}
