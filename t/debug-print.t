#!/bin/bash

./t/check-vspec-result <(cat <<'END'
function! InnerFunction(foo)
  Debug a:foo
endfunction

describe 'Debug'
  it 'outputs debug log just before ok/not ok line'
    edit ,foo
    Debug "vi\<Space>m"
    edit ,bar
    redraw
    Debug 3 '.1' [4, '159'] {'26': '53'}
    let x = 'function-local'
    Debug x
    let b:x = 'buffer-local'
    Debug b:x
    call InnerFunction('function-argument')

    edit ,baz
    call vspec#debug("\<lt>\<Bar>37")
    edit ,qux
    redraw
    call vspec#debug(3, '.1', [4, '159'], {'26': '53'})
  end
end
END
) <(cat <<'END'
",foo" [New File]
# vi m
",bar" [New File]
# 3 .1 [4, '159'] {'26': '53'}
# function-local
# buffer-local
# function-argument
",baz" [New File]
# <|37
",qux" [New File]
# 3 .1 [4, '159'] {'26': '53'}
ok 1 - Debug outputs debug log just before ok/not ok line
1..1
END
)

# vim: filetype=sh
