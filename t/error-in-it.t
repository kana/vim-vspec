#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'Suite 1'
  it 'is executed'
  end
end

describe 'Suite 2'
  it 'is executed and failed'
    function A()
      call B()
    endfunction
    function B()
      call C()
    endfunction
    function C()
      ThisLineIsNotAValidVimScriptStatement
    endfunction
    call A()
  end
end

describe 'Suite 3'
  it 'is executed'
  end
end
END
) <(cat <<'END'
ok 1 - Suite 1 is executed
not ok 2 - Suite 2 is executed and failed
# {example}..A[1]..B[1]..C, line 1
# Vim:E492: Not an editor command:       ThisLineIsNotAValidVimScriptStatement
ok 3 - Suite 3 is executed
1..3
END
)

# vim: filetype=sh
