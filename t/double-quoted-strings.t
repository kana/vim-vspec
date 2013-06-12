#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe "The \<Char-0x3a>describe command"
  it 'accepts a double-quoted string'
  end
end
END
) <(cat <<'END'
ok 1 - The :describe command accepts a double-quoted string
1..1
END
)

# vim: filetype=sh
