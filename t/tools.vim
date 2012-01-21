call vspec#hint({'scope': 'vspec#scope()', 'sid': 'vspec#sid()'})

describe 'Ref'
  it 'should return the value of a script-local variable'
    Should Ref('s:expr_hinted_scope') ==# 'vspec#scope()'
    Should Ref('s:expr_hinted_sid') ==# 'vspec#sid()'
    Should eval(Ref('s:expr_hinted_sid')) =~# '^<SNR>\d\+_$'
  end
end

describe 'Set'
  it 'should modify the value of a script-local variable'
    let original_value = Ref('s:expr_hinted_sid')
    Should Ref('s:expr_hinted_sid') ==# 'vspec#sid()'

    let l = []
    call Set('s:expr_hinted_sid', l)
    Should Ref('s:expr_hinted_sid') is l

    call Set('s:expr_hinted_sid', original_value)
    Should Ref('s:expr_hinted_sid') ==# 'vspec#sid()'
  end
end

describe 'Call'
  it 'should call a script-local function'
    Should Call('s:is_matcher', '==') be true
    Should Call('s:is_matcher', '=?') be false
  end

  it 'should call a non-script-local function'
    Should Call('function', 'type') ==# function('type')
  end
end
