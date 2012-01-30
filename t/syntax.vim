silent filetype plugin on
syntax enable

function! SynStack(lnum, col)
  return map(synstack(a:lnum, a:col), 'synIDattr(v:val, "name")')
endfunction

describe 'Syntax highlighting'
  function! s:before()
    tabnew
    tabonly!

    silent put =[
    \   'describe ''Syntax highlighting''',
    \   '  before',
    \   '    set ignorecase&',
    \   '  end',
    \   '  it ''should highlight vspec-specific keywords''',
    \   '    Expect type(s) ==# type('''')',
    \   '    Expect type(s) not ==# type(0)',
    \   '  end',
    \   'end',
    \ ]
    1 delete _

    setfiletype vim
  endfunction

  it 'should highlight :describe properly'
    call s:before()

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

  it 'should highlight :before properly'
    call s:before()

    Expect SynStack(2, 1) ==# []
    Expect SynStack(2, 2) ==# []
    Expect SynStack(2, 3) ==# ['vimVspecCommand']
    Expect SynStack(2, 4) ==# ['vimVspecCommand']
    Expect SynStack(2, 5) ==# ['vimVspecCommand']
    Expect SynStack(2, 6) ==# ['vimVspecCommand']
    Expect SynStack(2, 7) ==# ['vimVspecCommand']
    Expect SynStack(2, 8) ==# ['vimVspecCommand']
  end

  it 'should highlight :it properly'
    call s:before()

    Expect SynStack(5, 1) ==# []
    Expect SynStack(5, 2) ==# []
    Expect SynStack(5, 3) ==# ['vimVspecCommand']
    Expect SynStack(5, 4) ==# ['vimVspecCommand']
    Expect SynStack(5, 5) ==# []
    Expect SynStack(5, 6) ==# ['vimString']
    Expect SynStack(5, 7) ==# ['vimString']
    Expect SynStack(5, 8) ==# ['vimString']
    Expect SynStack(5, 9) ==# ['vimString']
    Expect SynStack(5, 10) ==# ['vimString']
    Expect SynStack(5, 11) ==# ['vimString']
    Expect SynStack(5, 12) ==# ['vimString']
    Expect SynStack(5, 13) ==# ['vimString']
    Expect SynStack(5, 14) ==# ['vimString']
    Expect SynStack(5, 15) ==# ['vimString']
    Expect SynStack(5, 16) ==# ['vimString']
    Expect SynStack(5, 17) ==# ['vimString']
    Expect SynStack(5, 18) ==# ['vimString']
    Expect SynStack(5, 19) ==# ['vimString']
    Expect SynStack(5, 20) ==# ['vimString']
    Expect SynStack(5, 21) ==# ['vimString']
    Expect SynStack(5, 22) ==# ['vimString']
    Expect SynStack(5, 23) ==# ['vimString']
    Expect SynStack(5, 24) ==# ['vimString']
    Expect SynStack(5, 25) ==# ['vimString']
    Expect SynStack(5, 26) ==# ['vimString']
    Expect SynStack(5, 27) ==# ['vimString']
    Expect SynStack(5, 28) ==# ['vimString']
    Expect SynStack(5, 29) ==# ['vimString']
    Expect SynStack(5, 30) ==# ['vimString']
    Expect SynStack(5, 31) ==# ['vimString']
    Expect SynStack(5, 32) ==# ['vimString']
    Expect SynStack(5, 33) ==# ['vimString']
    Expect SynStack(5, 34) ==# ['vimString']
    Expect SynStack(5, 35) ==# ['vimString']
    Expect SynStack(5, 36) ==# ['vimString']
    Expect SynStack(5, 37) ==# ['vimString']
    Expect SynStack(5, 38) ==# ['vimString']
    Expect SynStack(5, 39) ==# ['vimString']
    Expect SynStack(5, 40) ==# ['vimString']
    Expect SynStack(5, 41) ==# ['vimString']
    Expect SynStack(5, 42) ==# ['vimString']
    Expect SynStack(5, 43) ==# ['vimString']
    Expect SynStack(5, 44) ==# ['vimString']
    Expect SynStack(5, 45) ==# ['vimString']
    Expect SynStack(5, 46) ==# ['vimString']
    Expect SynStack(5, 47) ==# ['vimString']
  end

  it 'should highlight :Expect properly'
    call s:before()

    Expect SynStack(6, 1) ==# []
    Expect SynStack(6, 2) ==# []
    Expect SynStack(6, 3) ==# []
    Expect SynStack(6, 4) ==# []
    Expect SynStack(6, 5) ==# ['vimVspecCommand']
    Expect SynStack(6, 6) ==# ['vimVspecCommand']
    Expect SynStack(6, 7) ==# ['vimVspecCommand']
    Expect SynStack(6, 8) ==# ['vimVspecCommand']
    Expect SynStack(6, 9) ==# ['vimVspecCommand']
    Expect SynStack(6, 10) ==# ['vimVspecCommand']
    Expect SynStack(6, 11) ==# []
    Expect SynStack(6, 12) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 13) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 14) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 15) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 16) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(6, 17) ==# ['vimOperParen']
    Expect SynStack(6, 18) ==# ['vimParenSep']
    Expect SynStack(6, 19) ==# []
    Expect SynStack(6, 20) ==# ['vimOper']
    Expect SynStack(6, 21) ==# ['vimOper']
    Expect SynStack(6, 22) ==# ['vimOper']
    Expect SynStack(6, 23) ==# []
    Expect SynStack(6, 24) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 25) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 26) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 27) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(6, 28) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(6, 29) ==# ['vimOperParen', 'vimString']
    Expect SynStack(6, 30) ==# ['vimOperParen', 'vimString']
    Expect SynStack(6, 31) ==# ['vimParenSep']

    Expect SynStack(7, 1) ==# []
    Expect SynStack(7, 2) ==# []
    Expect SynStack(7, 3) ==# []
    Expect SynStack(7, 4) ==# []
    Expect SynStack(7, 5) ==# ['vimVspecCommand']
    Expect SynStack(7, 6) ==# ['vimVspecCommand']
    Expect SynStack(7, 7) ==# ['vimVspecCommand']
    Expect SynStack(7, 8) ==# ['vimVspecCommand']
    Expect SynStack(7, 9) ==# ['vimVspecCommand']
    Expect SynStack(7, 10) ==# ['vimVspecCommand']
    Expect SynStack(7, 11) ==# []
    Expect SynStack(7, 12) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 13) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 14) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 15) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 16) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(7, 17) ==# ['vimOperParen']
    Expect SynStack(7, 18) ==# ['vimParenSep']
    Expect SynStack(7, 19) ==# []
    Expect SynStack(7, 20) ==# ['vimVspecOperator']
    Expect SynStack(7, 21) ==# ['vimVspecOperator']
    Expect SynStack(7, 22) ==# ['vimVspecOperator']
    Expect SynStack(7, 23) ==# []
    Expect SynStack(7, 24) ==# ['vimOper']
    Expect SynStack(7, 25) ==# ['vimOper']
    Expect SynStack(7, 26) ==# ['vimOper']
    Expect SynStack(7, 27) ==# []
    Expect SynStack(7, 28) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 29) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 30) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 31) ==# ['vimFunc', 'vimFuncName']
    Expect SynStack(7, 32) ==# ['vimOperParen', 'vimParenSep']
    Expect SynStack(7, 33) ==# ['vimOperParen', 'vimNumber']
    Expect SynStack(7, 34) ==# ['vimParenSep']
  end

  it 'should highlight :end properly'
    call s:before()

    Expect SynStack(8, 1) ==# []
    Expect SynStack(8, 2) ==# []
    Expect SynStack(8, 3) ==# ['vimVspecCommand']
    Expect SynStack(8, 4) ==# ['vimVspecCommand']
    Expect SynStack(8, 5) ==# ['vimVspecCommand']

    Expect SynStack(9, 1) ==# ['vimVspecCommand']
    Expect SynStack(9, 2) ==# ['vimVspecCommand']
    Expect SynStack(9, 3) ==# ['vimVspecCommand']
  end
end
