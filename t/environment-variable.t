#!/bin/bash

export VSPEC_VIM=./t/echo

./t/check-vspec-result t/environment-variable.t.input <(cat <<'END'
Echo: -u NONE -i NONE -N -n -e -s --cmd source ./bin/vspec-bootstrap.vim t/environment-variable.t.input
END
)

# vim: filetype=sh
