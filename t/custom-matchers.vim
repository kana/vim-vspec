describe 'vspec#customize_matcher'
  it 'should define a custom matcher'
    let caught = !!0
    try
      Expect [] toBeEmpty
      let caught = !!0
    catch /^vspec:InvalidOperation:Unknown custom matcher - 'toBeEmpty'$/
      let caught = !0
    endtry
    Expect caught toBeTrue

    call vspec#customize_matcher('toBeEmpty', function('empty'))

    Expect [] toBeEmpty
  end
end
