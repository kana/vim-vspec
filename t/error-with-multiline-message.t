#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'vspec'
  it 'correctly shows a multiline error message'
    throw join([
    \   'Foo is called in an invalid context:',
    \   'In Foo, line 1',
    \   'In Bar, line 2',
    \   'In Baz, line 3',
    \ ], "\n")
  end
end
END
) <(cat <<'END'
not ok 1 - vspec correctly shows a multiline error message
# {example}, line 1
# Foo is called in an invalid context:
# In Foo, line 1
# In Bar, line 2
# In Baz, line 3
1..1
END
)

# vim: filetype=sh
