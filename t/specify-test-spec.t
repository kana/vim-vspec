#!/bin/bash

./t/check-vspec-result --grep "specified to be run test" <(cat <<'END'
describe 'run single test'
  let g:count = 1

  it 'count should be 1'
    Expect g:count == 1
    let g:count += 1
  end
  it 'count should be 2'
    Expect g:count == 2
  end
  it 'specified to be run test'
    Expect g:count == 1
  end
end
) <(cat <<'END'
ok 1 - run single test specified to be run test
1..1
END
)

# vim: filetype=sh
