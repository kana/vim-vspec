describe 'vspec#customize_matcher'
  it 'should define a custom matcher'
    let caught = !!0
    try
      Expect [] be empty
      let caught = !!0
    catch /^vspec:InvalidOperation:Unknown custom matcher - 'empty'$/
      let caught = !0
    endtry
    Expect caught be true

    call vspec#customize_matcher('empty', function('empty'))

    Expect [] be empty
  end
end
