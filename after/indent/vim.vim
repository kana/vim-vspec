" Vim additional indent settings: vim/vspec - indent vspec commands
" Version: 1.9.2
" Copyright (C) 2009-2021 Kana Natsuno <https://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

" NB: This file should be named after/indent/vim/vspec.vim, but unlike
" $VIMRUNTIME/ftplugin.vim, $VIMRUNTIME/indent.vim does not :runtime! neither
" indent/{filetype}_*.vim nor indent/{filetype}/*.vim.

let &l:indentexpr = 'GetVimVspecIndent(' . &l:indentexpr . ')'
setlocal indentkeys+==end

if exists('*GetVimVspecIndent')
  finish
endif

function GetVimVspecIndent(base_indent)
  let indent = a:base_indent

  let prev_lnum = prevnonblank(v:lnum - 1)
  let prev_line = getline(prev_lnum)
  if 0 <= match(prev_line, '\(^\||\)\s*\(after\|before\|context\|describe\|it\)\>')
    let delta = &l:shiftwidth
  elseif 0 <= match(getline(v:lnum), '^\s*end')
    let delta = -&l:shiftwidth
  else
    let delta = 0
  endif

  if delta != 0
    let indent = (indent != -1 ? indent : indent(v:lnum)) + delta
  endif

  return indent
endfunction

" __END__
" vim: foldmethod=marker
