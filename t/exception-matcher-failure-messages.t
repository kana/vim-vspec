#!/bin/bash

./t/check-vspec-result <(cat <<'END'
function! Fail(s)
  throw a:s
endfunction

describe 'to_throw without a pattern'
  it 'fails if any exception is not thrown'
    Expect expr { 0 } to_throw
  end
end

describe 'not to_throw without a pattern'
  it 'fails if any exception is thrown'
    Expect expr { Fail('foo') } not to_throw
  end
end

describe 'to_throw with a pattern'
  it 'fails if any exception is not thrown'
    Expect expr { 0 } to_throw '^fo\+$'
  end

  it 'fails if a specific exception is not thrown'
    Expect expr { Fail('bar') } to_throw '^fo\+$'
  end
end

describe 'not to_throw with a pattern'
  it 'fails if a specific exception is thrown'
    Expect expr { Fail('foo') } not to_throw '^fo\+$'
  end
end
END
) <(cat <<'END'
not ok 1 - to_throw without a pattern fails if any exception is not thrown
# Expected expr { 0 } to_throw
#     But nothing was thrown
not ok 2 - not to_throw without a pattern fails if any exception is thrown
# Expected expr { Fail('foo') } not to_throw
#     But 'foo' was thrown
not ok 3 - to_throw with a pattern fails if any exception is not thrown
# Expected expr { 0 } to_throw '^fo\+$'
#     But nothing was thrown
not ok 4 - to_throw with a pattern fails if a specific exception is not thrown
# Expected expr { Fail('bar') } to_throw '^fo\+$'
#     But 'bar' was thrown
not ok 5 - not to_throw with a pattern fails if a specific exception is thrown
# Expected expr { Fail('foo') } not to_throw '^fo\+$'
#     But 'foo' was thrown
1..5
END
)

# vim: filetype=sh
