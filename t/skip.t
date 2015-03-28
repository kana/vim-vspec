#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':SKIP'
  it 'stops the current example as a success'
    echo '# Lines before :SKIP will be executed.'
    SKIP 'This is a test'
    echo '# Lines after :SKIP will never be reached.'
  end
end
END
) <(cat <<'END'
# Lines before :SKIP will be executed.
ok 1 - :SKIP stops the current example as a success # SKIP - This is a test
1..1
END
)

# vim: filetype=sh
