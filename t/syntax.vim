silent filetype plugin on
syntax enable

function! SynStack(lnum, col)
  return map(synstack(a:lnum, a:col), 'synIDattr(v:val, "name")')
endfunction

describe 'Syntax highlighting'
  before
    tabnew
    tabonly!

    silent put =[
    \   'describe ''Syntax highlighting''',
    \   '  before',
    \   '    set ignorecase',
    \   '  end',
    \   '  after',
    \   '    set ignorecase&',
    \   '  end',
    \   '  it ''highlights vspec-specific keywords''',
    \   '    Expect type(s) ==# type('''')',
    \   '    Expect type(s) not ==# type(0)',
    \   '    SKIP',
    \   '    TODO',
    \   '  end',
    \   '  context ''with a nested suite''',
    \   '    it ''is supported''',
    \   '    end',
    \   '  end',
    \   'end',
    \ ]
    1 delete _

    setfiletype vim
  end

  it 'highlights :describe properly'
    Expect SynStack(1, 1) ==# ['vimVspecCommand']
    Expect SynStack(1, 2) ==# ['vimVspecCommand']
    Expect SynStack(1, 3) ==# ['vimVspecCommand']
    Expect SynStack(1, 4) ==# ['vimVspecCommand']
    Expect SynStack(1, 5) ==# ['vimVspecCommand']
    Expect SynStack(1, 6) ==# ['vimVspecCommand']
    Expect SynStack(1, 7) ==# ['vimVspecCommand']
    Expect SynStack(1, 8) ==# ['vimVspecCommand']
    Expect SynStack(1, 9) ==# []
    Expect SynStack(1, 10) ==# ['vimString']
    Expect SynStack(1, 11) ==# ['vimString']
    Expect SynStack(1, 12) ==# ['vimString']
    Expect SynStack(1, 13) ==# ['vimString']
    Expect SynStack(1, 14) ==# ['vimString']
    Expect SynStack(1, 15) ==# ['vimString']
    Expect SynStack(1, 16) ==# ['vimString']
    Expect SynStack(1, 17) ==# ['vimString']
    Expect SynStack(1, 18) ==# ['vimString']
    Expect SynStack(1, 19) ==# ['vimString']
    Expect SynStack(1, 20) ==# ['vimString']
    Expect SynStack(1, 21) ==# ['vimString']
    Expect SynStack(1, 22) ==# ['vimString']
    Expect SynStack(1, 23) ==# ['vimString']
    Expect SynStack(1, 24) ==# ['vimString']
    Expect SynStack(1, 25) ==# ['vimString']
    Expect SynStack(1, 26) ==# ['vimString']
    Expect SynStack(1, 27) ==# ['vimString']
    Expect SynStack(1, 28) ==# ['vimString']
    Expect SynStack(1, 29) ==# ['vimString']
    Expect SynStack(1, 30) ==# ['vimString']
  end

  it 'highlights :before properly'
    Expect SynStack(2, 1) ==# []
    Expect SynStack(2, 2) ==# []
    Expect SynStack(2, 3) ==# ['vimVspecCommand']
    Expect SynStack(2, 4) ==# ['vimVspecCommand']
    Expect SynStack(2, 5) ==# ['vimVspecCommand']
    Expect SynStack(2, 6) ==# ['vimVspecCommand']
    Expect SynStack(2, 7) ==# ['vimVspecCommand']
    Expect SynStack(2, 8) ==# ['vimVspecCommand']
  end

  it 'highlights :after properly'
    Expect SynStack(5, 1) ==# []
    Expect SynStack(5, 2) ==# []
    Expect SynStack(5, 3) ==# ['vimVspecCommand']
    Expect SynStack(5, 4) ==# ['vimVspecCommand']
    Expect SynStack(5, 5) ==# ['vimVspecCommand']
    Expect SynStack(5, 6) ==# ['vimVspecCommand']
    Expect SynStack(5, 7) ==# ['vimVspecCommand']
  end

  it 'highlights :it properly'
    Expect SynStack(8, 1) ==# []
    Expect SynStack(8, 2) ==# []
    Expect SynStack(8, 3) ==# ['vimVspecCommand']
    Expect SynStack(8, 4) ==# ['vimVspecCommand']
    Expect SynStack(8, 5) ==# []
    Expect SynStack(8, 6) ==# ['vimString']
    Expect SynStack(8, 7) ==# ['vimString']
    Expect SynStack(8, 8) ==# ['vimString']
    Expect SynStack(8, 9) ==# ['vimString']
    Expect SynStack(8, 10) ==# ['vimString']
    Expect SynStack(8, 11) ==# ['vimString']
    Expect SynStack(8, 12) ==# ['vimString']
    Expect SynStack(8, 13) ==# ['vimString']
    Expect SynStack(8, 14) ==# ['vimString']
    Expect SynStack(8, 15) ==# ['vimString']
    Expect SynStack(8, 16) ==# ['vimString']
    Expect SynStack(8, 17) ==# ['vimString']
    Expect SynStack(8, 18) ==# ['vimString']
    Expect SynStack(8, 19) ==# ['vimString']
    Expect SynStack(8, 20) ==# ['vimString']
    Expect SynStack(8, 21) ==# ['vimString']
    Expect SynStack(8, 22) ==# ['vimString']
    Expect SynStack(8, 23) ==# ['vimString']
    Expect SynStack(8, 24) ==# ['vimString']
    Expect SynStack(8, 25) ==# ['vimString']
    Expect SynStack(8, 26) ==# ['vimString']
    Expect SynStack(8, 27) ==# ['vimString']
    Expect SynStack(8, 28) ==# ['vimString']
    Expect SynStack(8, 29) ==# ['vimString']
    Expect SynStack(8, 30) ==# ['vimString']
    Expect SynStack(8, 31) ==# ['vimString']
    Expect SynStack(8, 32) ==# ['vimString']
    Expect SynStack(8, 33) ==# ['vimString']
    Expect SynStack(8, 34) ==# ['vimString']
    Expect SynStack(8, 35) ==# ['vimString']
    Expect SynStack(8, 36) ==# ['vimString']
    Expect SynStack(8, 37) ==# ['vimString']
    Expect SynStack(8, 38) ==# ['vimString']
    Expect SynStack(8, 39) ==# ['vimString']
    Expect SynStack(8, 40) ==# ['vimString']
    Expect SynStack(8, 41) ==# ['vimString']
  end

  it 'highlights :Expect properly'
    Expect SynStack(9, 1) ==# []
    Expect SynStack(9, 2) ==# []
    Expect SynStack(9, 3) ==# []
    Expect SynStack(9, 4) ==# []
    Expect SynStack(9, 5) ==# ['vimVspecCommand']
    Expect SynStack(9, 6) ==# ['vimVspecCommand']
    Expect SynStack(9, 7) ==# ['vimVspecCommand']
    Expect SynStack(9, 8) ==# ['vimVspecCommand']
    Expect SynStack(9, 9) ==# ['vimVspecCommand']
    Expect SynStack(9, 10) ==# ['vimVspecCommand']
    Expect SynStack(9, 11) ==# []
    Expect SynStack(9, 12) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 13) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 14) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 15) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 16) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(9, 17) ==# ['vimOperParen']
    Expect SynStack(9, 18) ==# ['vimParenSep']
    Expect SynStack(9, 19) ==# []
    Expect SynStack(9, 20) ==# ['vimOper']
    Expect SynStack(9, 21) ==# ['vimOper']
    Expect SynStack(9, 22) ==# ['vimOper']
    Expect SynStack(9, 23) ==# []
    Expect SynStack(9, 24) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 25) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 26) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 27) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(9, 28) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(9, 29) ==# ['vimOperParen', 'vimString']
    Expect SynStack(9, 30) ==# ['vimOperParen', 'vimString']
    Expect SynStack(9, 31) ==# ['vimParenSep']

    Expect SynStack(10, 1) ==# []
    Expect SynStack(10, 2) ==# []
    Expect SynStack(10, 3) ==# []
    Expect SynStack(10, 4) ==# []
    Expect SynStack(10, 5) ==# ['vimVspecCommand']
    Expect SynStack(10, 6) ==# ['vimVspecCommand']
    Expect SynStack(10, 7) ==# ['vimVspecCommand']
    Expect SynStack(10, 8) ==# ['vimVspecCommand']
    Expect SynStack(10, 9) ==# ['vimVspecCommand']
    Expect SynStack(10, 10) ==# ['vimVspecCommand']
    Expect SynStack(10, 11) ==# []
    Expect SynStack(10, 12) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 13) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 14) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 15) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 16) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(10, 17) ==# ['vimOperParen']
    Expect SynStack(10, 18) ==# ['vimParenSep']
    Expect SynStack(10, 19) ==# []
    Expect SynStack(10, 20) ==# ['vimVspecOperator']
    Expect SynStack(10, 21) ==# ['vimVspecOperator']
    Expect SynStack(10, 22) ==# ['vimVspecOperator']
    Expect SynStack(10, 23) ==# []
    Expect SynStack(10, 24) ==# ['vimOper']
    Expect SynStack(10, 25) ==# ['vimOper']
    Expect SynStack(10, 26) ==# ['vimOper']
    Expect SynStack(10, 27) ==# []
    Expect SynStack(10, 28) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 29) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 30) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 31) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(10, 32) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(10, 33) ==# ['vimOperParen', 'vimNumber']
    Expect SynStack(10, 34) ==# ['vimParenSep']
  end

  it 'highlights :SKIP and :TODO properly'
    Expect SynStack(11, 1) ==# []
    Expect SynStack(11, 2) ==# []
    Expect SynStack(11, 3) ==# []
    Expect SynStack(11, 4) ==# []
    Expect SynStack(11, 5) ==# ['vimVspecCommand']
    Expect SynStack(11, 6) ==# ['vimVspecCommand']
    Expect SynStack(11, 7) ==# ['vimVspecCommand']
    Expect SynStack(11, 8) ==# ['vimVspecCommand']

    Expect SynStack(12, 1) ==# []
    Expect SynStack(12, 2) ==# []
    Expect SynStack(12, 3) ==# []
    Expect SynStack(12, 4) ==# []
    Expect SynStack(12, 5) ==# ['vimVspecCommand']
    Expect SynStack(12, 6) ==# ['vimVspecCommand']
    Expect SynStack(12, 7) ==# ['vimVspecCommand']
    Expect SynStack(12, 8) ==# ['vimVspecCommand']
  end

  it 'highlights :end properly'
    Expect SynStack(13, 1) ==# []
    Expect SynStack(13, 2) ==# []
    Expect SynStack(13, 3) ==# ['vimVspecCommand']
    Expect SynStack(13, 4) ==# ['vimVspecCommand']
    Expect SynStack(13, 5) ==# ['vimVspecCommand']

    Expect SynStack(18, 1) ==# ['vimVspecCommand']
    Expect SynStack(18, 2) ==# ['vimVspecCommand']
    Expect SynStack(18, 3) ==# ['vimVspecCommand']
  end

  it 'highlights :end properly'
    Expect SynStack(13, 1) ==# []
    Expect SynStack(13, 2) ==# []
    Expect SynStack(13, 3) ==# ['vimVspecCommand']
    Expect SynStack(13, 4) ==# ['vimVspecCommand']
    Expect SynStack(13, 5) ==# ['vimVspecCommand']

    Expect SynStack(18, 1) ==# ['vimVspecCommand']
    Expect SynStack(18, 2) ==# ['vimVspecCommand']
    Expect SynStack(18, 3) ==# ['vimVspecCommand']
  end

  it 'highlights :context properly'
    Expect SynStack(14, 1) ==# []
    Expect SynStack(14, 2) ==# []
    Expect SynStack(14, 3) ==# ['vimVspecCommand']
    Expect SynStack(14, 4) ==# ['vimVspecCommand']
    Expect SynStack(14, 5) ==# ['vimVspecCommand']
    Expect SynStack(14, 6) ==# ['vimVspecCommand']
    Expect SynStack(14, 7) ==# ['vimVspecCommand']
    Expect SynStack(14, 8) ==# ['vimVspecCommand']
    Expect SynStack(14, 9) ==# ['vimVspecCommand']
    Expect SynStack(14, 10) ==# []
    Expect SynStack(14, 11) ==# ['vimString']
    Expect SynStack(14, 12) ==# ['vimString']
    Expect SynStack(14, 13) ==# ['vimString']
    Expect SynStack(14, 14) ==# ['vimString']
    Expect SynStack(14, 15) ==# ['vimString']
    Expect SynStack(14, 16) ==# ['vimString']
    Expect SynStack(14, 17) ==# ['vimString']
    Expect SynStack(14, 18) ==# ['vimString']
    Expect SynStack(14, 19) ==# ['vimString']
    Expect SynStack(14, 20) ==# ['vimString']
    Expect SynStack(14, 21) ==# ['vimString']
    Expect SynStack(14, 22) ==# ['vimString']
    Expect SynStack(14, 23) ==# ['vimString']
    Expect SynStack(14, 24) ==# ['vimString']
    Expect SynStack(14, 25) ==# ['vimString']
    Expect SynStack(14, 26) ==# ['vimString']
    Expect SynStack(14, 27) ==# ['vimString']
    Expect SynStack(14, 28) ==# ['vimString']
    Expect SynStack(14, 29) ==# ['vimString']
    Expect SynStack(14, 30) ==# ['vimString']
    Expect SynStack(14, 31) ==# ['vimString']
  end
end
