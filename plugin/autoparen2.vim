" Auto-close parenthsis {{{
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ) <Esc>:call CloseParen(')')<CR>
inoremap ] <Esc>:call CloseParen(']')<CR>
inoremap } <Esc>:call CloseParen('}')<CR>

function! CloseParen(mapChar)

  let l:nextChar = strcharpart(getline('.'), getcurpos()[2], 1)
  echo l:nextChar
  if l:nextChar ==# a:mapChar
    call feedkeys("la", 'n')
  else
    call feedkeys('a' . a:mapChar, 'n')
  endif

endfunction
" }}}

" New line between braces {{{
" Must not use <Esc> here. That changes the value of "@.".
inoremap <CR> <C-o>:call InsertNewlineInBraces(@.)<CR>

function! InsertNewlineInBraces(prevInput)

  let l:prevInsTwoChars = strcharpart(a:prevInput, strlen(a:prevInput) - 2)
  let l:charsAround = strcharpart(getline('.'), getcurpos()[2] - 2, 2)
  call feedkeys("\<CR>", 'n')
  if l:prevInsTwoChars == '{}' && l:charsAround == '{}'
    call feedkeys(".\<CR>\<C-d>\<Esc>kS", 'n')
  endif

endfunction
" }}}
