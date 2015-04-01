#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':TODO'
  it 'stops the current example as a failure'
    TODO
  end
end
END
) <(cat <<'END'
not ok 1 - :TODO stops the current example as a failure # TODO
1..1
END
)

# vim: filetype=sh
