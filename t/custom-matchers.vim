describe 'vspec#customize_matcher'
  it 'still supports old style usage'
    let caught = !!0
    try
      Expect [] to_be_empty
      let caught = !!0
    catch /^vspec:InvalidOperation:Unknown custom matcher - 'to_be_empty'$/
      let caught = !0
    endtry
    Expect caught to_be_true

    call vspec#customize_matcher('to_be_empty', function('empty'))

    Expect [] to_be_empty
  end
end
