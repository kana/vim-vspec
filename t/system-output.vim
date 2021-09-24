describe 'systemlist()'
  it 'runs a given command, then returns both stdout and stderr'
    Expect systemlist('./t/lib/echos') ==# [
    \   'stdout',
    \   'stderr',
    \ ]
  end
end
