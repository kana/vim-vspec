#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':it'
  it '4ccepts a message which starts with a number'
  end
end
END
) <(cat <<'END'
ok 1 - :it 4ccepts a message which starts with a number
1..1
END
)

# vim: filetype=sh
