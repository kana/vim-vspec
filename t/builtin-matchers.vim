describe '=='
  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    Expect 123 == 123
    ExpectNot 123 == 789
    Expect 'abc' == 'abc'
    ExpectNot 'abc' == 'ABC'
    ExpectNot 'abc' == 'xyz'
    Expect ['abc'] == ['abc']
    ExpectNot ['abc'] == ['ABC']
    ExpectNot ['abc'] == ['xyz']
    Expect {'abc': 'def'} == {'abc': 'def'}
    ExpectNot {'abc': 'def'} == {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} == {'abc': 'xyz'}

    set ignorecase
    Expect 123 == 123
    ExpectNot 123 == 789
    Expect 'abc' == 'abc'
    Expect 'abc' == 'ABC'
    ExpectNot 'abc' == 'xyz'
    Expect ['abc'] == ['abc']
    Expect ['abc'] == ['ABC']
    ExpectNot ['abc'] == ['xyz']
    Expect {'abc': 'def'} == {'abc': 'def'}
    Expect {'abc': 'def'} == {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} == {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==#'
  it 'should compare equality of given values case-sensitively'
    set noignorecase
    Expect 123 ==# 123
    ExpectNot 123 ==# 789
    Expect 'abc' ==# 'abc'
    ExpectNot 'abc' ==# 'ABC'
    ExpectNot 'abc' ==# 'xyz'
    Expect ['abc'] ==# ['abc']
    ExpectNot ['abc'] ==# ['ABC']
    ExpectNot ['abc'] ==# ['xyz']
    Expect {'abc': 'def'} ==# {'abc': 'def'}
    ExpectNot {'abc': 'def'} ==# {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} ==# {'abc': 'xyz'}

    set ignorecase
    Expect 123 ==# 123
    ExpectNot 123 ==# 789
    Expect 'abc' ==# 'abc'
    ExpectNot 'abc' ==# 'ABC'
    ExpectNot 'abc' ==# 'xyz'
    Expect ['abc'] ==# ['abc']
    ExpectNot ['abc'] ==# ['ABC']
    ExpectNot ['abc'] ==# ['xyz']
    Expect {'abc': 'def'} ==# {'abc': 'def'}
    ExpectNot {'abc': 'def'} ==# {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} ==# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==?'
  it 'should compare equality of given values case-insensitively'
    set noignorecase
    Expect 123 ==? 123
    ExpectNot 123 ==? 789
    Expect 'abc' ==? 'abc'
    Expect 'abc' ==? 'ABC'
    ExpectNot 'abc' ==? 'xyz'
    Expect ['abc'] ==? ['abc']
    Expect ['abc'] ==? ['ABC']
    ExpectNot ['abc'] ==? ['xyz']
    Expect {'abc': 'def'} ==? {'abc': 'def'}
    Expect {'abc': 'def'} ==? {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} ==? {'abc': 'xyz'}

    set ignorecase
    Expect 123 ==? 123
    ExpectNot 123 ==? 789
    Expect 'abc' ==? 'abc'
    Expect 'abc' ==? 'ABC'
    ExpectNot 'abc' ==? 'xyz'
    Expect ['abc'] ==? ['abc']
    Expect ['abc'] ==? ['ABC']
    ExpectNot ['abc'] ==? ['xyz']
    Expect {'abc': 'def'} ==? {'abc': 'def'}
    Expect {'abc': 'def'} ==? {'abc': 'DEF'}
    ExpectNot {'abc': 'def'} ==? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!='
  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    ExpectNot 123 != 123
    Expect 123 != 789
    ExpectNot 'abc' != 'abc'
    Expect 'abc' != 'ABC'
    Expect 'abc' != 'xyz'
    ExpectNot ['abc'] != ['abc']
    Expect ['abc'] != ['ABC']
    Expect ['abc'] != ['xyz']
    ExpectNot {'abc': 'def'} != {'abc': 'def'}
    Expect {'abc': 'def'} != {'abc': 'DEF'}
    Expect {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase
    ExpectNot 123 != 123
    Expect 123 != 789
    ExpectNot 'abc' != 'abc'
    ExpectNot 'abc' != 'ABC'
    Expect 'abc' != 'xyz'
    ExpectNot ['abc'] != ['abc']
    ExpectNot ['abc'] != ['ABC']
    Expect ['abc'] != ['xyz']
    ExpectNot {'abc': 'def'} != {'abc': 'def'}
    ExpectNot {'abc': 'def'} != {'abc': 'DEF'}
    Expect {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=#'
  it 'should compare equality of given values case-sensitively'
    set noignorecase
    ExpectNot 123 !=# 123
    Expect 123 !=# 789
    ExpectNot 'abc' !=# 'abc'
    Expect 'abc' !=# 'ABC'
    Expect 'abc' !=# 'xyz'
    ExpectNot ['abc'] !=# ['abc']
    Expect ['abc'] !=# ['ABC']
    Expect ['abc'] !=# ['xyz']
    ExpectNot {'abc': 'def'} !=# {'abc': 'def'}
    Expect {'abc': 'def'} !=# {'abc': 'DEF'}
    Expect {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase
    ExpectNot 123 !=# 123
    Expect 123 !=# 789
    ExpectNot 'abc' !=# 'abc'
    Expect 'abc' !=# 'ABC'
    Expect 'abc' !=# 'xyz'
    ExpectNot ['abc'] !=# ['abc']
    Expect ['abc'] !=# ['ABC']
    Expect ['abc'] !=# ['xyz']
    ExpectNot {'abc': 'def'} !=# {'abc': 'def'}
    Expect {'abc': 'def'} !=# {'abc': 'DEF'}
    Expect {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=?'
  it 'should compare equality of given values case-insensitively'
    set noignorecase
    ExpectNot 123 !=? 123
    Expect 123 !=? 789
    ExpectNot 'abc' !=? 'abc'
    ExpectNot 'abc' !=? 'ABC'
    Expect 'abc' !=? 'xyz'
    ExpectNot ['abc'] !=? ['abc']
    ExpectNot ['abc'] !=? ['ABC']
    Expect ['abc'] !=? ['xyz']
    ExpectNot {'abc': 'def'} !=? {'abc': 'def'}
    ExpectNot {'abc': 'def'} !=? {'abc': 'DEF'}
    Expect {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase
    ExpectNot 123 !=? 123
    Expect 123 !=? 789
    ExpectNot 'abc' !=? 'abc'
    ExpectNot 'abc' !=? 'ABC'
    Expect 'abc' !=? 'xyz'
    ExpectNot ['abc'] !=? ['abc']
    ExpectNot ['abc'] !=? ['ABC']
    Expect ['abc'] !=? ['xyz']
    ExpectNot {'abc': 'def'} !=? {'abc': 'def'}
    ExpectNot {'abc': 'def'} !=? {'abc': 'DEF'}
    Expect {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '<'
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    Expect 123 < 456
    ExpectNot 123 < 123
    ExpectNot 456 < 123
    Expect 'abc' < 'xyz'
    ExpectNot 'abc' < 'XYZ'
    ExpectNot 'abc' < 'abc'
    ExpectNot 'abc' < 'ABC'
    ExpectNot 'xyz' < 'abc'

    set ignorecase
    Expect 123 < 456
    ExpectNot 123 < 123
    ExpectNot 456 < 123
    Expect 'abc' < 'xyz'
    Expect 'abc' < 'XYZ'
    ExpectNot 'abc' < 'abc'
    ExpectNot 'abc' < 'ABC'
    ExpectNot 'xyz' < 'abc'

    set ignorecase&
  end
end

describe '<#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    Expect 123 <# 456
    ExpectNot 123 <# 123
    ExpectNot 456 <# 123
    Expect 'abc' <# 'xyz'
    ExpectNot 'abc' <# 'XYZ'
    ExpectNot 'abc' <# 'abc'
    ExpectNot 'abc' <# 'ABC'
    ExpectNot 'xyz' <# 'abc'

    set ignorecase
    Expect 123 <# 456
    ExpectNot 123 <# 123
    ExpectNot 456 <# 123
    Expect 'abc' <# 'xyz'
    ExpectNot 'abc' <# 'XYZ'
    ExpectNot 'abc' <# 'abc'
    ExpectNot 'abc' <# 'ABC'
    ExpectNot 'xyz' <# 'abc'

    set ignorecase&
  end
end

describe '<?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    Expect 123 <? 456
    ExpectNot 123 <? 123
    ExpectNot 456 <? 123
    Expect 'abc' <? 'xyz'
    Expect 'abc' <? 'XYZ'
    ExpectNot 'abc' <? 'abc'
    ExpectNot 'abc' <? 'ABC'
    ExpectNot 'xyz' <? 'abc'

    set ignorecase
    Expect 123 <? 456
    ExpectNot 123 <? 123
    ExpectNot 456 <? 123
    Expect 'abc' <? 'xyz'
    Expect 'abc' <? 'XYZ'
    ExpectNot 'abc' <? 'abc'
    ExpectNot 'abc' <? 'ABC'
    ExpectNot 'xyz' <? 'abc'

    set ignorecase&
  end
end

describe '<='
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    Expect 123 <= 456
    Expect 123 <= 123
    ExpectNot 456 <= 123
    Expect 'abc' <= 'xyz'
    ExpectNot 'abc' <= 'XYZ'
    Expect 'abc' <= 'abc'
    ExpectNot 'abc' <= 'ABC'
    ExpectNot 'xyz' <= 'abc'

    set ignorecase
    Expect 123 <= 456
    Expect 123 <= 123
    ExpectNot 456 <= 123
    Expect 'abc' <= 'xyz'
    Expect 'abc' <= 'XYZ'
    Expect 'abc' <= 'abc'
    Expect 'abc' <= 'ABC'
    ExpectNot 'xyz' <= 'abc'

    set ignorecase&
  end
end

describe '<=#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    Expect 123 <=# 456
    Expect 123 <=# 123
    ExpectNot 456 <=# 123
    Expect 'abc' <=# 'xyz'
    ExpectNot 'abc' <=# 'XYZ'
    Expect 'abc' <=# 'abc'
    ExpectNot 'abc' <=# 'ABC'
    ExpectNot 'xyz' <=# 'abc'

    set ignorecase
    Expect 123 <=# 456
    Expect 123 <=# 123
    ExpectNot 456 <=# 123
    Expect 'abc' <=# 'xyz'
    ExpectNot 'abc' <=# 'XYZ'
    Expect 'abc' <=# 'abc'
    ExpectNot 'abc' <=# 'ABC'
    ExpectNot 'xyz' <=# 'abc'

    set ignorecase&
  end
end

describe '<=?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    Expect 123 <=? 456
    Expect 123 <=? 123
    ExpectNot 456 <=? 123
    Expect 'abc' <=? 'xyz'
    Expect 'abc' <=? 'XYZ'
    Expect 'abc' <=? 'abc'
    Expect 'abc' <=? 'ABC'
    ExpectNot 'xyz' <=? 'abc'

    set ignorecase
    Expect 123 <=? 456
    Expect 123 <=? 123
    ExpectNot 456 <=? 123
    Expect 'abc' <=? 'xyz'
    Expect 'abc' <=? 'XYZ'
    Expect 'abc' <=? 'abc'
    Expect 'abc' <=? 'ABC'
    ExpectNot 'xyz' <=? 'abc'

    set ignorecase&
  end
end

describe '>'
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    ExpectNot 123 > 456
    ExpectNot 123 > 123
    Expect 456 > 123
    ExpectNot 'abc' > 'xyz'
    Expect 'abc' > 'XYZ'
    ExpectNot 'abc' > 'abc'
    Expect 'abc' > 'ABC'
    Expect 'xyz' > 'abc'

    set ignorecase
    ExpectNot 123 > 456
    ExpectNot 123 > 123
    Expect 456 > 123
    ExpectNot 'abc' > 'xyz'
    ExpectNot 'abc' > 'XYZ'
    ExpectNot 'abc' > 'abc'
    ExpectNot 'abc' > 'ABC'
    Expect 'xyz' > 'abc'

    set ignorecase&
  end
end

describe '>#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    ExpectNot 123 ># 456
    ExpectNot 123 ># 123
    Expect 456 ># 123
    ExpectNot 'abc' ># 'xyz'
    Expect 'abc' ># 'XYZ'
    ExpectNot 'abc' ># 'abc'
    Expect 'abc' ># 'ABC'
    Expect 'xyz' ># 'abc'

    set ignorecase
    ExpectNot 123 ># 456
    ExpectNot 123 ># 123
    Expect 456 ># 123
    ExpectNot 'abc' ># 'xyz'
    Expect 'abc' ># 'XYZ'
    ExpectNot 'abc' ># 'abc'
    Expect 'abc' ># 'ABC'
    Expect 'xyz' ># 'abc'

    set ignorecase&
  end
end

describe '>?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    ExpectNot 123 >? 456
    ExpectNot 123 >? 123
    Expect 456 >? 123
    ExpectNot 'abc' >? 'xyz'
    ExpectNot 'abc' >? 'XYZ'
    ExpectNot 'abc' >? 'abc'
    ExpectNot 'abc' >? 'ABC'
    Expect 'xyz' >? 'abc'

    set ignorecase
    ExpectNot 123 >? 456
    ExpectNot 123 >? 123
    Expect 456 >? 123
    ExpectNot 'abc' >? 'xyz'
    ExpectNot 'abc' >? 'XYZ'
    ExpectNot 'abc' >? 'abc'
    ExpectNot 'abc' >? 'ABC'
    Expect 'xyz' >? 'abc'

    set ignorecase&
  end
end

describe '>='
  it 'should compare order of given values with &ignorecase'
    set noignorecase
    ExpectNot 123 >= 456
    Expect 123 >= 123
    Expect 456 >= 123
    ExpectNot 'abc' >= 'xyz'
    Expect 'abc' >= 'XYZ'
    Expect 'abc' >= 'abc'
    Expect 'abc' >= 'ABC'
    Expect 'xyz' >= 'abc'

    set ignorecase
    ExpectNot 123 >= 456
    Expect 123 >= 123
    Expect 456 >= 123
    ExpectNot 'abc' >= 'xyz'
    ExpectNot 'abc' >= 'XYZ'
    Expect 'abc' >= 'abc'
    Expect 'abc' >= 'ABC'
    Expect 'xyz' >= 'abc'

    set ignorecase&
  end
end

describe '>=#'
  it 'should compare order of given values case-sensitively'
    set noignorecase
    ExpectNot 123 >=# 456
    Expect 123 >=# 123
    Expect 456 >=# 123
    ExpectNot 'abc' >=# 'xyz'
    Expect 'abc' >=# 'XYZ'
    Expect 'abc' >=# 'abc'
    Expect 'abc' >=# 'ABC'
    Expect 'xyz' >=# 'abc'

    set ignorecase
    ExpectNot 123 >=# 456
    Expect 123 >=# 123
    Expect 456 >=# 123
    ExpectNot 'abc' >=# 'xyz'
    Expect 'abc' >=# 'XYZ'
    Expect 'abc' >=# 'abc'
    Expect 'abc' >=# 'ABC'
    Expect 'xyz' >=# 'abc'

    set ignorecase&
  end
end

describe '>=?'
  it 'should compare order of given values case-insensitively'
    set noignorecase
    ExpectNot 123 >=? 456
    Expect 123 >=? 123
    Expect 456 >=? 123
    ExpectNot 'abc' >=? 'xyz'
    ExpectNot 'abc' >=? 'XYZ'
    Expect 'abc' >=? 'abc'
    Expect 'abc' >=? 'ABC'
    Expect 'xyz' >=? 'abc'

    set ignorecase
    ExpectNot 123 >=? 456
    Expect 123 >=? 123
    Expect 456 >=? 123
    ExpectNot 'abc' >=? 'xyz'
    ExpectNot 'abc' >=? 'XYZ'
    Expect 'abc' >=? 'abc'
    Expect 'abc' >=? 'ABC'
    Expect 'xyz' >=? 'abc'

    set ignorecase&
  end
end

describe '=~'
  it 'should perform regexp matching with &ignorecase'
    set noignorecase
    Expect 'abc' =~ '^a'
    ExpectNot 'abc' =~ '^A'
    ExpectNot 'abc' =~ '^x'

    set ignorecase
    Expect 'abc' =~ '^a'
    Expect 'abc' =~ '^A'
    ExpectNot 'abc' =~ '^x'

    set ignorecase&
  end
end

describe '=~#'
  it 'should perform regexp matching case-sensitively'
    set noignorecase
    Expect 'abc' =~# '^a'
    ExpectNot 'abc' =~# '^A'
    ExpectNot 'abc' =~# '^x'

    set ignorecase
    Expect 'abc' =~# '^a'
    ExpectNot 'abc' =~# '^A'
    ExpectNot 'abc' =~# '^x'

    set ignorecase&
  end
end

describe '=~?'
  it 'should perform regexp matching case-insensitively'
    set noignorecase
    Expect 'abc' =~? '^a'
    Expect 'abc' =~? '^A'
    ExpectNot 'abc' =~? '^x'

    set ignorecase
    Expect 'abc' =~? '^a'
    Expect 'abc' =~? '^A'
    ExpectNot 'abc' =~? '^x'

    set ignorecase&
  end
end

describe '!~'
  it 'should perform regexp matching with &ignorecase'
    set noignorecase
    ExpectNot 'abc' !~ '^a'
    Expect 'abc' !~ '^A'
    Expect 'abc' !~ '^x'

    set ignorecase
    ExpectNot 'abc' !~ '^a'
    ExpectNot 'abc' !~ '^A'
    Expect 'abc' !~ '^x'

    set ignorecase&
  end
end

describe '!~#'
  it 'should perform regexp matching case-sensitively'
    set noignorecase
    ExpectNot 'abc' !~# '^a'
    Expect 'abc' !~# '^A'
    Expect 'abc' !~# '^x'

    set ignorecase
    ExpectNot 'abc' !~# '^a'
    Expect 'abc' !~# '^A'
    Expect 'abc' !~# '^x'

    set ignorecase&
  end
end

describe '!~?'
  it 'should perform regexp matching case-insensitively'
    set noignorecase
    ExpectNot 'abc' !~? '^a'
    ExpectNot 'abc' !~? '^A'
    Expect 'abc' !~? '^x'

    set ignorecase
    ExpectNot 'abc' !~? '^a'
    ExpectNot 'abc' !~? '^A'
    Expect 'abc' !~? '^x'

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
    Expect l1 is l1
    ExpectNot l1 is l2
    Expect d1 is d1
    ExpectNot d1 is d2

    set ignorecase
    Expect l1 is l1
    ExpectNot l1 is l2
    Expect d1 is d1
    ExpectNot d1 is d2

    set ignorecase&
  end

  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    Expect 123 is 123
    ExpectNot 123 is 789
    Expect 'abc' is 'abc'
    ExpectNot 'abc' is 'ABC'
    ExpectNot 'abc' is 'xyz'

    set ignorecase
    Expect 123 is 123
    ExpectNot 123 is 789
    Expect 'abc' is 'abc'
    Expect 'abc' is 'ABC'
    ExpectNot 'abc' is 'xyz'

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
    Expect l1 is# l1
    ExpectNot l1 is# l2
    Expect d1 is# d1
    ExpectNot d1 is# d2

    set ignorecase
    Expect l1 is# l1
    ExpectNot l1 is# l2
    Expect d1 is# d1
    ExpectNot d1 is# d2

    set ignorecase&
  end

  it 'should compare equality of given values case-sensitively'
    set noignorecase
    Expect 123 is# 123
    ExpectNot 123 is# 789
    Expect 'abc' is# 'abc'
    ExpectNot 'abc' is# 'ABC'
    ExpectNot 'abc' is# 'xyz'

    set ignorecase
    Expect 123 is# 123
    ExpectNot 123 is# 789
    Expect 'abc' is# 'abc'
    ExpectNot 'abc' is# 'ABC'
    ExpectNot 'abc' is# 'xyz'

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
    Expect l1 is? l1
    ExpectNot l1 is? l2
    Expect d1 is? d1
    ExpectNot d1 is? d2

    set ignorecase
    Expect l1 is? l1
    ExpectNot l1 is? l2
    Expect d1 is? d1
    ExpectNot d1 is? d2

    set ignorecase&
  end

  it 'should compare equality of given values case-insensitively'
    set noignorecase
    Expect 123 is? 123
    ExpectNot 123 is? 789
    Expect 'abc' is? 'abc'
    Expect 'abc' is? 'ABC'
    ExpectNot 'abc' is? 'xyz'

    set ignorecase
    Expect 123 is? 123
    ExpectNot 123 is? 789
    Expect 'abc' is? 'abc'
    Expect 'abc' is? 'ABC'
    ExpectNot 'abc' is? 'xyz'

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
    ExpectNot l1 isnot l1
    Expect l1 isnot l2
    ExpectNot d1 isnot d1
    Expect d1 isnot d2

    set ignorecase
    ExpectNot l1 isnot l1
    Expect l1 isnot l2
    ExpectNot d1 isnot d1
    Expect d1 isnot d2

    set ignorecase&
  end

  it 'should compare equality of given values with &ignorecase'
    set noignorecase
    ExpectNot 123 isnot 123
    Expect 123 isnot 789
    ExpectNot 'abc' isnot 'abc'
    Expect 'abc' isnot 'ABC'
    Expect 'abc' isnot 'xyz'

    set ignorecase
    ExpectNot 123 isnot 123
    Expect 123 isnot 789
    ExpectNot 'abc' isnot 'abc'
    ExpectNot 'abc' isnot 'ABC'
    Expect 'abc' isnot 'xyz'

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
    ExpectNot l1 isnot# l1
    Expect l1 isnot# l2
    ExpectNot d1 isnot# d1
    Expect d1 isnot# d2

    set ignorecase
    ExpectNot l1 isnot# l1
    Expect l1 isnot# l2
    ExpectNot d1 isnot# d1
    Expect d1 isnot# d2

    set ignorecase&
  end

  it 'should compare equality of given values case-sensitively'
    set noignorecase
    ExpectNot 123 isnot# 123
    Expect 123 isnot# 789
    ExpectNot 'abc' isnot# 'abc'
    Expect 'abc' isnot# 'ABC'
    Expect 'abc' isnot# 'xyz'

    set ignorecase
    ExpectNot 123 isnot# 123
    Expect 123 isnot# 789
    ExpectNot 'abc' isnot# 'abc'
    Expect 'abc' isnot# 'ABC'
    Expect 'abc' isnot# 'xyz'

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
    ExpectNot l1 isnot? l1
    Expect l1 isnot? l2
    ExpectNot d1 isnot? d1
    Expect d1 isnot? d2

    set ignorecase
    ExpectNot l1 isnot? l1
    Expect l1 isnot? l2
    ExpectNot d1 isnot? d1
    Expect d1 isnot? d2

    set ignorecase&
  end

  it 'should compare equality of given values case-insensitively'
    set noignorecase
    ExpectNot 123 isnot? 123
    Expect 123 isnot? 789
    ExpectNot 'abc' isnot? 'abc'
    ExpectNot 'abc' isnot? 'ABC'
    Expect 'abc' isnot? 'xyz'

    set ignorecase
    ExpectNot 123 isnot? 123
    Expect 123 isnot? 789
    ExpectNot 'abc' isnot? 'abc'
    ExpectNot 'abc' isnot? 'ABC'
    Expect 'abc' isnot? 'xyz'

    set ignorecase&
  end
end

describe 'be false'
  it 'should succeed if a given value is false'
    Expect 0 toBeFalse
    ExpectNot 1 toBeFalse
  end
end

describe 'be true'
  it 'should succeed if a given value is true'
    ExpectNot 0 toBeTrue
    Expect 1 toBeTrue
  end
end
