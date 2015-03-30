#!/bin/bash

./t/check-vspec-result -d 'foo bar' <(cat <<'END'
describe './bin/vspec'
  it 'can handle pahts which contain spaces'
    let paths = split(&runtimepath, ',')
    Expect paths[0] ==# getcwd() . '/foo bar'
    Expect paths[1] ==# getcwd()
    Expect paths[-2] ==# getcwd() . '/after'
    Expect paths[-1] ==# getcwd() . '/foo bar/after'
  end
end
END
) <(cat <<'END'
ok 1 - ./bin/vspec can handle pahts which contain spaces
1..1
END
)

# vim: filetype=sh
