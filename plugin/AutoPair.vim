" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

" Auto-close parenthsis, brackets and braces {{{
inoremap ( ()<C-G>U<Left>
inoremap [ []<C-G>U<Left>
inoremap { {}<C-G>U<Left>
inoremap <silent> ) <C-\><C-O>:call AutoPair#Close(')')<CR>
inoremap <silent> ] <C-\><C-O>:call AutoPair#Close(']')<CR>
inoremap <silent> } <C-\><C-O>:call AutoPair#Close('}')<CR>
inoremap <silent> " <C-\><C-O>:call AutoPair#Quote('"')<CR>
inoremap <silent> ' <C-\><C-O>:call AutoPair#Quote("'")<CR>
inoremap <silent> ` <C-\><C-O>:call AutoPair#Quote('`')<CR>
"}}}

" New line between brace pair {{{
" Must not use <Esc> here, since it changes the value of "@.".
inoremap <silent> <CR> <C-\><C-O>:call AutoPair#InsertBlankLine(@.)<CR><CR>
"}}}

fun! AutoPair#Quote(mapChar)
  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  let l:prevChar = strpart(getline('.'), col('.') - 2, 1)
  let l:feedkeys = (l:nextChar ==# a:mapChar || l:prevChar ==# a:mapChar) ? a:mapChar : a:mapChar . a:mapChar . "\<left>"
  call feedkeys(l:feedkeys, 'n')
endf

function! AutoPair#Close(mapChar) "{{{

  let l:nextChar = strpart(getline('.'), col('.') - 1, 1)
  let l:feedkey = (l:nextChar ==# a:mapChar) ? "\<Right>" : a:mapChar
  call feedkeys(l:feedkey, 'n')

endfunction "}}}

function! AutoPair#InsertBlankLine(prevInput) "{{{

  let l:charsAround = strpart(getline('.'), col('.') - 2, 2)
  if !(l:charsAround == '{}' || l:charsAround == '[]')
    return
  endif

  let l:prevIns2Chars = strpart(a:prevInput, strlen(a:prevInput) - 2)
  if (l:prevIns2Chars == '{}') || (l:prevIns2Chars == '[]')
    let l:doit = 1
  else
    let l:prevIns7Chars = strpart(a:prevInput, strlen(a:prevInput) - 7)
    if (l:prevIns7Chars == "{}\<C-G>U\<Left>") ||
    \  (l:prevIns7Chars == "[]\<C-G>U\<Left>")
      let l:doit = 1
    endif
  endif

  if exists('l:doit')
    call feedkeys("\<Esc>O", 'n')
  endif

endfunction "}}}

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
