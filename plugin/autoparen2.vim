inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ) <Esc>:silent call CloseParen(')')<CR>
inoremap ] <Esc>:silent call CloseParen(']')<CR>
inoremap } <Esc>:silent call CloseParen('}')<CR>

function! CloseParen(mapChar)

  let l:nextChar = strcharpart(getline('.'), getcurpos()[2], 1)
  echo l:nextChar
  if l:nextChar ==# a:mapChar
    call feedkeys("la", 'n')
  else
    call feedkeys('a' . a:mapChar, 'n')
  endif

endfunction
