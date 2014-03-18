#!/bin/bash

./t/check-vspec-result <(cat <<'END'
describe 'vspec'
  it 'shows strings with CR/LF in a decodable style'
    Expect "foo\nbar\rbaz" ==# 'foo\nbar\rbaz'
  end

  it 'shows strings with other control characters in a decodable style'
    Expect "\b\e\f\t" ==# '\b\e\f\t'
  end

  it 'shows strings with single quotes in a decodable style'
    Expect "foo'bar" ==# 'baz''qux'
  end

  it 'shows strings with double quotes in a decodable style'
    Expect "foo\"bar" ==# 'foo\"bar'
  end

  it 'shows strings with backslashes in a decodable style'
    Expect "foo\\bar" ==# 'foo\\bar'
  end

  it 'shows strings with other special characters in a decodable style'
    Expect "foo\x1d\X7fbar" ==# 'foo\x1d\X7fbar'
  end
end
END
) <(cat <<'END'
not ok 1 - vspec shows strings with CR/LF in a decodable style
# Expected "foo\nbar\rbaz" ==# 'foo\nbar\rbaz'
#       Actual value: "foo\nbar\rbaz"
#     Expected value: "foo\\nbar\\rbaz"
not ok 2 - vspec shows strings with other control characters in a decodable style
# Expected "\b\e\f\t" ==# '\b\e\f\t'
#       Actual value: "\b\e\f\t"
#     Expected value: "\\b\\e\\f\\t"
not ok 3 - vspec shows strings with single quotes in a decodable style
# Expected "foo'bar" ==# 'baz''qux'
#       Actual value: "foo'bar"
#     Expected value: "baz'qux"
not ok 4 - vspec shows strings with double quotes in a decodable style
# Expected "foo\"bar" ==# 'foo\"bar'
#       Actual value: "foo\"bar"
#     Expected value: "foo\\\"bar"
not ok 5 - vspec shows strings with backslashes in a decodable style
# Expected "foo\\bar" ==# 'foo\\bar'
#       Actual value: "foo\\bar"
#     Expected value: "foo\\\\bar"
not ok 6 - vspec shows strings with other special characters in a decodable style
# Expected "foo\x1d\X7fbar" ==# 'foo\x1d\X7fbar'
#       Actual value: "foo\x1D\x7Fbar"
#     Expected value: "foo\\x1d\\X7fbar"
1..6
END
)

# vim: filetype=sh
