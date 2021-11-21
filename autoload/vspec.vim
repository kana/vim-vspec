" vspec - Testing framework for Vim script
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

" NB: Script-local variables created by the following :import syntax behave
" differently from normal ones.  For example:
" {{{
"     import * as Vim9 from '../import/vspec.vim'
"
"     let s:Normal = {}
"     let s:Normal.Return42 = s:Vim9.Return42
"
"     echo s:Normal
"     " ==> {'Return42': function('<80><fd>R2_Return42')}
"     echo s:Vim9
"     " ==> E1029: Expected '.' but got
"
"     echo s:Normal.Return42
"     " ==> <80><fd>R2_Return42
"     echo s:Vim9.Return42
"     " ==> <80><fd>R2_Return42
"
"     echo s:Normal.Return42()
"     " ==> 42
"     echo s:Vim9.Return42()
"     " ==> 42
"
"     call s:Normal.Return42()
"     " ==> No error.
"     call s:Vim9.Return42()
"     " ==> E121: Undefined variable: s:Vim9
"     " This variable seems to be available only in a context where arbitrary
"     " expressions are available.  (:call basically takes a function 'name'.)
"
"     eval s:Normal.Return42()
"     " ==> No error.
"     eval s:Vim9.Return42()
"     " ==> No error.
" }}}

import {
\   Be,
\   BreakLineForcibly,
\   Call,
\   Equal,
\   Expect,
\   GenerateDefaultFailureMessage,
\   GenerateFailureMessage,
\   GetHintedScope,
\   GetHintedSid,
\   GetInternalCallStackForExpect,
\   Hint,
\   IsCustomMatcher,
\   IsEqualityMatcher,
\   IsMatcher,
\   IsNegativeMatcher,
\   IsOrderableType,
\   IsOrderingMatcher,
\   IsRegexpMatcher,
\   ParseString,
\   PrettyString,
\   Ref,
\   ResetContext,
\   RunSuites,
\   SaveContext,
\   Set,
\   SimplifyCallStack,
\   Skip,
\   SplitAtMatcher,
\   ThrowInternalException,
\   Todo
\ } from '../import/vspec.vim'

" Constants  "{{{1
" Fundamentals  "{{{2

let s:FALSE = 0
let s:TRUE = !0








" Variables  "{{{1
let s:all_suites = []  "{{{2
" :: [Suite]




let s:custom_matchers = {}  "{{{2
" :: MatcherNameString -> Matcher




" s:expr_hinted_scope  "{{{2
let s:expr_hinted_scope =
\ 's:ThrowInternalException("InvalidOperation", {"message": "Scope hint is not given"})'
" An expression which is evaluated to a script-local scope for Ref()/Set().




" s:expr_hinted_sid  "{{{2
let s:expr_hinted_sid =
\ 's:ThrowInternalException("InvalidOperation", {"message": "SID hint is not given"})'
" An expression which is evaluated to a <SID> for Call().




let s:saved_scope = {}  "{{{2
" A snapshot of a script-local variables for :SaveContext/:ResetContext.




let s:suite = {}  "{{{2
" The prototype for suites.








" Interface  "{{{1
" :Debug  "{{{2
command! -complete=expression -nargs=+ Debug
\   call s:BreakLineForcibly()
\ | echo '#' <args>




" :Expect  "{{{2
command! -complete=expression -nargs=+ Expect
\   if <q-args> =~# '^expr\s*{'
\ |   let s:_ = {}
\ |   let [s:_.ae, s:_.ne, s:_.me, s:_.ee] =
\      s:parse_should_arguments(<q-args>, 'eval')
\ |   let s:_.nv = eval(s:_.ne)
\ |   let s:_.mv = eval(s:_.me)
\ |   let s:_.ev = eval(s:_.ee)
\ |   let s:_.av = 0
\ |   let s:_.ax = 0
\ |   let s:_.at = 0
\ |   try
\ |     let s:_.av = eval(substitute(s:_.ae, '^expr\s*{\s*\(.*\S\)\s*}$', '\1', ''))
\ |   catch
\ |     let s:_.ax = v:exception
\ |     let s:_.at = v:throwpoint
\ |   endtry
\ |   call s:cmd_Expect(
\       s:parse_should_arguments(<q-args>, 'raw'),
\       [{'value': s:_.av, 'exception': s:_.ax, 'throwpoint': s:_.at},
\        s:_.nv, s:_.mv, s:_.ev]
\     )
\ | else
\ |   call s:cmd_Expect(
\       s:parse_should_arguments(<q-args>, 'raw'),
\       map(s:parse_should_arguments(<q-args>, 'eval'), 'eval(v:val)')
\     )
\ | endif




" :ResetContext  "{{{2
command! -bar -nargs=0 ResetContext
\ call s:ResetContext()




" :SaveContext  "{{{2
command! -bar -nargs=0 SaveContext
\ call s:SaveContext()




" :SKIP  "{{{2
command! -nargs=+ SKIP
\ call s:Skip(s:ParseString(<q-args>))




" :TODO  "{{{2
command! -bar -nargs=0 TODO
\ call s:Todo()




function! Be(a1, a2 = v:none)  "{{{2
  return s:Be(a:a1, a:a2)
endfunction




function! Call(function_name, args)  "{{{2
  return s:Call(a:function_name, a:args)
endfunction




function! Equal(expected)  "{{{2
  return s:Equal(a:expected)
endfunction




function! ExpectV2(actual)  "{{{2
  return s:Expect(a:actual)
endfunction




function! Ref(variable_name)  "{{{2
  return s:Ref(a:variable_name)
endfunction




function! Set(variable_name, value)  "{{{2
  call s:Set(a:variable_name, a:value)
endfunction




function! vspec#call(function_name, args)  "{{{2
  " Deprecated.  Kept for backward compatibility.
  return s:Call(a:function_name, a:args)
endfunction




function! vspec#customize_matcher(matcher_name, maybe_matcher)  "{{{2
  if type(a:maybe_matcher) == type({})
    let matcher = a:maybe_matcher
  else
    let matcher = {'match': a:maybe_matcher}
  endif
  let s:custom_matchers[a:matcher_name] = matcher
endfunction




function! vspec#debug(...)  "{{{2
  " Deprecated.  Kept for backward compatibility.
  call s:BreakLineForcibly()
  echo '#' join(a:000, ' ')
endfunction




function! vspec#hint(info)  "{{{2
  call s:Hint(a:info)
endfunction




function! vspec#pretty_string(value)  "{{{2
  " Deprecated.  Kept for backward compatibility.
  return s:PrettyString(a:value)
endfunction




function! vspec#ref(variable_name)  "{{{2
  " Deprecated.  Kept for backward compatibility.
  return s:Ref(a:variable_name)
endfunction




function! vspec#set(variable_name, value)  "{{{2
  " Deprecated.  Kept for backward compatibility.
  call s:Set(a:variable_name, a:value)
endfunction




function! vspec#test(specfile_path)  "{{{2
  let compiled_specfile_path = tempname()
  call s:compile_specfile(a:specfile_path, compiled_specfile_path)

  try
    execute 'source' compiled_specfile_path
    call s:RunSuites(s:all_suites)
  catch
    echo '#' repeat('-', 77)
    echo '#' s:SimplifyCallStack(v:throwpoint, expand('<sfile>'), 'unknown')
    for exception_line in split(v:exception, '\n')
      echo '#' exception_line
    endfor
    echo 'Bail out!  Unexpected error happened while processing a test script.'
  finally
    call s:BreakLineForcibly()
  endtry

  call delete(compiled_specfile_path)
endfunction




" Predefined custom matchers - to_be_false  "{{{2

let s:to_be_false = {}

function! s:to_be_false.match(value)
  return type(a:value) == type(0) ? !(a:value) : s:FALSE
endfunction

function! s:to_be_false.failure_message_for_should(value)
  return 'Actual value: ' . s:PrettyString(a:value)
endfunction

let s:to_be_false.failure_message_for_should_not =
\ s:to_be_false.failure_message_for_should

call vspec#customize_matcher('to_be_false', s:to_be_false)
call vspec#customize_matcher('toBeFalse', s:to_be_false)




" Predefined custom matchers - to_be_true  "{{{2

let s:to_be_true = {}

function! s:to_be_true.match(value)
  return type(a:value) == type(0) ? !!(a:value) : s:FALSE
endfunction

function! s:to_be_true.failure_message_for_should(value)
  return 'Actual value: ' . s:PrettyString(a:value)
endfunction

let s:to_be_true.failure_message_for_should_not =
\ s:to_be_true.failure_message_for_should

call vspec#customize_matcher('to_be_true', s:to_be_true)
call vspec#customize_matcher('toBeTrue', s:to_be_true)








" Predefined custom matchers - to_throw  "{{{2

let s:to_throw = {}

function! s:to_throw.match(result, ...)
  return a:result.exception isnot 0 && (a:0 == 0 || a:result.exception =~# a:1)
endfunction

function! s:to_throw.failure_message_for_should(result, ...)
  return printf(
  \   'But %s was thrown',
  \   a:result.exception is 0 ? 'nothing' : string(a:result.exception)
  \ )
endfunction

let s:to_throw.failure_message_for_should_not =
\ s:to_throw.failure_message_for_should

call vspec#customize_matcher('to_throw', s:to_throw)








" Suites  "{{{1
function! s:suite.add_example(example_description)  "{{{2
  call add(self.example_list, a:example_description)
endfunction




function! s:suite.after_block()  "{{{2
  " No-op to avoid null checks.
endfunction




function! s:suite.before_block()  "{{{2
  " No-op to avoid null checks.
endfunction




function! s:suite.generate_example_function_name(example_index)  "{{{2
  return '_' . a:example_index
endfunction




function! s:suite.has_parent()  "{{{2
  return !empty(self.parent)
endfunction




function! s:suite.run_after_blocks()  "{{{2
  call self.after_block()
  if self.has_parent()
    call self.parent.run_after_blocks()
  endif
endfunction




function! s:suite.run_before_blocks()  "{{{2
  if self.has_parent()
    call self.parent.run_before_blocks()
  endif
  call self.before_block()
endfunction




function! vspec#add_suite(suite)  "{{{2
  call add(s:all_suites, a:suite)
endfunction




function! vspec#new_suite(subject, parent_suite)  "{{{2
  let s = copy(s:suite)

  let s.subject = a:subject  " :: SubjectString
  let s.parent = a:parent_suite  " :: Suite
  let s.pretty_subject = s.has_parent()
  \                      ? s.parent.pretty_subject . ' ' . s.subject
  \                      : s.subject
  let s.example_list = []  " :: [DescriptionString]
  let s.example_dict = {}  " :: ExampleIndexAsIdentifier -> ExampleFuncref

  return s
endfunction








" Compiler  "{{{1
function! s:compile_specfile(specfile_path, result_path)  "{{{2
  let slines = readfile(a:specfile_path)
  let rlines = s:translate_script(slines)
  call writefile(rlines, a:result_path)
endfunction




function! s:translate_script(slines)  "{{{2
  let rlines = []
  let stack = []

  call add(rlines, 'let suite_stack = [{}]')

  for sline in a:slines
    let tokens = matchlist(sline, '^\s*\%(describe\|context\)\s*\(\(["'']\).*\2\)\s*$')
    if !empty(tokens)
      call insert(stack, 'describe', 0)
      call extend(rlines, [
      \   printf('let suite = vspec#new_suite(%s, suite_stack[-1])', tokens[1]),
      \   'call vspec#add_suite(suite)',
      \   'call add(suite_stack, suite)',
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*it\s*\(\(["'']\).*\2\)\s*$')
    if !empty(tokens)
      call insert(stack, 'it', 0)
      call extend(rlines, [
      \   printf('call suite.add_example(%s)', tokens[1]),
      \   'function! suite.example_dict[suite.generate_example_function_name(len(suite.example_list) - 1)]()',
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*before\s*$')
    if !empty(tokens)
      call insert(stack, 'before', 0)
      call extend(rlines, [
      \   'function! suite.before_block()',
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*after\s*$')
    if !empty(tokens)
      call insert(stack, 'after', 0)
      call extend(rlines, [
      \   'function! suite.after_block()',
      \ ])
      continue
    endif

    let tokens = matchlist(sline, '^\s*end\s*$')
    if !empty(tokens)
      let type = remove(stack, 0)
      if type ==# 'describe'
        call extend(rlines, [
        \   'call remove(suite_stack, -1)',
        \   'let suite = suite_stack[-1]',
        \ ])
      elseif type ==# 'it'
        call extend(rlines, [
        \   'endfunction',
        \ ])
      elseif type ==# 'before'
        call extend(rlines, [
        \   'endfunction',
        \ ])
      elseif type ==# 'after'
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








" :Expect magic  "{{{1
function! s:cmd_Expect(exprs, vals)  "{{{2
  let d = {}
  let [d.expr_actual, d.expr_not, d.expr_matcher, d.expr_expected] = a:exprs
  let [d.value_actual, d.value_not, d.value_matcher, d.value_expected] = a:vals

  let truth = d.value_not ==# ''
  if truth != s:are_matched(d.value_actual, d.value_matcher, d.value_expected)
    let d.type = 'MismatchedValues'
    call s:ThrowInternalException('ExpectationFailure', d)
  endif
endfunction




function! s:parse_should_arguments(s, mode)  "{{{2
  let tokens = s:SplitAtMatcher(a:s)
  let [_actual, _not, _matcher, _expected] = tokens
  let [actual, not, matcher, expected] = tokens

  if a:mode ==# 'eval'
    if s:IsMatcher(_matcher)
      let matcher = string(_matcher)
    endif
    if s:IsCustomMatcher(_matcher)
      let expected = '[' . _expected . ']'
    endif
    let not = string(_not)
  endif

  return [actual, not, matcher, expected]
endfunction








" Matchers  "{{{1
function! s:are_matched(value_actual, expr_matcher, value_expected)  "{{{2
  if s:IsCustomMatcher(a:expr_matcher)
    let custom_matcher_name = a:expr_matcher
    let matcher = get(s:custom_matchers, custom_matcher_name, 0)
    if matcher is 0
      call s:ThrowInternalException(
      \   'InvalidOperation',
      \   {'message': 'Unknown custom matcher - '
      \               . string(custom_matcher_name)}
      \ )
    endif
    let Match = get(matcher, 'match', 0)
    if Match is 0
      call s:ThrowInternalException(
      \   'InvalidOperation',
      \   {'message': 'Custom matcher does not have match function - '
      \               . string(custom_matcher_name)}
      \ )
    endif
    return !!call(
    \   Match,
    \   [a:value_actual] + a:value_expected,
    \   matcher
    \ )
  elseif s:IsEqualityMatcher(a:expr_matcher)
    let type_equality = type(a:value_actual) == type(a:value_expected)
    if s:IsNegativeMatcher(a:expr_matcher) && !type_equality
      return s:TRUE
    else
      return type_equality && eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
    endif
  elseif s:IsOrderingMatcher(a:expr_matcher)
    if (type(a:value_actual) != type(a:value_expected)
    \   || !s:IsOrderableType(a:value_actual)
    \   || !s:IsOrderableType(a:value_expected))
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  elseif s:IsRegexpMatcher(a:expr_matcher)
    if type(a:value_actual) != type('') || type(a:value_expected) != type('')
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  else
    call s:ThrowInternalException(
    \   'InvalidOperation',
    \   {'message': 'Unknown matcher - ' . string(a:expr_matcher)}
    \ )
  endif
endfunction




" Tools  "{{{1
function! vspec#scope()  "{{{2
  return s:
endfunction




function! vspec#sid()  "{{{2
  return maparg('<SID>', 'n')
endfunction
nnoremap <SID>  <SID>








" __END__  "{{{1
" vim: foldmethod=marker
