let s:to_be_encoded_as = {}
function! s:to_be_encoded_as.match(value, representation)
  return vspec#pretty_string(a:value) ==# a:representation
  \   && eval(vspec#pretty_string(a:value)) ==# a:value
  \   && eval(a:representation) ==# a:value
endfunction
function! s:to_be_encoded_as.failure_message_for_should(value, representation)
  return [
  \   '          Value: ' . strtrans(string(a:value)),
  \   '  Actual result: ' . vspec#pretty_string(a:value),
  \   'Expected result: ' . a:representation,
  \ ]
endfunction
call vspec#customize_matcher('to_be_encoded_as', s:to_be_encoded_as)

describe 'vspec#pretty_string'
  it 'converts any value into a decodable string without special characters'
    let cases = [
    \   [123, '123'],
    \   ["", '""'],
    \   ["'", '"''"'],
    \   ["''", '"''''"'],
    \   ["'''", '"''''''"'],
    \   ["'foo'", '"''foo''"'],
    \   ["foo'bar", '"foo''bar"'],
    \   ['foo"bar', '"foo\"bar"'],
    \   ['foo\bar', '"foo\\bar"'],
    \   ["\b\e\f\n\r\t", '"\b\e\f\n\r\t"'],
    \   ["\x1\x11\X1d\177", '"\x01\x11\x1D\x7F"'],
    \   ["foo\nbar\nbaz\nqux\n", '"foo\nbar\nbaz\nqux\n"'],
    \   [[], '[]'],
    \   [[1, 2, 3], '[1, 2, 3]'],
    \   [["\b", '\e', "\f", '\n'], '["\b", "\\e", "\f", "\\n"]'],
    \   [{}, '{}'],
    \   [{1: 'foo'}, '{"1": "foo"}'],
    \   [{'a': 'bar'}, '{"a": "bar"}'],
    \   [{"\b": "\e"}, '{"\b": "\e"}'],
    \   [{'\b': '\e'}, '{"\\b": "\\e"}'],
    \   [function('vspec#pretty_string'), 'function("vspec#pretty_string")'],
    \ ]
    for [Value, representation] in cases
      Expect Value to_be_encoded_as representation
      unlet Value representation
    endfor
  end
end
