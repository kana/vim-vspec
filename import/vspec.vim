vim9script
# vspec - Testing framework for Vim script
# Version: 1.9.2
# Copyright (C) 2009-2021 Kana Natsuno <https://whileimautomaton.net/>
# License: MIT license  {{{
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# }}}

# Interface  # {{{1
export def Call(function_name: string, args: list<any>): any  # {{{2
  return call(substitute(function_name, '^s:', s:GetHintedSid(), ''), args)
enddef

export def ResetContext()  # {{{2
  call filter(s:GetHintedScope(), '0') # Empty the given scope.
  call extend(s:GetHintedScope(), deepcopy(vspec#scope()['saved_scope']), 'force')
enddef

export def SaveContext()  # {{{2
  final scope = vspec#scope()
  scope['saved_scope'] = deepcopy(s:GetHintedScope())
enddef

# Misc. utilities  # {{{1
export def BreakLineForcibly(): void  # {{{2
  # - :echo {message} outputs "\n{message}" rather than "{message}\n".
  # - :echo preceded by :redraw does not output "\n", because the screen is
  #   expected to be redrawn.  "\n" is not necessary in this situation.
  #
  # This behavior is reasonable as long as Vim is used interactively.  But
  # it is problematic for a batch process.  It seems that there is no way to
  # forcibly break a line in pure Vim script without side effect.  For example
  # :echo 'foo' | redraw | echo '' | echo 'bar' outputs "\nfoobar".
  #
  # So that output from Vim script will be filtered by bin/vspec:
  #
  # - Lines including only "\r" are removed.
  # - Trailing "\r"s in each line are removed.  This filter is also useful to
  #   ensure final output is Unix-stlye line ending.
  echo "\r"
enddef

export def GetHintedScope(): dict<any>  # {{{2
  return eval(vspec#scope()['expr_hinted_scope'])
enddef

export def GetHintedSid(): string  # {{{2
  return eval(vspec#scope()['expr_hinted_sid'])
enddef

export def GetInternalCallStackForExpect(): string  # {{{2
  # expand('<sfile>') ==> "script a.vim[123]..function B[456]..function C"
  # expand('<stack>') ==> "script a.vim[123]..function B[456]..function C[789]"
  # v:throwpoint      ==> "script a.vim[123]..function B[456]..function C[333]..{...}, line 1"
  #                                                                             |___________|
  #                                                                                  (A)
  # This function returns (A) to remove this noise part later.
  # <stack> is not useful here, because it includes the line number (789),
  # and that line number doesn't match v:throwpoint (333).
  if s:internal_call_stack_for_expect != ''
    return s:internal_call_stack_for_expect
  endif

  try
    Expect 0 == 1
  catch
    const base_call_stack = expand('<sfile>')
    s:internal_call_stack_for_expect = substitute(
    \   v:throwpoint,
    \   '\V' .. escape(base_call_stack, '\') .. '[\d\+]..',
    \   '',
    \   ''
    \ )
  endtry
  return s:internal_call_stack_for_expect
enddef

var s:internal_call_stack_for_expect: string

export def ParseString(string_expression: string): any  # {{{2
  const s = substitute(string_expression, '^\s*\(.\{-}\)\s*$', '\1', '')
  if !(s =~ '^''\(''''\|[^'']\)*''$' || s =~ '^"\(\\.\|[^"]\)*"$')
    ThrowInternalException('SyntaxError', {message: 'Invalid string - ' .. string(s)})
  endif
  return eval(s)
enddef

export def SimplifyCallStack(throwpoint: string, base_call_stack: string, type: string): string  # {{{2
  if type == 'expect'
    # Where the last :Expect is called ___________
    #                                             |
    #   {base_call_stack}[#]..{dict-func-for-:it}[#]..{:Expect-stack}[#]
    return substitute(
      throwpoint,
      '\V\.\*[\(\d\+\)]..' .. escape(s:GetInternalCallStackForExpect(), '\') .. '\$',
      '\1',
      ''
    )
  elseif type == 'it'
    # If an error occurs in :it rather than functions called from :it,
    # this part is not included in throwpoint. __________
    #                                                    |
    #                                           _________|_________
    #                                          |                   |
    # {base_call_stack}[#]..{dict-func-for-:it}[#]..{user-func}[#]..
    # |__________________|  |____________________|
    #          |                      |
    #          |                      |_________________________
    #          |                                                |
    #  ________|____________________________________    ________|_______
    # |                                             |  |                |
    # '\V' .. escape(base_call_stack, '\') .. '[\d\+]..\d\+\%([\d\+]\)\?'
    return substitute(
      throwpoint,
      '\V' .. escape(base_call_stack, '\') .. '[\d\+]..\d\+\%([\d\+]\)\?',
      '{example}',
      ''
    )
  else
    # TODO: Show the location in an original file instead of the transpiled one.
    return substitute(
      throwpoint,
      '\V' .. escape(base_call_stack, '\') .. '\%([\d\+]..script \S\+\ze..\)\?',
      '{vspec}',
      ''
    )
  endif
enddef

export def ThrowInternalException(type: string, values: any): void  # {{{2
  throw printf('vspec:%s:%s', type, string(values))
enddef

# __END__  # {{{1
# vim: foldmethod=marker
