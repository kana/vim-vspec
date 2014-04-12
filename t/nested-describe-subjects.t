#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'outer :describe'
  describe 'with inner :describe'
    it 'is supported'
    end
  end
  context 'with inner :context'
    it 'is supported'
    end
  end
end
END
) <(cat <<'END'
ok 1 - outer :describe with inner :describe is supported
ok 2 - outer :describe with inner :context is supported
1..2
END
)

# vim: filetype=sh
