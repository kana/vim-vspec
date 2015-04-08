describe 'Syntax highlighting'
  it 'does not work for command names in expectations'
    Expect before != after
    Expect context != describe
  end
  it 'does not work for operators not in expectations'
    not in a valid situation
  end
end
