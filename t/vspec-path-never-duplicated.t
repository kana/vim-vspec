#!/bin/bash

./t/check-vspec-result -d "$PWD" -d "$PWD" -d "$PWD" <(cat <<'END'
describe './bin/vspec'
  it 'excludes explicitly specified vspec path'
    let current_runtimepath = &runtimepath
    set runtimepath&
    let default_runtimepath = &runtimepath
    let &runtimepath = current_runtimepath

    let paths = split(current_runtimepath, ',')
    Expect paths[0] ==# getcwd()
    Expect paths[1:-2] ==# split(default_runtimepath, ',')[1:-2]
    Expect paths[-1] ==# getcwd() . '/after'
  end
end
END
) <(cat <<'END'
ok 1 - ./bin/vspec excludes explicitly specified vspec path
1..1
END
)

# vim: filetype=sh
