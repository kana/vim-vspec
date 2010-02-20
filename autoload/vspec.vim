" vspec - Test framework for Vim script
" Version: 0.0.1
" Copyright (C) 2009 kana <http://whileimautomaton.net/>
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
" Variables  "{{{1

let s:EXPR_HINT_SCOPE = '{}'
let s:EXPR_HINT_SID = 's:'

let s:FALSE = 0
let s:TRUE = !s:FALSE

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
let s:VALID_MATCHERS = (s:VALID_MATCHERS_EQUALITY
\                       + s:VALID_MATCHERS_ORDERING
\                       + s:VALID_MATCHERS_REGEXP)

let s:context_stack = []

let s:custom_matchers = {}  " alias => function

let s:saved_scope = {}








" Interface  "{{{1
function! Call(...)  "{{{2
  return call('vspec#call', a:000)
endfunction




function! Ref(...)  "{{{2
  return call('vspec#ref', a:000)
endfunction




function! Set(...)  "{{{2
  return call('vspec#set', a:000)
endfunction




function! vspec#call(function_name, ...)  "{{{2
  return call(substitute(a:function_name, '^s:', s:hint_sid(), ''), a:000)
endfunction




function! vspec#customize_matcher(alias, function)  "{{{2
  let s:custom_matchers[a:alias] = a:function
endfunction




function! vspec#hint(info)  "{{{2
  if has_key(a:info, 'scope')
    let s:EXPR_HINT_SCOPE = a:info.scope
    call vspec#cmd_SaveContext()
  endif

  if has_key(a:info, 'sid')
    let s:EXPR_HINT_SID = a:info.sid
  endif

  return
endfunction




function! vspec#ref(variable_name)  "{{{2
  if a:variable_name =~# '^s:'
    return s:hint_scope()[a:variable_name[2:]]
  else
    echoerr 'Invalid variable_name:' string(a:variable_name)
  endif
endfunction




function! vspec#set(variable_name, value)  "{{{2
  if a:variable_name =~# '^s:'
    let _ = s:hint_scope()
    let _[a:variable_name[2:]] = a:value
  else
    echoerr 'Invalid variable_name:' string(a:variable_name)
  endif
  return
endfunction




function! vspec#test(spec_file)  "{{{2
  call s:push_context({
  \   'total_expectations': 0,
  \   'failures': [],
  \ })

  source `=a:spec_file`

  let current_context = s:current_context()
  for describer in s:extract_describers()
    let current_context.describer = describer

    echo '====' s:description_from_describer(describer)
    call {describer.function_name}()
    echon "\n"
  endfor

  call s:output_summary(s:pop_context())

  return
endfunction




function! vspec#_scope()  "{{{2
  return s:
endfunction




function! vspec#_sid()  "{{{2
  return maparg('<SID>', 'n')
endfunction
nnoremap <SID>  <SID>




" Commands  "{{{2

command! -nargs=+ It  call vspec#cmd_It(<q-args>)

command! -nargs=0 ResetContext  call vspec#cmd_ResetContext()
command! -nargs=0 SaveContext  call vspec#cmd_SaveContext()

command! -nargs=+ Should
\ call vspec#cmd_Should(s:parse_should_args(<q-args>, 'raw'),
\                       map(s:parse_should_args(<q-args>, 'eval'),
\                           'eval(v:val)'))








" Misc.  "{{{1
function! vspec#cmd_It(message)  "{{{2
  let _ = s:current_context()
  let _.group = a:message
  echo '---- It' a:message "\n"
  return
endfunction




function! vspec#cmd_ResetContext()  "{{{2
  call extend(s:hint_scope(), deepcopy(s:saved_scope), 'force')
  return
endfunction




function! vspec#cmd_SaveContext()  "{{{2
  let s:saved_scope = deepcopy(s:hint_scope())
  return
endfunction




function! vspec#cmd_Should(exprs, values)  "{{{2
  let [expr_actual, expr_matcher, expr_expected] = a:exprs
  let [Value_actual, Value_matcher, Value_expected] = a:values
  let current_context = s:current_context()

  if s:matches_p(Value_actual, Value_matcher, Value_expected)
    echon '.'
  else
    echon 'x'
    call add(current_context.failures,
    \        [current_context.describer,
    \         current_context.group,
    \         a:exprs,
    \         a:values])
  endif
  let current_context.total_expectations += 1

  return
endfunction




" Context  "{{{2
function! s:current_context()  "{{{3
  return s:context_stack[-1]
endfunction


function! s:pop_context()  "{{{3
  return remove(s:context_stack, -1)
endfunction


function! s:push_context(context)  "{{{3
  call add(s:context_stack, a:context)
  return
endfunction




function! s:description_from_describer(describer)  "{{{2
  return join([a:describer.feature_name,
  \            substitute(a:describer.case, '_', ' ', 'g')],
  \           ' ')
endfunction




function! s:extract_describers()  "{{{2
  let f = {}
  function! f.normalize(function_name)
    let _ = split(a:function_name, '__')
    let describer = {}
    let describer.function_name = a:function_name
    let describer.feature_name = _[1]
    let describer.case = join(_[2:], '__')
    return describer
  endfunction

  redir => function_names
  silent function /
  redir END

  let _ = split(function_names, '\n')
  let PATTERN = '\v^function \zs(\<SNR\>\d+_describe__\w+)\ze\('
  call map(_, 'matchstr(v:val, PATTERN)')
  call filter(_, 'v:val != ""')
  call map(_, 'substitute(v:val, "<SNR>", "\<SNR>", "")')
  call map(_, 'f.normalize(v:val)')
  call sort(_)

  return _
endfunction




function! s:hint_scope()  "{{{2
  return eval(s:EXPR_HINT_SCOPE)
endfunction




function! s:hint_sid()  "{{{2
  return eval(s:EXPR_HINT_SID)
endfunction




function! s:matches_p(value_actual, expr_matcher, value_expected)  "{{{2
  if !s:valid_matcher_p(a:expr_matcher)
    " FIXME: Useful message
    echoerr 'Invalid a:expr_matcher:' string(a:expr_matcher)
    return s:FALSE
  endif

  if s:valid_matcher_equality_p(a:expr_matcher)
    let type_equality = type(a:value_actual) == type(a:value_expected)
    if s:valid_matcher_negative_p(a:expr_matcher) && !type_equality
      return s:TRUE
    else
      return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
    endif
  elseif s:valid_matcher_ordering_p(a:expr_matcher)
    if type(a:value_actual) != type(a:value_expected)
      return s:FALSE
    endif
    if !(s:orderable_type_p(a:value_actual)
    \    && s:orderable_type_p(a:value_expected))
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  elseif s:valid_matcher_regexp_p(a:expr_matcher)
    if type(a:value_actual) != type('') || type(a:value_expected) != type('')
      return s:FALSE
    endif
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  else
    return eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
  endif
endfunction




function! s:orderable_type_p(value)  "{{{2
  " FIXME: +float
  return type(a:value) == type(0) || type(a:value) == type('')
endfunction




function! s:output_summary(context)  "{{{2
  echon "\n"
  echon "\n"
  echo '**** Result ****'

  let previous_describer = {}
  for [describer, group, exprs, values] in a:context.failures
    if describer isnot previous_describer
      echon "\n"
      echon "\n"
      echo 'In' s:description_from_describer(describer)
    endif

    echon "\n"
    echo 'It' group
    echo 'FAILED:' join(exprs, ' ')
    if s:valid_matcher_equality_p(values[1])
      echo '  expected:' string(values[2])
      echo '       got:' string(values[0])
    else
      echo '       lhs:' string(values[0])
      echo '       rhs:' string(values[2])
    endif

    let previous_describer = describer
  endfor

  echo printf("\n\n%s examples, %s failures\n",
  \           a:context.total_expectations,
  \           len(a:context.failures))
  return
endfunction




function! s:parse_should_args(s, mode)  "{{{2
  let CMPS = join(map(copy(s:VALID_MATCHERS), 'escape(v:val, "=!<>~#?")'), '|')
  let _ = matchlist(a:s, printf('\C\v^(.{-})\s+(%%(%s)[#?]?)\s+(.*)$', CMPS))
  let [actual, matcher, expected] = _[1:3]

  if a:mode ==# 'eval'
    if s:valid_matcher_p(matcher)
      let matcher = string(matcher)
    endif
  endif

  return [actual, matcher, expected]
endfunction




function! s:valid_matcher_p(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS, a:expr_matcher)
endfunction




function! s:valid_matcher_custom_p(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_CUSTOM, a:expr_matcher)
endfunction




function! s:valid_matcher_equality_p(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_EQUALITY, a:expr_matcher)
endfunction




function! s:valid_matcher_negative_p(expr_matcher)  "{{{2
  " FIXME: Ad hoc way.
  return s:valid_matcher_p(a:expr_matcher) && a:expr_matcher =~# '\(!\|not\)'
endfunction




function! s:valid_matcher_ordering_p(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_ORDERING, a:expr_matcher)
endfunction




function! s:valid_matcher_regexp_p(expr_matcher)  "{{{2
  return 0 <= index(s:VALID_MATCHERS_REGEXP, a:expr_matcher)
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
