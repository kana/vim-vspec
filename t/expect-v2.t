#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'ExpectV2()'
  it 'succeeds if an actual value matches to an expected value'
    call ExpectV2('have to').To(Equal('have to'))
  end

  it 'fails if an actual value does not match to an expected value'
    call ExpectV2('should').To(Equal('Expect'))
  end
end
END
) <(cat <<'END'
ok 1 - ExpectV2() succeeds if an actual value matches to an expected value
not ok 2 - ExpectV2() fails if an actual value does not match to an expected value
# call ExpectV2('should').To(Equal('Expect')) at line 1
#     Expected value: Expect
#       Actual value: should
1..2
END
)

# vim: filetype=sh
