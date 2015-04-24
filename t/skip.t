#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':SKIP'
  it 'stops the current example as a success'
    echo '# Lines before :SKIP will be executed.'
    SKIP 'This is a test'
    echo '# Lines after :SKIP will never be reached.'
  end
  it 'accepts a double-quoted string'
    SKIP "This is a test"
  end
  it 'denies an unquoted string'
    SKIP This is a test
  end
  it 'cannot take no message'
    SKIP
  end
end
END
) <(cat <<'END'
# Lines before :SKIP will be executed.
ok 1 - # SKIP :SKIP stops the current example as a success - This is a test
ok 2 - # SKIP :SKIP accepts a double-quoted string - This is a test
not ok 3 - :SKIP denies an unquoted string
# SyntaxError: Invalid string - 'This is a test'
not ok 4 - :SKIP cannot take no message
# {example}, line 1
# Vim:E471: Argument required:     SKIP
1..4
END
)

# vim: filetype=sh
