describe ':Expect'
  it 'should succeed if an actual value matches to an expected value'
    Expect 'have to' == 'have to'
  end
  it 'should fail if an actual value does not match to an expected value'
    let is_succeeded = !0
    try
      Expect 'should' ==# 'Expect'
      let is_succeeded = !0
    catch /^vspec:ExpectationFailure:/
      let is_succeeded = !!0
    endtry
    Expect is_succeeded toBeFalse
  end
end

describe ':ExpectNot'
  it 'should succeed if an actual value does not match to an expected value'
    ExpectNot 'have to' != 'have to'
  end
  it 'should fail if an actual value matches to an expected value'
    let is_succeeded = !0
    try
      ExpectNot 'should' !=# 'Expect'
      let is_succeeded = !0
    catch /^vspec:ExpectationFailure:/
      let is_succeeded = !!0
    endtry
    Expect is_succeeded toBeFalse
  end
end
