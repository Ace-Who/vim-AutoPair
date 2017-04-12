" Auto-close parenthsis, brackets and braces {{{
inoremap ( ()<C-G>U<Left>
inoremap [ []<C-G>U<Left>
inoremap { {}<C-G>U<Left>
inoremap ) <C-\><C-O>:call autoclose#Close(')')<CR>
inoremap ] <C-\><C-O>:call autoclose#Close(']')<CR>
inoremap } <C-\><C-O>:call autoclose#Close('}')<CR>
"}}}

function! autoclose#Close(mapChar) "{{{

  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  let l:feedkey = (l:nextChar ==# a:mapChar) ? "\<Right>" : a:mapChar
  call feedkeys(l:feedkey, 'n')

endfunction "}}}

" New line between braces 
" Must not use <Esc> here, since it changes the value of "@.".
inoremap <CR> <C-O>:call autoclose#InsertBlankLine(@.)<CR><CR>

function! autoclose#InsertBlankLine(prevInput) "{{{

  let l:prevIns2Chars = strpart(a:prevInput, strlen(a:prevInput) - 2)
  let l:prevIns7Chars = strpart(a:prevInput, strlen(a:prevInput) - 7)
  let l:charsAround = strpart(getline('.'), col('.') - 2, 2)
  if (l:prevIns2Chars == '{}' && l:charsAround == '{}') ||
   \ (l:prevIns2Chars == '[]' && l:charsAround == '[]') ||
   \ (l:prevIns7Chars == "{}\<C-G>U\<Left>" && l:charsAround == '{}') ||
   \ (l:prevIns7Chars == "[]\<C-G>U\<Left>" && l:charsAround == '[]')
    call feedkeys("\<Esc>O", 'n')
    " Belows also work. Notice the 'S' command makes proper indent
    " automatically.
    " "\<CR>\<Esc>kS"
    " "\<Esc>kA\<CR>"
  endif

endfunction "}}}
