describe 'Syntax highlighting'
  it 'does not work for command names in expectations'
    Expect before != after
    Expect context != describe
  end
end
