#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':SKIP'
  it 'stops the current example as a success'
    SKIP 'This is a test'
    echo 'This line will never be reached.'
  end
end
END
) <(cat <<'END'
ok 1 - # SKIP :SKIP stops the current example as a success - 'This is a test'
1..1
END
)

# vim: filetype=sh
