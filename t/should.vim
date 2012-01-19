describe ':Should'
  it 'should succeed if an actual value matches to an expected value'
    Should 'have to' == 'have to'
  end
  it 'should fail if an actual value does not match to an expected value'
    let is_succeeded = !0
    try
      Should 'should' ==# 'Should'
      let is_succeeded = !0
    catch /^vspec:ExpectationFailure:/
      let is_succeeded = !!0
    endtry
    Should is_succeeded be false
  end
end
