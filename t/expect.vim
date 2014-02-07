describe ':Expect'
  it 'succeeds if an actual value matches to an expected value'
    Expect 'have to' == 'have to'
  end

  it 'fails if an actual value does not match to an expected value'
    let is_succeeded = !0
    try
      Expect 'should' ==# 'Expect'
      let is_succeeded = !0
    catch /^vspec:ExpectationFailure:/
      let is_succeeded = !!0
    endtry
    Expect is_succeeded to_be_false
  end

  it 'parses "string" without errors'
    Expect 'foo' ==# "foo"
  end

  it 'parses ''|'' without errors'
    Expect '|' ==# "|"
  end

  it 'can evaluate local variables'
    let v = 'foo'
    Expect v ==# 'foo'
  end
end

describe ':Expect not'
  it 'succeeds if an actual value does not match to an expected value'
    Expect 'have to' not != 'have to'
  end

  it 'fails if an actual value matches to an expected value'
    let is_succeeded = !0
    try
      Expect 'should' not !=# 'Expect'
      let is_succeeded = !0
    catch /^vspec:ExpectationFailure:/
      let is_succeeded = !!0
    endtry
    Expect is_succeeded to_be_false
  end
end
