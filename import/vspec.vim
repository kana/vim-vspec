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

export def Expect(actual: any): dict<any>  # {{{2
  return MakeExpectation(actual)
enddef

export def Hint(info: dict<string>): void  # {{{2
  final scope = vspec#scope()

  if has_key(info, 'scope')
    scope['expr_hinted_scope'] = info.scope
    SaveContext()
  endif

  if has_key(info, 'sid')
    scope['expr_hinted_sid'] = info.sid
  endif
enddef

export def PrettyString(value: any): string  # {{{2
  return substitute(
    string(value),
    '''\(\%([^'']\|''''\)*\)''',
    '\=ReescapeStringContent(submatch(1))',
    'g'
  )
enddef

def ReescapeStringContent(s: string): string
  if !s:REESCAPE_TABLE
    for i in range(0x01, 0xFF)
      const c = nr2char(i)
      s:REESCAPE_TABLE[c] = c =~ '\p' ? c : printf('\x%02X', i)
    endfor
    call extend(s:REESCAPE_TABLE, {
      "\"": '\"',
      "\\": '\\',
      "\b": '\b',
      "\e": '\e',
      "\f": '\f',
      "\n": '\n',
      "\r": '\r',
      "\t": '\t',
    })
  endif

  const cs = s
    ->substitute("''", "'", 'g')
    ->split('\ze.')
    ->map('get(s:REESCAPE_TABLE, v:val, v:val)')
  return '"' .. join(cs, '') .. '"'
enddef

final s:REESCAPE_TABLE: dict<string> = {}

export def Ref(variable_name: string): any  # {{{2
  if variable_name !~ '^s:'
    ThrowInternalException(
      'InvalidOperation',
      {'message': 'Invalid variable_name - ' .. string(variable_name)}
    )
  endif
  return GetHintedScope()[variable_name[2 :]]
enddef

export def ResetContext()  # {{{2
  call filter(s:GetHintedScope(), '0') # Empty the given scope.
  call extend(s:GetHintedScope(), deepcopy(vspec#scope()['saved_scope']), 'force')
enddef

export def SaveContext()  # {{{2
  final scope = vspec#scope()
  scope['saved_scope'] = deepcopy(s:GetHintedScope())
enddef

export def Set(variable_name: string, value: any): void  # {{{2
  if variable_name !~ '^s:'
    ThrowInternalException(
      'InvalidOperation',
      {'message': 'Invalid variable_name - ' .. string(variable_name)}
    )
  endif
  final scope = GetHintedScope()
  scope[variable_name[2 : ]] = value
enddef

export def Skip(reason: string): void  # {{{2
  ThrowInternalException('ExpectationFailure', {'type': 'SKIP', 'message': reason})
enddef

export def Todo(): void  # {{{2
  ThrowInternalException('ExpectationFailure', {'type': 'TODO'})
enddef

# Expectation  # {{{1
function s:Expect_To(matcher) dict  # {{{2
  call s:To(self, a:matcher)
endfunction

def To(self: dict<any>, matcher: dict<any>): void
  const matched = matcher.Matches(self.actual)
  if self.negated ? matched : !matched
    ThrowInternalException(
      'ExpectationFailureV2',
      {
        message: matcher.FailureMessage(self.actual),
      }
    )
  endif
enddef

function s:Expect_NotTo(matcher) dict  # {{{2
  call s:NotTo(self, a:matcher)
endfunction

def NotTo(self: dict<any>, matcher: dict<any>): void
  self.negated = true
  To(self, matcher)
enddef

const ExpectationPrototype = {  # {{{2
  actual: v:none,  # any
  negated: false,  # bool
  NotTo: Expect_NotTo,
  To: Expect_To,
}

def MakeExpectation(actual: any): dict<any>  # {{{2
  final expectation = copy(ExpectationPrototype)
  expectation.actual = actual
  return expectation
enddef

# Matchers v2  # {{{1
export def Be(a1: any, a2: any = v:none): dict<any>  # {{{2
  # "a2 is v:none" causes E1072: Cannot compare any with special.
  const none: any = v:none
  if a2 is none
    return BeInternal('is', a1)
  else
    return BeInternal(a1, a2)
  end
enddef

def BeInternal(operator: string, expected: any): dict<any>
  return {
    expected: expected,
    Matches: (actual) => BeMatcherTable[operator](actual, expected),
    FailureMessage: (actual) => FailureMessageForSimpleComparison(actual, expected),
  }
enddef

# Alternative syntax ideas:
#
#   Expect(actual).To(BeLessThan(expected))  # Natural to read, but lengthy.
#   Expect(actual).To(LT(expected))  # Concise, but cryptic.
#
# Intentionally omitted operators:
#
#   ==#, !=#, ...
#      Use non-# version instead.
const BeMatcherTable = {
  '==': (actual, expected) => actual == expected,
  '!=': (actual, expected) => actual != expected,
  '<':  (actual, expected) => actual <  expected,
  '<=': (actual, expected) => actual <= expected,
  '>':  (actual, expected) => actual >  expected,
  '>=': (actual, expected) => actual >= expected,
  '=~': (actual, expected) => actual =~ expected,
  '!~': (actual, expected) => actual !~ expected,
  'is': (actual, expected) => actual is expected,
  'isnot': (actual, expected) => actual isnot expected,

  '==?': (actual, expected) => actual ==? expected,
  '!=?': (actual, expected) => actual !=? expected,
  '<?':  (actual, expected) => actual <?  expected,
  '<=?': (actual, expected) => actual <=? expected,
  '>?':  (actual, expected) => actual >?  expected,
  '>=?': (actual, expected) => actual >=? expected,
  '=~?': (actual, expected) => actual =~? expected,
  '!~?': (actual, expected) => actual !~? expected,
}

export def Equal(expected: any): dict<any>  # {{{2
  return {
    expected: expected,
    Matches: (actual) => actual == expected,
    FailureMessage: (actual) => FailureMessageForSimpleComparison(actual, expected),
  }
enddef

# Matcher utilities  # {{{1
def FailureMessageForSimpleComparison(actual: any, expected: any): list<string>  # {{{2
  return [
    'Expected value: ' .. PrettyString(expected),
    '  Actual value: ' .. PrettyString(actual),
  ]
enddef

# Matchers  # {{{1
const VALID_MATCHERS_EQUALITY = [  # {{{2
  '!=',
  '==',
  'is',
  'isnot',

  '!=?',
  '==?',
  'is?',
  'isnot?',

  '!=#',
  '==#',
  'is#',
  'isnot#',
]

const VALID_MATCHERS_ORDERING = [  # {{{2
  '<',
  '<=',
  '>',
  '>=',

  '<?',
  '<=?',
  '>?',
  '>=?',

  '<#',
  '<=#',
  '>#',
  '>=#',
]

const VALID_MATCHERS_REGEXP = [  # {{{2
  '!~',
  '=~',

  '!~?',
  '=~?',

  '!~#',
  '=~#',
]

const VALID_MATCHERS = # {{{2
  VALID_MATCHERS_EQUALITY
  + VALID_MATCHERS_ORDERING
  + VALID_MATCHERS_REGEXP

export def GenerateDefaultFailureMessage(expectation: dict<any>): list<string>  # {{{2
  return [
    '  Actual value: ' .. s:PrettyString(expectation.value_actual),
    'Expected value: ' .. s:PrettyString(expectation.value_expected),
  ]
enddef

export def GenerateFailureMessage(expectation: dict<any>): list<string>  # {{{2
  const custom_matchers = vspec#scope()['custom_matchers']
  const matcher = get(custom_matchers, expectation.value_matcher, 0)
  if matcher is 0
    return GenerateDefaultFailureMessage(expectation)
  else
    const method_name = expectation.value_not == ''
      ? 'failure_message_for_should'
      : 'failure_message_for_should_not'
    const Generate = get(matcher, method_name, 0)
    if Generate is 0
      return GenerateDefaultFailureMessage(expectation)
    else
      # For some reason, list<any> in assignment is overridden by more
      # specific type.  For example:
      #
      #     final values: list<any> = [expectation.value_actual]
      #     echo typename(expectation.value_actual)
      #     #==> dict<number>
      #     echo typename(values)
      #     #==> list<dict<number>> instead of list<any>
      final values: list<any> = []
      call add(values, expectation.value_actual)
      if expectation.expr_expected != ''
        call extend(values, expectation.value_expected)
      endif
      const maybe_message = call(Generate, values, matcher)
      return type(maybe_message) == v:t_string
        ? [maybe_message]
        : maybe_message
    endif
  endif
enddef

export def IsCustomMatcher(expr_matcher: string): bool  # {{{2
  return expr_matcher =~ '^to'
enddef

export def IsEqualityMatcher(expr_matcher: string): bool  # {{{2
  return 0 <= index(VALID_MATCHERS_EQUALITY, expr_matcher)
enddef

export def IsMatcher(expr_matcher: string): bool  # {{{2
  return 0 <= index(VALID_MATCHERS, expr_matcher) || IsCustomMatcher(expr_matcher)
enddef

export def IsNegativeMatcher(expr_matcher: string): bool  # {{{2
  # FIXME: Ad hoc way.
  return IsMatcher(expr_matcher) && expr_matcher =~# '\(!\|not\)'
enddef

export def IsOrderableType(value: any): bool  # {{{2
  # FIXME: +float
  return type(value) == type(0) || type(value) == type('')
enddef

export def IsOrderingMatcher(expr_matcher: string): bool  # {{{2
  return 0 <= index(VALID_MATCHERS_ORDERING, expr_matcher)
enddef

export def IsRegexpMatcher(expr_matcher: string): bool  # {{{2
  return 0 <= index(VALID_MATCHERS_REGEXP, expr_matcher)
enddef

export def SplitAtMatcher(s: string): list<string>  # {{{2
  const tokens = matchlist(s, RE_SPLIT_AT_MATCHER)
  return tokens[1 : 4]
enddef

const s:RE_SPLIT_AT_MATCHER = printf(
  '\C\v^(.{-})\s+%%((not)\s+)?(%%(%%(%s)[#?]?)|to\w+>)\s*(.*)$',
  join(
    map(
      reverse(sort(copy(VALID_MATCHERS))),
      'escape(v:val, "=!<>~#?")'
    ),
    '|'
  )
)

# Test runner  # {{{1
export def RunSuites(all_suites: list<dict<any>>): void  # {{{2
  var total_count_of_examples = 0
  for suite in all_suites
    for example_index in range(len(suite.example_list))
      total_count_of_examples += 1
      const example = suite.example_list[example_index]
      suite.run_before_blocks()

      try
        # For some reason, suite.example_dict[index]() fails by
        # E725: Calling dict function without Dictionary: 17
        const d1 = suite.example_dict
        const d2 = {f: d1[suite.generate_example_function_name(example_index)]}
        d2.f()
        BreakLineForcibly()  # anti-:redraw
        echo printf(
          '%s %d - %s %s',
          'ok',
          total_count_of_examples,
          suite.pretty_subject,
          example
        )
      catch /^vspec:/
        BreakLineForcibly()  # anti-:redraw
        const xs = matchlist(v:exception, '^vspec:\(\w\+\):\(.*\)$')
        const type = xs[1]
        const i = eval(xs[2])
        # v:throwpoint will be overwritten by GetInternalCallStackForExpectV2.
        const throwpoint = v:throwpoint
        if type == 'ExpectationFailureV2'
          echo printf(
            '%s %d - %s %s',
            'not ok',
            total_count_of_examples,
            suite.pretty_subject,
            example
          )
          echo printf(
            '# %s at line %s',
            GetExpectV2Line(throwpoint),
            SimplifyCallStack(throwpoint, '', 'expectv2')
          )
          for line in i.message
            echo '#     ' .. line
          endfor
        elseif type == 'ExpectationFailure'
          const subtype = i.type
          if subtype == 'MismatchedValues'
            echo printf(
              '%s %d - %s %s',
              'not ok',
              total_count_of_examples,
              suite.pretty_subject,
              example
            )
            echo '# Expected' join(filter([
              i.expr_actual,
              i.expr_not,
              i.expr_matcher,
              i.expr_expected,
            ], 'v:val != ""')) 'at line' SimplifyCallStack(v:throwpoint, '', 'expect')
            for line in GenerateFailureMessage(i)
              echo '#     ' .. line
            endfor
          elseif subtype == 'TODO'
            echo printf(
              '%s %d - # TODO %s %s',
              'not ok',
              total_count_of_examples,
              suite.pretty_subject,
              example
            )
          elseif subtype == 'SKIP'
            echo printf(
              '%s %d - # SKIP %s %s - %s',
              'ok',
              total_count_of_examples,
              suite.pretty_subject,
              example,
              i.message
            )
          else
            echo printf(
              '%s %d - %s %s',
              'not ok',
              total_count_of_examples,
              suite.pretty_subject,
              example
            )
            echo printf('# %s: %s', type, i.message)
          endif
        else
          echo printf(
            '%s %d - %s %s',
            'not ok',
            total_count_of_examples,
            suite.pretty_subject,
            example
          )
          echo printf('# %s: %s', type, i.message)
        endif
      catch
        BreakLineForcibly()  # anti-:redraw
        echo printf(
          '%s %d - %s %s',
          'not ok',
          total_count_of_examples,
          suite.pretty_subject,
          example
        )
        echo '#' SimplifyCallStack(v:throwpoint, expand('<stack>'), 'it')
        for exception_line in split(v:exception, '\n')
          echo '#' exception_line
        endfor
      endtry
      suite.run_after_blocks()
    endfor
  endfor
  echo printf('1..%d', total_count_of_examples)
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

def GetExpectV2Line(throwpoint: string): string  # {{{2
  # Where the last ExpectV2() is called _________
  #                                             |
  #   {base_call_stack}[#]..{dict-func-for-:it}[#]..{ExpectV2()-stack}[#]
  const xs = matchlist(
    throwpoint,
    '\V\.\*..\(\[^.]\+\)[\(\d\+\)]..' .. escape(s:GetInternalCallStackForExpectV2(), '\') .. '\$'
  )

  # Local variables can't be used for :redir.
  #     silent redir => v
  #     E1089: Unknown variable: v
  #
  # ":0 verbose" doesn't set &verbose to 0 while ":verbose source file.vim".
  const old_verbose = &verbose
  set verbose=0
  try
    silent redir => g:_vspec_output
    execute 'function' 'g:' .. xs[1]
    redir END
  finally
    &verbose = old_verbose
  endtry
  const output = g:_vspec_output
  unlet g:_vspec_output

  return output
    ->split('\n')
    ->filter((_, line) => line =~ ('^' .. xs[2] .. '\>'))[0]
    ->substitute('^\d\+', '', '')
    ->trim()
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
  # Note that:
  # - <stack> includes a line number (789), and that line number doesn't match
  #   v:throwpoint (333).
  # - <sfile> can't be used in Vim9 script functions.
  if s:internal_call_stack_for_expect != ''
    return s:internal_call_stack_for_expect
  endif

  try
    Expect 0 == 1
  catch
    const base_call_stack = substitute(expand('<stack>'), '\[\d\+\]$', '', '')
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

export def GetInternalCallStackForExpectV2(): string  # {{{2
  if s:internal_call_stack_for_expect_v2 != ''
    return s:internal_call_stack_for_expect_v2
  endif

  try
    ExpectV2(0).To(Equal(1))
  catch
    const base_call_stack = substitute(expand('<stack>'), '\[\d\+\]$', '', '')
    s:internal_call_stack_for_expect_v2 = substitute(
    \   v:throwpoint,
    \   '\V' .. escape(base_call_stack, '\') .. '[\d\+]..',
    \   '',
    \   ''
    \ )
  endtry
  return s:internal_call_stack_for_expect_v2
enddef

var s:internal_call_stack_for_expect_v2: string

export def ParseString(string_expression: string): any  # {{{2
  const s = substitute(string_expression, '^\s*\(.\{-}\)\s*$', '\1', '')
  if !(s =~ '^''\(''''\|[^'']\)*''$' || s =~ '^"\(\\.\|[^"]\)*"$')
    ThrowInternalException('SyntaxError', {message: 'Invalid string - ' .. string(s)})
  endif
  return eval(s)
enddef

export def SimplifyCallStack(throwpoint: string, stack: string, type: string): string  # {{{2
  # expand('<sfile>') ==> "script a.vim[123]..function B[456]..function C"
  # expand('<stack>') ==> "script a.vim[123]..function B[456]..function C[789]"
  # v:throwpoint      ==> "script a.vim[123]..function B[456]..function C[333]..{...}, line 1"
  const base_call_stack = substitute(stack, '\[\d\+\]$', '', '')

  if type == 'expectv2'
    # Where the last ExpectV2() is called _________
    #                                             |
    #   {base_call_stack}[#]..{dict-func-for-:it}[#]..{ExpectV2()-stack}[#]
    return substitute(
      throwpoint,
      '\V\.\*[\(\d\+\)]..' .. escape(s:GetInternalCallStackForExpectV2(), '\') .. '\$',
      '\1',
      ''
    )
  elseif type == 'expect'
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
