#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe ':redraw'
  it 'does not affect TAP format (1)'
    redraw
  end

  it 'does not affect TAP format (2)'
    echo 'foo'
    redraw
    echo 'bar <-- unexpectedly merged, but not controlled by vspec'
  end

  it 'does not affect TAP format (3)'
    edit ,foo
    redraw
  end
end
END
) <(cat <<'END'
ok 1 - :redraw does not affect TAP format (1)
foobar <-- unexpectedly merged, but not controlled by vspec
ok 2 - :redraw does not affect TAP format (2)
",foo" [New File]
ok 3 - :redraw does not affect TAP format (3)
1..3
END
)

# vim: filetype=sh
