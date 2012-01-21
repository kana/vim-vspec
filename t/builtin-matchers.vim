describe '=='
  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    Should 123 == 123
    ShouldNot 123 == 789
    Should 'abc' == 'abc'
    ShouldNot 'abc' == 'ABC'
    ShouldNot 'abc' == 'xyz'
    Should ['abc'] == ['abc']
    ShouldNot ['abc'] == ['ABC']
    ShouldNot ['abc'] == ['xyz']
    Should {'abc': 'def'} == {'abc': 'def'}
    ShouldNot {'abc': 'def'} == {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} == {'abc': 'xyz'}

    set ignorecase
    Should 123 == 123
    ShouldNot 123 == 789
    Should 'abc' == 'abc'
    Should 'abc' == 'ABC'
    ShouldNot 'abc' == 'xyz'
    Should ['abc'] == ['abc']
    Should ['abc'] == ['ABC']
    ShouldNot ['abc'] == ['xyz']
    Should {'abc': 'def'} == {'abc': 'def'}
    Should {'abc': 'def'} == {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} == {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==#'
  it 'should compare equality of given values case-sensitively'
    set noignorecase
    Should 123 ==# 123
    ShouldNot 123 ==# 789
    Should 'abc' ==# 'abc'
    ShouldNot 'abc' ==# 'ABC'
    ShouldNot 'abc' ==# 'xyz'
    Should ['abc'] ==# ['abc']
    ShouldNot ['abc'] ==# ['ABC']
    ShouldNot ['abc'] ==# ['xyz']
    Should {'abc': 'def'} ==# {'abc': 'def'}
    ShouldNot {'abc': 'def'} ==# {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} ==# {'abc': 'xyz'}

    set ignorecase
    Should 123 ==# 123
    ShouldNot 123 ==# 789
    Should 'abc' ==# 'abc'
    ShouldNot 'abc' ==# 'ABC'
    ShouldNot 'abc' ==# 'xyz'
    Should ['abc'] ==# ['abc']
    ShouldNot ['abc'] ==# ['ABC']
    ShouldNot ['abc'] ==# ['xyz']
    Should {'abc': 'def'} ==# {'abc': 'def'}
    ShouldNot {'abc': 'def'} ==# {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} ==# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==?'
  it 'should compare equality of given values case-insensitively'
    set noignorecase
    Should 123 ==? 123
    ShouldNot 123 ==? 789
    Should 'abc' ==? 'abc'
    Should 'abc' ==? 'ABC'
    ShouldNot 'abc' ==? 'xyz'
    Should ['abc'] ==? ['abc']
    Should ['abc'] ==? ['ABC']
    ShouldNot ['abc'] ==? ['xyz']
    Should {'abc': 'def'} ==? {'abc': 'def'}
    Should {'abc': 'def'} ==? {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} ==? {'abc': 'xyz'}

    set ignorecase
    Should 123 ==? 123
    ShouldNot 123 ==? 789
    Should 'abc' ==? 'abc'
    Should 'abc' ==? 'ABC'
    ShouldNot 'abc' ==? 'xyz'
    Should ['abc'] ==? ['abc']
    Should ['abc'] ==? ['ABC']
    ShouldNot ['abc'] ==? ['xyz']
    Should {'abc': 'def'} ==? {'abc': 'def'}
    Should {'abc': 'def'} ==? {'abc': 'DEF'}
    ShouldNot {'abc': 'def'} ==? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!='
  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    ShouldNot 123 != 123
    Should 123 != 789
    ShouldNot 'abc' != 'abc'
    Should 'abc' != 'ABC'
    Should 'abc' != 'xyz'
    ShouldNot ['abc'] != ['abc']
    Should ['abc'] != ['ABC']
    Should ['abc'] != ['xyz']
    ShouldNot {'abc': 'def'} != {'abc': 'def'}
    Should {'abc': 'def'} != {'abc': 'DEF'}
    Should {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase
    ShouldNot 123 != 123
    Should 123 != 789
    ShouldNot 'abc' != 'abc'
    ShouldNot 'abc' != 'ABC'
    Should 'abc' != 'xyz'
    ShouldNot ['abc'] != ['abc']
    ShouldNot ['abc'] != ['ABC']
    Should ['abc'] != ['xyz']
    ShouldNot {'abc': 'def'} != {'abc': 'def'}
    ShouldNot {'abc': 'def'} != {'abc': 'DEF'}
    Should {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=#'
  it 'should compare equality of given values case-sensitively'
    set noignorecase
    ShouldNot 123 !=# 123
    Should 123 !=# 789
    ShouldNot 'abc' !=# 'abc'
    Should 'abc' !=# 'ABC'
    Should 'abc' !=# 'xyz'
    ShouldNot ['abc'] !=# ['abc']
    Should ['abc'] !=# ['ABC']
    Should ['abc'] !=# ['xyz']
    ShouldNot {'abc': 'def'} !=# {'abc': 'def'}
    Should {'abc': 'def'} !=# {'abc': 'DEF'}
    Should {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase
    ShouldNot 123 !=# 123
    Should 123 !=# 789
    ShouldNot 'abc' !=# 'abc'
    Should 'abc' !=# 'ABC'
    Should 'abc' !=# 'xyz'
    ShouldNot ['abc'] !=# ['abc']
    Should ['abc'] !=# ['ABC']
    Should ['abc'] !=# ['xyz']
    ShouldNot {'abc': 'def'} !=# {'abc': 'def'}
    Should {'abc': 'def'} !=# {'abc': 'DEF'}
    Should {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=?'
  it 'should compare equality of given values case-insensitively'
    set noignorecase
    ShouldNot 123 !=? 123
    Should 123 !=? 789
    ShouldNot 'abc' !=? 'abc'
    ShouldNot 'abc' !=? 'ABC'
    Should 'abc' !=? 'xyz'
    ShouldNot ['abc'] !=? ['abc']
    ShouldNot ['abc'] !=? ['ABC']
    Should ['abc'] !=? ['xyz']
    ShouldNot {'abc': 'def'} !=? {'abc': 'def'}
    ShouldNot {'abc': 'def'} !=? {'abc': 'DEF'}
    Should {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase
    ShouldNot 123 !=? 123
    Should 123 !=? 789
    ShouldNot 'abc' !=? 'abc'
    ShouldNot 'abc' !=? 'ABC'
    Should 'abc' !=? 'xyz'
    ShouldNot ['abc'] !=? ['abc']
    ShouldNot ['abc'] !=? ['ABC']
    Should ['abc'] !=? ['xyz']
    ShouldNot {'abc': 'def'} !=? {'abc': 'def'}
    ShouldNot {'abc': 'def'} !=? {'abc': 'DEF'}
    Should {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '<'
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    Should 123 < 456
    ShouldNot 123 < 123
    ShouldNot 456 < 123
    Should 'abc' < 'xyz'
    ShouldNot 'abc' < 'XYZ'
    ShouldNot 'abc' < 'abc'
    ShouldNot 'abc' < 'ABC'
    ShouldNot 'xyz' < 'abc'

    set ignorecase
    Should 123 < 456
    ShouldNot 123 < 123
    ShouldNot 456 < 123
    Should 'abc' < 'xyz'
    Should 'abc' < 'XYZ'
    ShouldNot 'abc' < 'abc'
    ShouldNot 'abc' < 'ABC'
    ShouldNot 'xyz' < 'abc'

    set ignorecase&
  end
end

describe '<#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    Should 123 <# 456
    ShouldNot 123 <# 123
    ShouldNot 456 <# 123
    Should 'abc' <# 'xyz'
    ShouldNot 'abc' <# 'XYZ'
    ShouldNot 'abc' <# 'abc'
    ShouldNot 'abc' <# 'ABC'
    ShouldNot 'xyz' <# 'abc'

    set ignorecase
    Should 123 <# 456
    ShouldNot 123 <# 123
    ShouldNot 456 <# 123
    Should 'abc' <# 'xyz'
    ShouldNot 'abc' <# 'XYZ'
    ShouldNot 'abc' <# 'abc'
    ShouldNot 'abc' <# 'ABC'
    ShouldNot 'xyz' <# 'abc'

    set ignorecase&
  end
end

describe '<?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    Should 123 <? 456
    ShouldNot 123 <? 123
    ShouldNot 456 <? 123
    Should 'abc' <? 'xyz'
    Should 'abc' <? 'XYZ'
    ShouldNot 'abc' <? 'abc'
    ShouldNot 'abc' <? 'ABC'
    ShouldNot 'xyz' <? 'abc'

    set ignorecase
    Should 123 <? 456
    ShouldNot 123 <? 123
    ShouldNot 456 <? 123
    Should 'abc' <? 'xyz'
    Should 'abc' <? 'XYZ'
    ShouldNot 'abc' <? 'abc'
    ShouldNot 'abc' <? 'ABC'
    ShouldNot 'xyz' <? 'abc'

    set ignorecase&
  end
end

describe '<='
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    Should 123 <= 456
    Should 123 <= 123
    ShouldNot 456 <= 123
    Should 'abc' <= 'xyz'
    ShouldNot 'abc' <= 'XYZ'
    Should 'abc' <= 'abc'
    ShouldNot 'abc' <= 'ABC'
    ShouldNot 'xyz' <= 'abc'

    set ignorecase
    Should 123 <= 456
    Should 123 <= 123
    ShouldNot 456 <= 123
    Should 'abc' <= 'xyz'
    Should 'abc' <= 'XYZ'
    Should 'abc' <= 'abc'
    Should 'abc' <= 'ABC'
    ShouldNot 'xyz' <= 'abc'

    set ignorecase&
  end
end

describe '<=#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    Should 123 <=# 456
    Should 123 <=# 123
    ShouldNot 456 <=# 123
    Should 'abc' <=# 'xyz'
    ShouldNot 'abc' <=# 'XYZ'
    Should 'abc' <=# 'abc'
    ShouldNot 'abc' <=# 'ABC'
    ShouldNot 'xyz' <=# 'abc'

    set ignorecase
    Should 123 <=# 456
    Should 123 <=# 123
    ShouldNot 456 <=# 123
    Should 'abc' <=# 'xyz'
    ShouldNot 'abc' <=# 'XYZ'
    Should 'abc' <=# 'abc'
    ShouldNot 'abc' <=# 'ABC'
    ShouldNot 'xyz' <=# 'abc'

    set ignorecase&
  end
end

describe '<=?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    Should 123 <=? 456
    Should 123 <=? 123
    ShouldNot 456 <=? 123
    Should 'abc' <=? 'xyz'
    Should 'abc' <=? 'XYZ'
    Should 'abc' <=? 'abc'
    Should 'abc' <=? 'ABC'
    ShouldNot 'xyz' <=? 'abc'

    set ignorecase
    Should 123 <=? 456
    Should 123 <=? 123
    ShouldNot 456 <=? 123
    Should 'abc' <=? 'xyz'
    Should 'abc' <=? 'XYZ'
    Should 'abc' <=? 'abc'
    Should 'abc' <=? 'ABC'
    ShouldNot 'xyz' <=? 'abc'

    set ignorecase&
  end
end

describe '>'
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    ShouldNot 123 > 456
    ShouldNot 123 > 123
    Should 456 > 123
    ShouldNot 'abc' > 'xyz'
    Should 'abc' > 'XYZ'
    ShouldNot 'abc' > 'abc'
    Should 'abc' > 'ABC'
    Should 'xyz' > 'abc'

    set ignorecase
    ShouldNot 123 > 456
    ShouldNot 123 > 123
    Should 456 > 123
    ShouldNot 'abc' > 'xyz'
    ShouldNot 'abc' > 'XYZ'
    ShouldNot 'abc' > 'abc'
    ShouldNot 'abc' > 'ABC'
    Should 'xyz' > 'abc'

    set ignorecase&
  end
end

describe '>#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    ShouldNot 123 ># 456
    ShouldNot 123 ># 123
    Should 456 ># 123
    ShouldNot 'abc' ># 'xyz'
    Should 'abc' ># 'XYZ'
    ShouldNot 'abc' ># 'abc'
    Should 'abc' ># 'ABC'
    Should 'xyz' ># 'abc'

    set ignorecase
    ShouldNot 123 ># 456
    ShouldNot 123 ># 123
    Should 456 ># 123
    ShouldNot 'abc' ># 'xyz'
    Should 'abc' ># 'XYZ'
    ShouldNot 'abc' ># 'abc'
    Should 'abc' ># 'ABC'
    Should 'xyz' ># 'abc'

    set ignorecase&
  end
end

describe '>?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    ShouldNot 123 >? 456
    ShouldNot 123 >? 123
    Should 456 >? 123
    ShouldNot 'abc' >? 'xyz'
    ShouldNot 'abc' >? 'XYZ'
    ShouldNot 'abc' >? 'abc'
    ShouldNot 'abc' >? 'ABC'
    Should 'xyz' >? 'abc'

    set ignorecase
    ShouldNot 123 >? 456
    ShouldNot 123 >? 123
    Should 456 >? 123
    ShouldNot 'abc' >? 'xyz'
    ShouldNot 'abc' >? 'XYZ'
    ShouldNot 'abc' >? 'abc'
    ShouldNot 'abc' >? 'ABC'
    Should 'xyz' >? 'abc'

    set ignorecase&
  end
end

describe '>='
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    ShouldNot 123 >= 456
    Should 123 >= 123
    Should 456 >= 123
    ShouldNot 'abc' >= 'xyz'
    Should 'abc' >= 'XYZ'
    Should 'abc' >= 'abc'
    Should 'abc' >= 'ABC'
    Should 'xyz' >= 'abc'

    set ignorecase
    ShouldNot 123 >= 456
    Should 123 >= 123
    Should 456 >= 123
    ShouldNot 'abc' >= 'xyz'
    ShouldNot 'abc' >= 'XYZ'
    Should 'abc' >= 'abc'
    Should 'abc' >= 'ABC'
    Should 'xyz' >= 'abc'

    set ignorecase&
  end
end

describe '>=#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    ShouldNot 123 >=# 456
    Should 123 >=# 123
    Should 456 >=# 123
    ShouldNot 'abc' >=# 'xyz'
    Should 'abc' >=# 'XYZ'
    Should 'abc' >=# 'abc'
    Should 'abc' >=# 'ABC'
    Should 'xyz' >=# 'abc'

    set ignorecase
    ShouldNot 123 >=# 456
    Should 123 >=# 123
    Should 456 >=# 123
    ShouldNot 'abc' >=# 'xyz'
    Should 'abc' >=# 'XYZ'
    Should 'abc' >=# 'abc'
    Should 'abc' >=# 'ABC'
    Should 'xyz' >=# 'abc'

    set ignorecase&
  end
end

describe '>=?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    ShouldNot 123 >=? 456
    Should 123 >=? 123
    Should 456 >=? 123
    ShouldNot 'abc' >=? 'xyz'
    ShouldNot 'abc' >=? 'XYZ'
    Should 'abc' >=? 'abc'
    Should 'abc' >=? 'ABC'
    Should 'xyz' >=? 'abc'

    set ignorecase
    ShouldNot 123 >=? 456
    Should 123 >=? 123
    Should 456 >=? 123
    ShouldNot 'abc' >=? 'xyz'
    ShouldNot 'abc' >=? 'XYZ'
    Should 'abc' >=? 'abc'
    Should 'abc' >=? 'ABC'
    Should 'xyz' >=? 'abc'

    set ignorecase&
  end
end

describe '=~'
  it 'should perform regexp matching with &ignorecase'
    set noignorecase
    Should 'abc' =~ '^a'
    ShouldNot 'abc' =~ '^A'
    ShouldNot 'abc' =~ '^x'

    set ignorecase
    Should 'abc' =~ '^a'
    Should 'abc' =~ '^A'
    ShouldNot 'abc' =~ '^x'

    set ignorecase&
  end
end

describe '=~#'
  it 'should perform regexp matching case-sensitively'
    set noignorecase
    Should 'abc' =~# '^a'
    ShouldNot 'abc' =~# '^A'
    ShouldNot 'abc' =~# '^x'

    set ignorecase
    Should 'abc' =~# '^a'
    ShouldNot 'abc' =~# '^A'
    ShouldNot 'abc' =~# '^x'

    set ignorecase&
  end
end

describe '=~?'
  it 'should perform regexp matching case-insensitively'
    set noignorecase
    Should 'abc' =~? '^a'
    Should 'abc' =~? '^A'
    ShouldNot 'abc' =~? '^x'

    set ignorecase
    Should 'abc' =~? '^a'
    Should 'abc' =~? '^A'
    ShouldNot 'abc' =~? '^x'

    set ignorecase&
  end
end

describe '!~'
  it 'should perform regexp matching with &ignorecase'
    set noignorecase
    ShouldNot 'abc' !~ '^a'
    Should 'abc' !~ '^A'
    Should 'abc' !~ '^x'

    set ignorecase
    ShouldNot 'abc' !~ '^a'
    ShouldNot 'abc' !~ '^A'
    Should 'abc' !~ '^x'

    set ignorecase&
  end
end

describe '!~#'
  it 'should perform regexp matching case-sensitively'
    set noignorecase
    ShouldNot 'abc' !~# '^a'
    Should 'abc' !~# '^A'
    Should 'abc' !~# '^x'

    set ignorecase
    ShouldNot 'abc' !~# '^a'
    Should 'abc' !~# '^A'
    Should 'abc' !~# '^x'

    set ignorecase&
  end
end

describe '!~?'
  it 'should perform regexp matching case-insensitively'
    set noignorecase
    ShouldNot 'abc' !~? '^a'
    ShouldNot 'abc' !~? '^A'
    Should 'abc' !~? '^x'

    set ignorecase
    ShouldNot 'abc' !~? '^a'
    ShouldNot 'abc' !~? '^A'
    Should 'abc' !~? '^x'

    set ignorecase&
  end
end

describe 'is'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Should l1 is l1
    ShouldNot l1 is l2
    Should d1 is d1
    ShouldNot d1 is d2

    set ignorecase
    Should l1 is l1
    ShouldNot l1 is l2
    Should d1 is d1
    ShouldNot d1 is d2

    set ignorecase&
  end

  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    Should 123 is 123
    ShouldNot 123 is 789
    Should 'abc' is 'abc'
    ShouldNot 'abc' is 'ABC'
    ShouldNot 'abc' is 'xyz'

    set ignorecase
    Should 123 is 123
    ShouldNot 123 is 789
    Should 'abc' is 'abc'
    Should 'abc' is 'ABC'
    ShouldNot 'abc' is 'xyz'

    set ignorecase&
  end
end

describe 'is#'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Should l1 is# l1
    ShouldNot l1 is# l2
    Should d1 is# d1
    ShouldNot d1 is# d2

    set ignorecase
    Should l1 is# l1
    ShouldNot l1 is# l2
    Should d1 is# d1
    ShouldNot d1 is# d2

    set ignorecase&
  end

  it 'should compare equality of given values case-sensitively'
    set noignorecase
    Should 123 is# 123
    ShouldNot 123 is# 789
    Should 'abc' is# 'abc'
    ShouldNot 'abc' is# 'ABC'
    ShouldNot 'abc' is# 'xyz'

    set ignorecase
    Should 123 is# 123
    ShouldNot 123 is# 789
    Should 'abc' is# 'abc'
    ShouldNot 'abc' is# 'ABC'
    ShouldNot 'abc' is# 'xyz'

    set ignorecase&
  end
end

describe 'is?'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Should l1 is? l1
    ShouldNot l1 is? l2
    Should d1 is? d1
    ShouldNot d1 is? d2

    set ignorecase
    Should l1 is? l1
    ShouldNot l1 is? l2
    Should d1 is? d1
    ShouldNot d1 is? d2

    set ignorecase&
  end

  it 'should compare equality of given values case-insensitively'
    set noignorecase
    Should 123 is? 123
    ShouldNot 123 is? 789
    Should 'abc' is? 'abc'
    Should 'abc' is? 'ABC'
    ShouldNot 'abc' is? 'xyz'

    set ignorecase
    Should 123 is? 123
    ShouldNot 123 is? 789
    Should 'abc' is? 'abc'
    Should 'abc' is? 'ABC'
    ShouldNot 'abc' is? 'xyz'

    set ignorecase&
  end
end

describe 'isnot'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    ShouldNot l1 isnot l1
    Should l1 isnot l2
    ShouldNot d1 isnot d1
    Should d1 isnot d2

    set ignorecase
    ShouldNot l1 isnot l1
    Should l1 isnot l2
    ShouldNot d1 isnot d1
    Should d1 isnot d2

    set ignorecase&
  end

  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    ShouldNot 123 isnot 123
    Should 123 isnot 789
    ShouldNot 'abc' isnot 'abc'
    Should 'abc' isnot 'ABC'
    Should 'abc' isnot 'xyz'

    set ignorecase
    ShouldNot 123 isnot 123
    Should 123 isnot 789
    ShouldNot 'abc' isnot 'abc'
    ShouldNot 'abc' isnot 'ABC'
    Should 'abc' isnot 'xyz'

    set ignorecase&
  end
end

describe 'isnot#'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    ShouldNot l1 isnot# l1
    Should l1 isnot# l2
    ShouldNot d1 isnot# d1
    Should d1 isnot# d2

    set ignorecase
    ShouldNot l1 isnot# l1
    Should l1 isnot# l2
    ShouldNot d1 isnot# d1
    Should d1 isnot# d2

    set ignorecase&
  end

  it 'should compare equality of given values case-sensitively'
    set noignorecase
    ShouldNot 123 isnot# 123
    Should 123 isnot# 789
    ShouldNot 'abc' isnot# 'abc'
    Should 'abc' isnot# 'ABC'
    Should 'abc' isnot# 'xyz'

    set ignorecase
    ShouldNot 123 isnot# 123
    Should 123 isnot# 789
    ShouldNot 'abc' isnot# 'abc'
    Should 'abc' isnot# 'ABC'
    Should 'abc' isnot# 'xyz'

    set ignorecase&
  end
end

describe 'isnot?'
  it 'should compare identity of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    ShouldNot l1 isnot? l1
    Should l1 isnot? l2
    ShouldNot d1 isnot? d1
    Should d1 isnot? d2

    set ignorecase
    ShouldNot l1 isnot? l1
    Should l1 isnot? l2
    ShouldNot d1 isnot? d1
    Should d1 isnot? d2

    set ignorecase&
  end

  it 'should compare equality of given values case-insensitively'
    set noignorecase
    ShouldNot 123 isnot? 123
    Should 123 isnot? 789
    ShouldNot 'abc' isnot? 'abc'
    ShouldNot 'abc' isnot? 'ABC'
    Should 'abc' isnot? 'xyz'

    set ignorecase
    ShouldNot 123 isnot? 123
    Should 123 isnot? 789
    ShouldNot 'abc' isnot? 'abc'
    ShouldNot 'abc' isnot? 'ABC'
    Should 'abc' isnot? 'xyz'

    set ignorecase&
  end
end

describe 'be false'
  it 'should succeed if a given value is false'
    Should 0 be false
    ShouldNot 1 be false
  end
end

describe 'be true'
  it 'should succeed if a given value is true'
    ShouldNot 0 be true
    Should 1 be true
  end
end
