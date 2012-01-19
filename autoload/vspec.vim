" vspec - Testing framework for Vim script
" Version: @@VERSION@@
" Copyright (C) 2009-2012 Kana Natsuno <http://whileimautomaton.net/>
" License: So-called MIT/X license  {{{
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
" Interface  "{{{1
" Suites  "{{{1
" Prototype  "{{{2

let s:suite = {}

let s:suite.subject = ''
let s:suite.example_list = []  " [Description]
let s:suite.example_dict = {}  " Description -> Function

function! s:suite.add_example(example)
  call add(self.example_list, a:example)
endfunction

function! s:suite.generate_example_function_name(example)
  return substitute(
  \   a:example,
  \   '[^[:alnum:]]',
  \   '\="_" . printf("%02x", char2nr(submatch(0)))',
  \   'g'
  \ )
endfunction




function! vspec#new_suite(subject)  "{{{2
  let s = copy(s:suite)
  let s.subject = a:subject
  let s.example_list = []
  let s.example_dict = {}
  return s
endfunction




function! vspec#add_suite(suite)  "{{{2
  call add(s:all_suites, a:suite)
endfunction

let s:all_suites = []




function! vspec#get_current_suite()  "{{{2
  return s:current_suites[0]
endfunction

let s:current_suites = []




function! vspec#push_current_suite(suite)  "{{{2
  call insert(s:current_suites, a:suite, 0)
endfunction




function! vspec#pop_current_suite()  "{{{2
  return remove(s:current_suites, 0)
endfunction








" Misc.  "{{{1
function! vspec#compile_specfile(specfile_path, result_path)  "{{{2
  let slines = readfile(a:specfile_path)
  let rlines = vspec#translate_script(slines)
  call writefile(rlines, a:result_path)
endfunction




function! vspec#translate_script(slines)  "{{{2
  let rlines = []
  let stack = []

  for sline in a:slines
    let tokens = matchlist(sline, '^\s*describe\s*\(''.*''\)\s*$')
    if !empty(tokens)
      call insert(stack, 'describe', 0)
      call extend(rlines, [
      \   printf('let suite = vspec#new_suite(%s)', tokens[1]),
      \   'call vspec#add_suite(suite)',
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*it\s*\(''.*''\)\s*$')
    if !empty(tokens)
      call insert(stack, 'it', 0)
      call extend(rlines, [
      \   printf('call suite.add_example(%s)', tokens[1]),
      \   printf('function! suite.example_dict[suite.generate_example_function_name(%s)]()', tokens[1]),
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*end\s*$')
    if !empty(tokens)
      let type = remove(stack, 0)
      if type ==# 'describe'
        " Nothing to do.
      elseif type ==# 'it'
        call extend(rlines, [
        \   'endfunction',
        \ ])
      else
        " Nothing to do.
      endif
      continue
    endif

    call add(rlines, sline)
  endfor

  return rlines
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
