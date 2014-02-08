#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'Suite 1'
  it 'is not executed'
  end
end

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

describe 'Suite 2'
  it 'is not executed'
  end
end
END
) <(cat <<'END'
# -----------------------------------------------------------------------------
# function A..B..C, line 1
# Vim:E492: Not an editor command:   ThisLineIsNotAValidVimScriptStatement
Bail out!  Unexpected error happened while processing a test script.
END
)

# vim: filetype=sh
