call vspec#hint({'sid': 'vspec#sid()'})

describe 's:ParseString'
  it 'returns a literal string if a single-quoted string is given'
    Expect Call('s:ParseString', ["'foo'"]) ==# 'foo'
    Expect Call('s:ParseString', ["'That''s right'"]) ==# "That's right"
  end

  it 'returns a unescaped string if a double-quoted string is given'
    Expect Call('s:ParseString', ['"bar"']) ==# 'bar'
    Expect Call('s:ParseString', ['"\<Char-0x3a>qall!"']) ==# ':qall!'
  end

  it 'trims spaces around a given string'
    Expect Call('s:ParseString', ["  'foo' "]) ==# 'foo'
    Expect Call('s:ParseString', [' "bar"  ']) ==# 'bar'
  end

  it 'throws SyntaxError for invalid strings'
    Expect expr { Call('s:ParseString', ['baz']) } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:ParseString', ['"..." has ...']) } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:ParseString', ["'foo'bar'baz'"]) } to_throw '^vspec:SyntaxError:'
    Expect expr { Call('s:ParseString', ['bufnr("$")']) } to_throw '^vspec:SyntaxError:'
  end
end
