#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'Debug'
  it 'outputs debug log just before ok/not ok line'
    edit ,foo
    Debug "vi\<Space>m"
    edit ,bar
    redraw
    Debug 3 '.1' [4, '159'] {'26': '53'}

    edit ,baz
    call vspec#echo_debug("\<lt>\<Bar>37")
    edit ,qux
    redraw
    call vspec#echo_debug(3, '.1', [4, '159'], {'26': '53'})
  end
end
END
) <(cat <<'END'
",foo" [New File]
# vi m
",bar" [New File]
# 3 .1 [4, '159'] {'26': '53'}
",baz" [New File]
# <|37
",qux" [New File]
# 3 .1 [4, '159'] {'26': '53'}
ok 1 - Debug outputs debug log just before ok/not ok line
1..1
END
)

# vim: filetype=sh
