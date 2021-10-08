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

export def ParseString(string_expression: string): any  # {{{2
  const s = substitute(string_expression, '^\s*\(.\{-}\)\s*$', '\1', '')
  if !(s =~ '^''\(''''\|[^'']\)*''$' || s =~ '^"\(\\.\|[^"]\)*"$')
    ThrowInternalException('SyntaxError', {message: 'Invalid string - ' .. string(s)})
  endif
  return eval(s)
enddef

export def ThrowInternalException(type: string, values: any): void  # {{{2
  throw printf('vspec:%s:%s', type, string(values))
enddef

# __END__  # {{{1
# vim: foldmethod=marker
