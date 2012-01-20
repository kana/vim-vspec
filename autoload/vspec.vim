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
" Variables  "{{{1

let s:custom_matchers = {}  " MatcherName => Funcref








" Interface  "{{{1
function! vspec#customize_matcher(matcher_name, funcref)  "{{{2
  let s:custom_matchers[a:matcher_name] = a:funcref
endfunction




function! vspec#test(specfile_path)  "{{{2
  let compiled_specfile_path = tempname()
  call vspec#compile_specfile(a:specfile_path, compiled_specfile_path)

  execute 'source' compiled_specfile_path

  let example_count = 0
  for suite in s:all_suites
    call vspec#push_current_suite(suite)
      for example in suite.example_list
        let example_count += 1
        try
          call suite.example_dict[suite.generate_example_function_name(example)]()
          " TODO: Support SKIP.
          echo printf('%s %d - %s', 'ok', example_count, example)
        catch /^vspec:/
          if v:exception =~# '^vspec:ExpectationFailure:'
            let xs = matchlist(v:exception, '^vspec:ExpectationFailure:\(\a\+\):\(.*\)$')
            let type = xs[1]
            let i = eval(xs[2])
            if type ==# 'MismatchedValues'
              echo printf('%s %d - %s', 'not ok', example_count, example)
              echo '# Expected' i.expr_actual i.expr_matcher i.expr_expected
              echo '#       Actual value:' string(i.value_actual)
              if !vspec#is_custom_matcher(i.expr_matcher)
                echo '#     Expected value:' string(i.value_expected)
              endif
            elseif type ==# 'TODO'
              echo printf(
              \   '%s %d - # TODO %s', 'not ok',
              \   example_count,
              \   example
              \ )
            else
              echo printf('%s %d - %s', 'not ok', example_count, example)
              echo '#' substitute(v:exception, '^vspec:', '', '')
            endif
          else
            echo printf('%s %d - %s', 'not ok', example_count, example)
            echo '#' substitute(v:exception, '^vspec:', '', '')
          endif
        endtry
      endfor
    call vspec#pop_current_suite()
  endfor
  echo printf('1..%d', example_count)
  echo ''

  call delete(compiled_specfile_path)
endfunction




" Commands  "{{{2

command! -bar -complete=expression -nargs=+ Should
\ call vspec#cmd_Should(
\   s:TRUE,
\   vspec#parse_should_args(<q-args>, 'raw'),
\   map(vspec#parse_should_args(<q-args>, 'eval'), 'eval(v:val)')
\ )

command! -bar -complete=expression -nargs=+ ShouldNot
\ call vspec#cmd_Should(
\   s:FALSE,
\   vspec#parse_should_args(<q-args>, 'raw'),
\   map(vspec#parse_should_args(<q-args>, 'eval'), 'eval(v:val)')
\ )

function! vspec#cmd_Should(truth, exprs, values)
  let d = {}
  let [d.expr_actual, d.expr_matcher, d.expr_expected] = a:exprs
  let [d.value_actual, d.value_matcher, d.value_expected] = a:values

  if a:truth != vspec#are_matched(d.value_actual, d.value_matcher, d.value_expected)
    throw 'vspec:ExpectationFailure:MismatchedValues:' . string(d)
  endif
endfunction

command! -bar -nargs=0 TODO
\ throw 'vspec:ExpectationFailure:TODO:' . string({})




" Predefined Custom Matchers  "{{{2

function! vspec#_matcher_true(value)
  return type(a:value) == type(0) ? !!(a:value) : s:FALSE
endfunction
call vspec#customize_matcher('true', function('vspec#_matcher_true'))

function! vspec#_matcher_false(value)
  return type(a:value) == type(0) ? !(a:value) : s:FALSE
endfunction
call vspec#customize_matcher('false', function('vspec#_matcher_false'))








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
" Constants  "{{{2

let s:FALSE = 0
let s:TRUE = !0

let s:VALID_MATCHERS_EQUALITY = [
\   '!=',
\   '==',
\   'is',
\   'isnot',
\
\   '!=?',
\   '==?',
\   'is?',
\   'isnot?',
\
\   '!=#',
\   '==#',
\   'is#',
\   'isnot#',
\ ]
let s:VALID_MATCHERS_REGEXP = [
\   '!~',
\   '=~',
\
\   '!~?',
\   '=~?',
\
\   '!~#',
\   '=~#',
\ ]
let s:VALID_MATCHERS_ORDERING = [
\   '<',
\   '<=',
\   '>',
\   '>=',
\
\   '<?',
\   '<=?',
\   '>?',
\   '>=?',
\
\   '<#',
\   '<=#',
\   '>#',
\   '>=#',
\ ]
let s:VALID_MATCHERS_CUSTOM = [
\   'be',
\ ]
let s:VALID_MATCHERS = (s:VALID_MATCHERS_CUSTOM
\                       + s:VALID_MATCHERS_EQUALITY
\                       + s:VALID_MATCHERS_ORDERING
\                       + s:VALID_MATCHERS_REGEXP)




function! vspec#compile_specfile(specfile_path, result_path)  "{{{2
  let slines = readfile(a:specfile_path)
  let rlines = vspec#translate_script(slines)
  call writefile(rlines, a:result_path)
endfunction




function! vspec#are_matched(value_actual, expr_matcher, value_expected)  "{{{2
  if vspec#is_custom_matcher(a:expr_matcher)
    let custom_matcher_name = a:value_expected
    if !has_key(s:custom_matchers, custom_matcher_name)
      throw
      \ 'vspec:InvalidOperation:Unknown custom matcher - '
      \ . string(custom_matcher_name)
    endif
    return !!s:custom_matchers[custom_matcher_name](a:value_actual)
  elseif vspec#is_equality_matcher(a:expr_matcher)
    let type_equality = type(a:value_actual) == type(a:value_expected)
    if vspec#is_negative_matcher(a:expr_matcher) && !type_equality
      return s:TRUE
    else
      return type_equality && eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
    endif
  elseif vspec#is_ordering_matcher(a:expr_matcher)
    if (type(a:value_actual) != type(a:value_expected)
    \   || !vspec#is_orderable_type(a:value_actual)
    \   || !vspec#is_orderable_type(a:value_expected))
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  elseif vspec#is_regexp_matcher(a:expr_matcher)
    if type(a:value_actual) != type('') || type(a:value_expected) != type('')
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  else
    throw 'vspec:InvalidOperation:Unknown matcher - ' . string(a:expr_matcher)
  endif
endfunction




function! vspec#is_custom_matcher(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_CUSTOM, a:expr_matcher)
endfunction




function! vspec#is_equality_matcher(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_EQUALITY, a:expr_matcher)
endfunction




function! vspec#is_matcher(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS, a:expr_matcher)
endfunction




function! vspec#is_negative_matcher(expr_matcher)  "{{{2
  " FIXME: Ad hoc way.
  return vspec#is_matcher(a:expr_matcher) && a:expr_matcher =~# '\(!\|not\)'
endfunction




function! vspec#is_orderable_type(value)  "{{{2
  " FIXME: +float
  return type(a:value) == type(0) || type(a:value) == type('')
endfunction




function! vspec#is_ordering_matcher(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_ORDERING, a:expr_matcher)
endfunction




function! vspec#is_regexp_matcher(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_REGEXP, a:expr_matcher)
endfunction




function! vspec#parse_should_args(s, mode)  "{{{2
  let CMPS = join(map(copy(s:VALID_MATCHERS), 'escape(v:val, "=!<>~#?")'), '|')
  let _ = matchlist(a:s, printf('\C\v^(.{-})\s+(%%(%s)[#?]?)\s+(.*)$', CMPS))
  let tokens =  _[1:3]
  let [_actual, _matcher, _expected] = copy(tokens)
  let [actual, matcher, expected] = copy(tokens)

  if a:mode ==# 'eval'
    if vspec#is_matcher(_matcher)
      let matcher = string(_matcher)
    endif
    if vspec#is_custom_matcher(_matcher)
      let expected = string(_expected)
    endif
  endif

  return [actual, matcher, expected]
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
