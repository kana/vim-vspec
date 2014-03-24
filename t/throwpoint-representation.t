#!/bin/bash

./t/check-vspec-result <(cat <<'END'
function Foo()
  call Bar()
endfunction

function Bar()
  call Baz()
endfunction

function Baz()
  let qux = 'qux'
  throw 'Unexpected error'
endfunction

describe 'vspec'
  it 'omits uninteresting parts from a stack trace'
    let foo = 'foo'
    let bar = 'bar'
    let baz = baz
  end

  it 'keeps interesting parts of a stack trace'
    call Foo()
  end
end
END
) <(cat <<'END'
not ok 1 - vspec omits uninteresting parts from a stack trace
# {example}, line 3
# Vim(let):E121: Undefined variable: baz
not ok 2 - vspec keeps interesting parts of a stack trace
# {example}..Foo..Bar..Baz, line 2
# Unexpected error
1..2
END
)

# vim: filetype=sh
