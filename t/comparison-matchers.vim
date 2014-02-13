describe '=='
  it 'tests equality of given values with &ignorecase'
    set noignorecase
    Expect 123 == 123
    Expect 123 not == 789
    Expect 'abc' == 'abc'
    Expect 'abc' not == 'ABC'
    Expect 'abc' not == 'xyz'
    Expect ['abc'] == ['abc']
    Expect ['abc'] not == ['ABC']
    Expect ['abc'] not == ['xyz']
    Expect {'abc': 'def'} == {'abc': 'def'}
    Expect {'abc': 'def'} not == {'abc': 'DEF'}
    Expect {'abc': 'def'} not == {'abc': 'xyz'}

    set ignorecase
    Expect 123 == 123
    Expect 123 not == 789
    Expect 'abc' == 'abc'
    Expect 'abc' == 'ABC'
    Expect 'abc' not == 'xyz'
    Expect ['abc'] == ['abc']
    Expect ['abc'] == ['ABC']
    Expect ['abc'] not == ['xyz']
    Expect {'abc': 'def'} == {'abc': 'def'}
    Expect {'abc': 'def'} == {'abc': 'DEF'}
    Expect {'abc': 'def'} not == {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==#'
  it 'tests equality of given values case-sensitively'
    set noignorecase
    Expect 123 ==# 123
    Expect 123 not ==# 789
    Expect 'abc' ==# 'abc'
    Expect 'abc' not ==# 'ABC'
    Expect 'abc' not ==# 'xyz'
    Expect ['abc'] ==# ['abc']
    Expect ['abc'] not ==# ['ABC']
    Expect ['abc'] not ==# ['xyz']
    Expect {'abc': 'def'} ==# {'abc': 'def'}
    Expect {'abc': 'def'} not ==# {'abc': 'DEF'}
    Expect {'abc': 'def'} not ==# {'abc': 'xyz'}

    set ignorecase
    Expect 123 ==# 123
    Expect 123 not ==# 789
    Expect 'abc' ==# 'abc'
    Expect 'abc' not ==# 'ABC'
    Expect 'abc' not ==# 'xyz'
    Expect ['abc'] ==# ['abc']
    Expect ['abc'] not ==# ['ABC']
    Expect ['abc'] not ==# ['xyz']
    Expect {'abc': 'def'} ==# {'abc': 'def'}
    Expect {'abc': 'def'} not ==# {'abc': 'DEF'}
    Expect {'abc': 'def'} not ==# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '==?'
  it 'tests equality of given values case-insensitively'
    set noignorecase
    Expect 123 ==? 123
    Expect 123 not ==? 789
    Expect 'abc' ==? 'abc'
    Expect 'abc' ==? 'ABC'
    Expect 'abc' not ==? 'xyz'
    Expect ['abc'] ==? ['abc']
    Expect ['abc'] ==? ['ABC']
    Expect ['abc'] not ==? ['xyz']
    Expect {'abc': 'def'} ==? {'abc': 'def'}
    Expect {'abc': 'def'} ==? {'abc': 'DEF'}
    Expect {'abc': 'def'} not ==? {'abc': 'xyz'}

    set ignorecase
    Expect 123 ==? 123
    Expect 123 not ==? 789
    Expect 'abc' ==? 'abc'
    Expect 'abc' ==? 'ABC'
    Expect 'abc' not ==? 'xyz'
    Expect ['abc'] ==? ['abc']
    Expect ['abc'] ==? ['ABC']
    Expect ['abc'] not ==? ['xyz']
    Expect {'abc': 'def'} ==? {'abc': 'def'}
    Expect {'abc': 'def'} ==? {'abc': 'DEF'}
    Expect {'abc': 'def'} not ==? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!='
  it 'tests equality of given values with &ignorecase'
    set noignorecase
    Expect 123 not != 123
    Expect 123 != 789
    Expect 'abc' not != 'abc'
    Expect 'abc' != 'ABC'
    Expect 'abc' != 'xyz'
    Expect ['abc'] not != ['abc']
    Expect ['abc'] != ['ABC']
    Expect ['abc'] != ['xyz']
    Expect {'abc': 'def'} not != {'abc': 'def'}
    Expect {'abc': 'def'} != {'abc': 'DEF'}
    Expect {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase
    Expect 123 not != 123
    Expect 123 != 789
    Expect 'abc' not != 'abc'
    Expect 'abc' not != 'ABC'
    Expect 'abc' != 'xyz'
    Expect ['abc'] not != ['abc']
    Expect ['abc'] not != ['ABC']
    Expect ['abc'] != ['xyz']
    Expect {'abc': 'def'} not != {'abc': 'def'}
    Expect {'abc': 'def'} not != {'abc': 'DEF'}
    Expect {'abc': 'def'} != {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=#'
  it 'tests equality of given values case-sensitively'
    set noignorecase
    Expect 123 not !=# 123
    Expect 123 !=# 789
    Expect 'abc' not !=# 'abc'
    Expect 'abc' !=# 'ABC'
    Expect 'abc' !=# 'xyz'
    Expect ['abc'] not !=# ['abc']
    Expect ['abc'] !=# ['ABC']
    Expect ['abc'] !=# ['xyz']
    Expect {'abc': 'def'} not !=# {'abc': 'def'}
    Expect {'abc': 'def'} !=# {'abc': 'DEF'}
    Expect {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase
    Expect 123 not !=# 123
    Expect 123 !=# 789
    Expect 'abc' not !=# 'abc'
    Expect 'abc' !=# 'ABC'
    Expect 'abc' !=# 'xyz'
    Expect ['abc'] not !=# ['abc']
    Expect ['abc'] !=# ['ABC']
    Expect ['abc'] !=# ['xyz']
    Expect {'abc': 'def'} not !=# {'abc': 'def'}
    Expect {'abc': 'def'} !=# {'abc': 'DEF'}
    Expect {'abc': 'def'} !=# {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '!=?'
  it 'tests equality of given values case-insensitively'
    set noignorecase
    Expect 123 not !=? 123
    Expect 123 !=? 789
    Expect 'abc' not !=? 'abc'
    Expect 'abc' not !=? 'ABC'
    Expect 'abc' !=? 'xyz'
    Expect ['abc'] not !=? ['abc']
    Expect ['abc'] not !=? ['ABC']
    Expect ['abc'] !=? ['xyz']
    Expect {'abc': 'def'} not !=? {'abc': 'def'}
    Expect {'abc': 'def'} not !=? {'abc': 'DEF'}
    Expect {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase
    Expect 123 not !=? 123
    Expect 123 !=? 789
    Expect 'abc' not !=? 'abc'
    Expect 'abc' not !=? 'ABC'
    Expect 'abc' !=? 'xyz'
    Expect ['abc'] not !=? ['abc']
    Expect ['abc'] not !=? ['ABC']
    Expect ['abc'] !=? ['xyz']
    Expect {'abc': 'def'} not !=? {'abc': 'def'}
    Expect {'abc': 'def'} not !=? {'abc': 'DEF'}
    Expect {'abc': 'def'} !=? {'abc': 'xyz'}

    set ignorecase&
  end
end

describe '<'
  it 'tests the order of given values with &ignorecase'
    set noignorecase
    Expect 123 < 456
    Expect 123 not < 123
    Expect 456 not < 123
    Expect 'abc' < 'xyz'
    Expect 'abc' not < 'XYZ'
    Expect 'abc' not < 'abc'
    Expect 'abc' not < 'ABC'
    Expect 'xyz' not < 'abc'

    set ignorecase
    Expect 123 < 456
    Expect 123 not < 123
    Expect 456 not < 123
    Expect 'abc' < 'xyz'
    Expect 'abc' < 'XYZ'
    Expect 'abc' not < 'abc'
    Expect 'abc' not < 'ABC'
    Expect 'xyz' not < 'abc'

    set ignorecase&
  end
end

describe '<#'
  it 'tests the order of given values case-sensitively'
    set noignorecase
    Expect 123 <# 456
    Expect 123 not <# 123
    Expect 456 not <# 123
    Expect 'abc' <# 'xyz'
    Expect 'abc' not <# 'XYZ'
    Expect 'abc' not <# 'abc'
    Expect 'abc' not <# 'ABC'
    Expect 'xyz' not <# 'abc'

    set ignorecase
    Expect 123 <# 456
    Expect 123 not <# 123
    Expect 456 not <# 123
    Expect 'abc' <# 'xyz'
    Expect 'abc' not <# 'XYZ'
    Expect 'abc' not <# 'abc'
    Expect 'abc' not <# 'ABC'
    Expect 'xyz' not <# 'abc'

    set ignorecase&
  end
end

describe '<?'
  it 'tests the order of given values case-insensitively'
    set noignorecase
    Expect 123 <? 456
    Expect 123 not <? 123
    Expect 456 not <? 123
    Expect 'abc' <? 'xyz'
    Expect 'abc' <? 'XYZ'
    Expect 'abc' not <? 'abc'
    Expect 'abc' not <? 'ABC'
    Expect 'xyz' not <? 'abc'

    set ignorecase
    Expect 123 <? 456
    Expect 123 not <? 123
    Expect 456 not <? 123
    Expect 'abc' <? 'xyz'
    Expect 'abc' <? 'XYZ'
    Expect 'abc' not <? 'abc'
    Expect 'abc' not <? 'ABC'
    Expect 'xyz' not <? 'abc'

    set ignorecase&
  end
end

describe '<='
  it 'tests the order of given values with &ignorecase'
    set noignorecase
    Expect 123 <= 456
    Expect 123 <= 123
    Expect 456 not <= 123
    Expect 'abc' <= 'xyz'
    Expect 'abc' not <= 'XYZ'
    Expect 'abc' <= 'abc'
    Expect 'abc' not <= 'ABC'
    Expect 'xyz' not <= 'abc'

    set ignorecase
    Expect 123 <= 456
    Expect 123 <= 123
    Expect 456 not <= 123
    Expect 'abc' <= 'xyz'
    Expect 'abc' <= 'XYZ'
    Expect 'abc' <= 'abc'
    Expect 'abc' <= 'ABC'
    Expect 'xyz' not <= 'abc'

    set ignorecase&
  end
end

describe '<=#'
  it 'tests the order of given values case-sensitively'
    set noignorecase
    Expect 123 <=# 456
    Expect 123 <=# 123
    Expect 456 not <=# 123
    Expect 'abc' <=# 'xyz'
    Expect 'abc' not <=# 'XYZ'
    Expect 'abc' <=# 'abc'
    Expect 'abc' not <=# 'ABC'
    Expect 'xyz' not <=# 'abc'

    set ignorecase
    Expect 123 <=# 456
    Expect 123 <=# 123
    Expect 456 not <=# 123
    Expect 'abc' <=# 'xyz'
    Expect 'abc' not <=# 'XYZ'
    Expect 'abc' <=# 'abc'
    Expect 'abc' not <=# 'ABC'
    Expect 'xyz' not <=# 'abc'

    set ignorecase&
  end
end

describe '<=?'
  it 'tests the order of given values case-insensitively'
    set noignorecase
    Expect 123 <=? 456
    Expect 123 <=? 123
    Expect 456 not <=? 123
    Expect 'abc' <=? 'xyz'
    Expect 'abc' <=? 'XYZ'
    Expect 'abc' <=? 'abc'
    Expect 'abc' <=? 'ABC'
    Expect 'xyz' not <=? 'abc'

    set ignorecase
    Expect 123 <=? 456
    Expect 123 <=? 123
    Expect 456 not <=? 123
    Expect 'abc' <=? 'xyz'
    Expect 'abc' <=? 'XYZ'
    Expect 'abc' <=? 'abc'
    Expect 'abc' <=? 'ABC'
    Expect 'xyz' not <=? 'abc'

    set ignorecase&
  end
end

describe '>'
  it 'tests the order of given values with &ignorecase'
    set noignorecase
    Expect 123 not > 456
    Expect 123 not > 123
    Expect 456 > 123
    Expect 'abc' not > 'xyz'
    Expect 'abc' > 'XYZ'
    Expect 'abc' not > 'abc'
    Expect 'abc' > 'ABC'
    Expect 'xyz' > 'abc'

    set ignorecase
    Expect 123 not > 456
    Expect 123 not > 123
    Expect 456 > 123
    Expect 'abc' not > 'xyz'
    Expect 'abc' not > 'XYZ'
    Expect 'abc' not > 'abc'
    Expect 'abc' not > 'ABC'
    Expect 'xyz' > 'abc'

    set ignorecase&
  end
end

describe '>#'
  it 'tests the order of given values case-sensitively'
    set noignorecase
    Expect 123 not ># 456
    Expect 123 not ># 123
    Expect 456 ># 123
    Expect 'abc' not ># 'xyz'
    Expect 'abc' ># 'XYZ'
    Expect 'abc' not ># 'abc'
    Expect 'abc' ># 'ABC'
    Expect 'xyz' ># 'abc'

    set ignorecase
    Expect 123 not ># 456
    Expect 123 not ># 123
    Expect 456 ># 123
    Expect 'abc' not ># 'xyz'
    Expect 'abc' ># 'XYZ'
    Expect 'abc' not ># 'abc'
    Expect 'abc' ># 'ABC'
    Expect 'xyz' ># 'abc'

    set ignorecase&
  end
end

describe '>?'
  it 'tests the order of given values case-insensitively'
    set noignorecase
    Expect 123 not >? 456
    Expect 123 not >? 123
    Expect 456 >? 123
    Expect 'abc' not >? 'xyz'
    Expect 'abc' not >? 'XYZ'
    Expect 'abc' not >? 'abc'
    Expect 'abc' not >? 'ABC'
    Expect 'xyz' >? 'abc'

    set ignorecase
    Expect 123 not >? 456
    Expect 123 not >? 123
    Expect 456 >? 123
    Expect 'abc' not >? 'xyz'
    Expect 'abc' not >? 'XYZ'
    Expect 'abc' not >? 'abc'
    Expect 'abc' not >? 'ABC'
    Expect 'xyz' >? 'abc'

    set ignorecase&
  end
end

describe '>='
  it 'tests the order of given values with &ignorecase'
    set noignorecase
    Expect 123 not >= 456
    Expect 123 >= 123
    Expect 456 >= 123
    Expect 'abc' not >= 'xyz'
    Expect 'abc' >= 'XYZ'
    Expect 'abc' >= 'abc'
    Expect 'abc' >= 'ABC'
    Expect 'xyz' >= 'abc'

    set ignorecase
    Expect 123 not >= 456
    Expect 123 >= 123
    Expect 456 >= 123
    Expect 'abc' not >= 'xyz'
    Expect 'abc' not >= 'XYZ'
    Expect 'abc' >= 'abc'
    Expect 'abc' >= 'ABC'
    Expect 'xyz' >= 'abc'

    set ignorecase&
  end
end

describe '>=#'
  it 'tests the order of given values case-sensitively'
    set noignorecase
    Expect 123 not >=# 456
    Expect 123 >=# 123
    Expect 456 >=# 123
    Expect 'abc' not >=# 'xyz'
    Expect 'abc' >=# 'XYZ'
    Expect 'abc' >=# 'abc'
    Expect 'abc' >=# 'ABC'
    Expect 'xyz' >=# 'abc'

    set ignorecase
    Expect 123 not >=# 456
    Expect 123 >=# 123
    Expect 456 >=# 123
    Expect 'abc' not >=# 'xyz'
    Expect 'abc' >=# 'XYZ'
    Expect 'abc' >=# 'abc'
    Expect 'abc' >=# 'ABC'
    Expect 'xyz' >=# 'abc'

    set ignorecase&
  end
end

describe '>=?'
  it 'tests the order of given values case-insensitively'
    set noignorecase
    Expect 123 not >=? 456
    Expect 123 >=? 123
    Expect 456 >=? 123
    Expect 'abc' not >=? 'xyz'
    Expect 'abc' not >=? 'XYZ'
    Expect 'abc' >=? 'abc'
    Expect 'abc' >=? 'ABC'
    Expect 'xyz' >=? 'abc'

    set ignorecase
    Expect 123 not >=? 456
    Expect 123 >=? 123
    Expect 456 >=? 123
    Expect 'abc' not >=? 'xyz'
    Expect 'abc' not >=? 'XYZ'
    Expect 'abc' >=? 'abc'
    Expect 'abc' >=? 'ABC'
    Expect 'xyz' >=? 'abc'

    set ignorecase&
  end
end

describe '=~'
  it 'performs regexp matching with &ignorecase'
    set noignorecase
    Expect 'abc' =~ '^a'
    Expect 'abc' not =~ '^A'
    Expect 'abc' not =~ '^x'

    set ignorecase
    Expect 'abc' =~ '^a'
    Expect 'abc' =~ '^A'
    Expect 'abc' not =~ '^x'

    set ignorecase&
  end
end

describe '=~#'
  it 'performs regexp matching case-sensitively'
    set noignorecase
    Expect 'abc' =~# '^a'
    Expect 'abc' not =~# '^A'
    Expect 'abc' not =~# '^x'

    set ignorecase
    Expect 'abc' =~# '^a'
    Expect 'abc' not =~# '^A'
    Expect 'abc' not =~# '^x'

    set ignorecase&
  end
end

describe '=~?'
  it 'performs regexp matching case-insensitively'
    set noignorecase
    Expect 'abc' =~? '^a'
    Expect 'abc' =~? '^A'
    Expect 'abc' not =~? '^x'

    set ignorecase
    Expect 'abc' =~? '^a'
    Expect 'abc' =~? '^A'
    Expect 'abc' not =~? '^x'

    set ignorecase&
  end
end

describe '!~'
  it 'performs regexp matching with &ignorecase'
    set noignorecase
    Expect 'abc' not !~ '^a'
    Expect 'abc' !~ '^A'
    Expect 'abc' !~ '^x'

    set ignorecase
    Expect 'abc' not !~ '^a'
    Expect 'abc' not !~ '^A'
    Expect 'abc' !~ '^x'

    set ignorecase&
  end
end

describe '!~#'
  it 'performs regexp matching case-sensitively'
    set noignorecase
    Expect 'abc' not !~# '^a'
    Expect 'abc' !~# '^A'
    Expect 'abc' !~# '^x'

    set ignorecase
    Expect 'abc' not !~# '^a'
    Expect 'abc' !~# '^A'
    Expect 'abc' !~# '^x'

    set ignorecase&
  end
end

describe '!~?'
  it 'performs regexp matching case-insensitively'
    set noignorecase
    Expect 'abc' not !~? '^a'
    Expect 'abc' not !~? '^A'
    Expect 'abc' !~? '^x'

    set ignorecase
    Expect 'abc' not !~? '^a'
    Expect 'abc' not !~? '^A'
    Expect 'abc' !~? '^x'

    set ignorecase&
  end
end

describe 'is'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 is l1
    Expect l1 not is l2
    Expect d1 is d1
    Expect d1 not is d2

    set ignorecase
    Expect l1 is l1
    Expect l1 not is l2
    Expect d1 is d1
    Expect d1 not is d2

    set ignorecase&
  end

  it 'tests equality of given values with &ignorecase'
    set noignorecase
    Expect 123 is 123
    Expect 123 not is 789
    Expect 'abc' is 'abc'
    Expect 'abc' not is 'ABC'
    Expect 'abc' not is 'xyz'

    set ignorecase
    Expect 123 is 123
    Expect 123 not is 789
    Expect 'abc' is 'abc'
    Expect 'abc' is 'ABC'
    Expect 'abc' not is 'xyz'

    set ignorecase&
  end
end

describe 'is#'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 is# l1
    Expect l1 not is# l2
    Expect d1 is# d1
    Expect d1 not is# d2

    set ignorecase
    Expect l1 is# l1
    Expect l1 not is# l2
    Expect d1 is# d1
    Expect d1 not is# d2

    set ignorecase&
  end

  it 'tests equality of given values case-sensitively'
    set noignorecase
    Expect 123 is# 123
    Expect 123 not is# 789
    Expect 'abc' is# 'abc'
    Expect 'abc' not is# 'ABC'
    Expect 'abc' not is# 'xyz'

    set ignorecase
    Expect 123 is# 123
    Expect 123 not is# 789
    Expect 'abc' is# 'abc'
    Expect 'abc' not is# 'ABC'
    Expect 'abc' not is# 'xyz'

    set ignorecase&
  end
end

describe 'is?'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 is? l1
    Expect l1 not is? l2
    Expect d1 is? d1
    Expect d1 not is? d2

    set ignorecase
    Expect l1 is? l1
    Expect l1 not is? l2
    Expect d1 is? d1
    Expect d1 not is? d2

    set ignorecase&
  end

  it 'tests equality of given values case-insensitively'
    set noignorecase
    Expect 123 is? 123
    Expect 123 not is? 789
    Expect 'abc' is? 'abc'
    Expect 'abc' is? 'ABC'
    Expect 'abc' not is? 'xyz'

    set ignorecase
    Expect 123 is? 123
    Expect 123 not is? 789
    Expect 'abc' is? 'abc'
    Expect 'abc' is? 'ABC'
    Expect 'abc' not is? 'xyz'

    set ignorecase&
  end
end

describe 'isnot'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 not isnot l1
    Expect l1 isnot l2
    Expect d1 not isnot d1
    Expect d1 isnot d2

    set ignorecase
    Expect l1 not isnot l1
    Expect l1 isnot l2
    Expect d1 not isnot d1
    Expect d1 isnot d2

    set ignorecase&
  end

  it 'tests equality of given values with &ignorecase'
    set noignorecase
    Expect 123 not isnot 123
    Expect 123 isnot 789
    Expect 'abc' not isnot 'abc'
    Expect 'abc' isnot 'ABC'
    Expect 'abc' isnot 'xyz'

    set ignorecase
    Expect 123 not isnot 123
    Expect 123 isnot 789
    Expect 'abc' not isnot 'abc'
    Expect 'abc' not isnot 'ABC'
    Expect 'abc' isnot 'xyz'

    set ignorecase&
  end
end

describe 'isnot#'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 not isnot# l1
    Expect l1 isnot# l2
    Expect d1 not isnot# d1
    Expect d1 isnot# d2

    set ignorecase
    Expect l1 not isnot# l1
    Expect l1 isnot# l2
    Expect d1 not isnot# d1
    Expect d1 isnot# d2

    set ignorecase&
  end

  it 'tests equality of given values case-sensitively'
    set noignorecase
    Expect 123 not isnot# 123
    Expect 123 isnot# 789
    Expect 'abc' not isnot# 'abc'
    Expect 'abc' isnot# 'ABC'
    Expect 'abc' isnot# 'xyz'

    set ignorecase
    Expect 123 not isnot# 123
    Expect 123 isnot# 789
    Expect 'abc' not isnot# 'abc'
    Expect 'abc' isnot# 'ABC'
    Expect 'abc' isnot# 'xyz'

    set ignorecase&
  end
end

describe 'isnot?'
  it 'compares identities of given references'
    let l1 = []
    let l2 = []
    let d1 = {}
    let d2 = {}

    set noignorecase
    Expect l1 not isnot? l1
    Expect l1 isnot? l2
    Expect d1 not isnot? d1
    Expect d1 isnot? d2

    set ignorecase
    Expect l1 not isnot? l1
    Expect l1 isnot? l2
    Expect d1 not isnot? d1
    Expect d1 isnot? d2

    set ignorecase&
  end

  it 'tests equality of given values case-insensitively'
    set noignorecase
    Expect 123 not isnot? 123
    Expect 123 isnot? 789
    Expect 'abc' not isnot? 'abc'
    Expect 'abc' not isnot? 'ABC'
    Expect 'abc' isnot? 'xyz'

    set ignorecase
    Expect 123 not isnot? 123
    Expect 123 isnot? 789
    Expect 'abc' not isnot? 'abc'
    Expect 'abc' not isnot? 'ABC'
    Expect 'abc' isnot? 'xyz'

    set ignorecase&
  end
end
