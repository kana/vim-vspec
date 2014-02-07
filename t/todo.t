#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':TODO'
  it 'stops the current example as a failure'
    TODO
  end
end
END
) <(cat <<'END'
not ok 1 - # TODO :TODO stops the current example as a failure
1..1
END
)

# vim: filetype=sh
