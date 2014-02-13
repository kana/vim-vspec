describe 'to_be_false'
  it 'matches to a value evaluated as false'
    Expect 0 to_be_false
    Expect 1 not to_be_false
  end

  it 'is still available in old style alias'
    Expect 0 toBeFalse
    Expect 1 not toBeFalse
  end
end

describe 'to_be_true'
  it 'matches to a value evaluated as true'
    Expect 0 not to_be_true
    Expect 1 to_be_true
  end

  it 'is still available in old style alias'
    Expect 0 not toBeTrue
    Expect 1 toBeTrue
  end
end
