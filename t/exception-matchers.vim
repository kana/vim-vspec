function! Fail(s)
  throw a:s
endfunction

describe 'to_throw'
  it 'matches to an expression which throws a specific exception'
    Expect expr { 0 } not to_throw '^fo\+$'
    Expect expr { x + y + z } not to_throw '^fo\+$'
    Expect expr { Fail('foo') } to_throw '^fo\+$'
    Expect expr { Fail('bar') } not to_throw '^fo\+$'
  end

  it 'matches to an expression which throws an exception'
    Expect expr { 0 } not to_throw
    Expect expr { x + y + z } to_throw
    Expect expr { Fail('foo') } to_throw
    Expect expr { Fail('bar') } to_throw
  end
end
