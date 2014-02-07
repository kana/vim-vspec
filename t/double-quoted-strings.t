#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe "\<Char-0x3a>describe command"
  it 'accepts a double-quoted string'
  end
end
describe ':it command'
  it "accepts a double\<Char-0x2d>quoted string"
  end
end
END
) <(cat <<'END'
ok 1 - :describe command accepts a double-quoted string
ok 2 - :it command accepts a double-quoted string
1..2
END
)

# vim: filetype=sh
