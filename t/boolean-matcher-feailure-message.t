#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'to_be_true'
  it 'outputs a reasonable failure message'
    let x = 0
    Expect x to_be_true
  end

  it 'outputs a reasonable failure message even if inverted'
    let x = 1
    Expect x not to_be_true
  end
end

describe 'to_be_false'
  it 'outputs a reasonable failure message'
    let x = 1
    Expect x to_be_false
  end

  it 'outputs a reasonable failure message even if inverted'
    let x = 0
    Expect x not to_be_false
  end
end
END
) <(cat <<'END'
not ok 1 - to_be_true outputs a reasonable failure message
# Expected x to_be_true
#     Actual value: 0
not ok 2 - to_be_true outputs a reasonable failure message even if inverted
# Expected x not to_be_true
#     Actual value: 1
not ok 3 - to_be_false outputs a reasonable failure message
# Expected x to_be_false
#     Actual value: 1
not ok 4 - to_be_false outputs a reasonable failure message even if inverted
# Expected x not to_be_false
#     Actual value: 0
1..4
END
)

# vim: filetype=sh
