#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':redraw'
  it 'does not affect TAP format (1)'
    redraw
  end

  it 'does not affect TAP format (2)'
    redraw
  end
end
END
) <(cat <<'END'
ok 1 - :redraw does not affect TAP format (1)
ok 2 - :redraw does not affect TAP format (2)
1..2
END
)

# vim: filetype=sh
