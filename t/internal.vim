call vspec#hint({'sid': 'vspec#sid()'})

describe 's:parse_string'
  it 'returns a literal string if a single-quoted string is given'
    Expect Call('s:parse_string', "'foo'") ==# 'foo'
    Expect Call('s:parse_string', "'That''s right'") ==# "That's right"
  end

  it 'returns a unescaped string if a double-quoted string is given'
    Expect Call('s:parse_string', '"bar"') ==# 'bar'
    Expect Call('s:parse_string', '"\<Char-0x3a>qall!"') ==# ':qall!'
  end

  it 'trims spaces around a given string'
    Expect Call('s:parse_string', "  'foo' ") ==# 'foo'
    Expect Call('s:parse_string', ' "bar"  ') ==# 'bar'
  end

  it 'throws SyntaxError for invalid strings'
    Expect expr { Call('s:parse_string', 'baz') } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:parse_string', '"..." has ...') } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:parse_string', "'foo'bar'baz'") } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:parse_string', 'bufnr("$")') } to_throw '^vspec:SyntaxError:'
  end
end
