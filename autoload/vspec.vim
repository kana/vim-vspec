" vspec - Test framework for Vim script
" Version: 0.0.0
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
let s:TRUE = !s:FALES

let s:context_stack = []








" Interface  "{{{1
function! Call(...)  "{{{2
  return call('vspec#call', a:000)
endfunction




function! Ref(...)  "{{{2
  return call('vspec#ref', a:000)
endfunction




function! Set(...)  "{{{2
  return call('vspec#Set', a:000)
endfunction




function! vspec#call(funcname, ...)  "{{{2
  return call(substitute(a:funcname, '^s:', s:hint_sid(), ''), a:000)
endfunction




function! vspec#hint(info)  "{{{2
  if has_key(a:info, 'scope')
    let s:EXPR_HINT_SCOPE = a:info.scope
  endif

  if has_key(a:info, 'sid')
    let s:EXPR_HINT_SID = a:info.sid
  endif

  return
endfunction




function! vspec#ref(varname)  "{{{2
  return s:hint_scope()[a:varname]
endfunction




function! vspec#set(varname, value)  "{{{2
  let _ = s:hint_scope()
  let _[a:varname] = a:value
  return
endfunction




function! vspec#test(specfile)  "{{{2
  call s:push_context({
  \   'total_expectations': 0,
  \   'failures': [],
  \ })

  source `=a:specfile`

  let current_context = s:current_context()
  for current_context.describer in s:extract_describers()
    call {funcname}()
    echon "\n"
  endfor

  call s:output_summary(s:pop_context())

  return
endfunction




" Commands  "{{{2

" FIXME eval magic for :Should
command! -nargs=+ It  call vspec#cmd_It(<q-args>)
command! -nargs=+ Should  call vspec#cmd_Should(<q-args>)








" Misc.  "{{{1
function! vspec#cmd_It(message)  "{{{2
  let _ = s:current_context()
  let _.current_group = a:message
  return
endfunction




function! vspec#cmd_Should(exprs, values)  "{{{2
  let [expr_actual, expr_matcher, expr_expected] = a:exprs
  let [value_actual, value_matcher, value_expected] = a:values
  let current_context = s:current_context()

  if s:matches_p(value_actual, expr_matcher, value_expected)
    echo '.'
  else
    echo 'x'
    call add(current_context.failures,
    \        [describer,
    \         current_context.current_group,
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
  return delete(s:context_stack, -1)
endfunction


function! s:push_context(context)  "{{{3
  call add(s:context_stack, a:context)
  return
endfunction




function! s:extract_describers()  "{{{2
  let f = {}
  function! f.normalize(funcname)
    let _ = split(a:funcname, '__')
    let describer = [funcname, featurename, case]
    let describer.funcname = a:funcname
    let describer.featurename = _[1]
    let describer.case = join(_[2:], '__')
    return describer
  endfunction

  redir => function_names
  silent function /
  redir END

  let _ = split(function_names, '\n')
  let PATTERN = '\v^function \zs(\<SNR\>\d+_describe__\w+)\ze\('
  call map(_, 'matchstr(v:val, PATTERN)'
  call filter(_, 'v:val != ""')
  call map(_, 'substitute(v:val, "<SNR>", "\<SNR>", "")')
  call map(_, 'f.normalize(v:val, "__")')
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
  let VALID_MATCHERS = [
  \   '!=',
  \   '!~',
  \   '<',
  \   '<=',
  \   '==',
  \   '=~',
  \   '>',
  \   '>=',
  \   'is',
  \   'isnot',
  \
  \   '!=?',
  \   '!~?',
  \   '<?',
  \   '<=?',
  \   '==?',
  \   '=~?',
  \   '>?',
  \   '>=?',
  \   'is?',
  \   'isnot?',
  \
  \   '!=#',
  \   '!~#',
  \   '<#',
  \   '<=#',
  \   '==#',
  \   '=~#',
  \   '>#',
  \   '>=#',
  \   'is#',
  \   'isnot#',
  \ ]

  if !has_key(f, a:expr_matcher)
    " FIXME: Useful message
    echoerr 'Invalid a:expr_matcher:' string(a:expr_matcher)
    return s:FALSE
  endif

  return  eval('a:value_actual ' . a:expr_matcher . ' a:value_expected')
endfunction




function! s:output_summary(context)  "{{{2
  let previous_describer = []
  for [describer, group, exprs, values] in a:context.failures
    if describer isnot previous_describer
      echo "\n"
      echo 'In' string(describer)
    endif

    echo "\n"
    echo 'It' a:group
    echo 'FAILED:' join(exprs, ' ')
    echo '  expected:' string(a:values[0])
    echo '       got:' string(a:values[2])

    let previous_describer = describer
  endfor

  echo printf("\n%d examples, %d failures",
  \           a:context.total_expectations,
  \           len(a:context.failures))
  return
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
