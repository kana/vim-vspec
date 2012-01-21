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
    \   '  it ''should highlight vspec-specific keywords''',
    \   '    Should type(s) ==# type('''')',
    \   '    ShouldNot type(s) ==# type(0)',
    \   '  end',
    \   'end',
    \ ]
    1 delete _

    setfiletype vim
  endfunction

  it 'should highlight :describe properly'
    call s:before()

    Should SynStack(1, 1) ==# ['vimVspecCommand']
    Should SynStack(1, 2) ==# ['vimVspecCommand']
    Should SynStack(1, 3) ==# ['vimVspecCommand']
    Should SynStack(1, 4) ==# ['vimVspecCommand']
    Should SynStack(1, 5) ==# ['vimVspecCommand']
    Should SynStack(1, 6) ==# ['vimVspecCommand']
    Should SynStack(1, 7) ==# ['vimVspecCommand']
    Should SynStack(1, 8) ==# ['vimVspecCommand']
    Should SynStack(1, 9) ==# []
    Should SynStack(1, 10) ==# ['vimString']
    Should SynStack(1, 11) ==# ['vimString']
    Should SynStack(1, 12) ==# ['vimString']
    Should SynStack(1, 13) ==# ['vimString']
    Should SynStack(1, 14) ==# ['vimString']
    Should SynStack(1, 15) ==# ['vimString']
    Should SynStack(1, 16) ==# ['vimString']
    Should SynStack(1, 17) ==# ['vimString']
    Should SynStack(1, 18) ==# ['vimString']
    Should SynStack(1, 19) ==# ['vimString']
    Should SynStack(1, 20) ==# ['vimString']
    Should SynStack(1, 21) ==# ['vimString']
    Should SynStack(1, 22) ==# ['vimString']
    Should SynStack(1, 23) ==# ['vimString']
    Should SynStack(1, 24) ==# ['vimString']
    Should SynStack(1, 25) ==# ['vimString']
    Should SynStack(1, 26) ==# ['vimString']
    Should SynStack(1, 27) ==# ['vimString']
    Should SynStack(1, 28) ==# ['vimString']
    Should SynStack(1, 29) ==# ['vimString']
    Should SynStack(1, 30) ==# ['vimString']
  end

  it 'should highlight :it properly'
    call s:before()

    Should SynStack(2, 1) ==# []
    Should SynStack(2, 2) ==# []
    Should SynStack(2, 3) ==# ['vimVspecCommand']
    Should SynStack(2, 4) ==# ['vimVspecCommand']
    Should SynStack(2, 5) ==# []
    Should SynStack(2, 6) ==# ['vimString']
    Should SynStack(2, 7) ==# ['vimString']
    Should SynStack(2, 8) ==# ['vimString']
    Should SynStack(2, 9) ==# ['vimString']
    Should SynStack(2, 10) ==# ['vimString']
    Should SynStack(2, 11) ==# ['vimString']
    Should SynStack(2, 12) ==# ['vimString']
    Should SynStack(2, 13) ==# ['vimString']
    Should SynStack(2, 14) ==# ['vimString']
    Should SynStack(2, 15) ==# ['vimString']
    Should SynStack(2, 16) ==# ['vimString']
    Should SynStack(2, 17) ==# ['vimString']
    Should SynStack(2, 18) ==# ['vimString']
    Should SynStack(2, 19) ==# ['vimString']
    Should SynStack(2, 20) ==# ['vimString']
    Should SynStack(2, 21) ==# ['vimString']
    Should SynStack(2, 22) ==# ['vimString']
    Should SynStack(2, 23) ==# ['vimString']
    Should SynStack(2, 24) ==# ['vimString']
    Should SynStack(2, 25) ==# ['vimString']
    Should SynStack(2, 26) ==# ['vimString']
    Should SynStack(2, 27) ==# ['vimString']
    Should SynStack(2, 28) ==# ['vimString']
    Should SynStack(2, 29) ==# ['vimString']
    Should SynStack(2, 30) ==# ['vimString']
    Should SynStack(2, 31) ==# ['vimString']
    Should SynStack(2, 32) ==# ['vimString']
    Should SynStack(2, 33) ==# ['vimString']
    Should SynStack(2, 34) ==# ['vimString']
    Should SynStack(2, 35) ==# ['vimString']
    Should SynStack(2, 36) ==# ['vimString']
    Should SynStack(2, 37) ==# ['vimString']
    Should SynStack(2, 38) ==# ['vimString']
    Should SynStack(2, 39) ==# ['vimString']
    Should SynStack(2, 40) ==# ['vimString']
    Should SynStack(2, 41) ==# ['vimString']
    Should SynStack(2, 42) ==# ['vimString']
    Should SynStack(2, 43) ==# ['vimString']
    Should SynStack(2, 44) ==# ['vimString']
    Should SynStack(2, 45) ==# ['vimString']
    Should SynStack(2, 46) ==# ['vimString']
    Should SynStack(2, 47) ==# ['vimString']
  end

  it 'should highlight :Should properly'
    call s:before()

    Should SynStack(3, 1) ==# []
    Should SynStack(3, 2) ==# []
    Should SynStack(3, 3) ==# []
    Should SynStack(3, 4) ==# []
    Should SynStack(3, 5) ==# ['vimVspecCommand']
    Should SynStack(3, 6) ==# ['vimVspecCommand']
    Should SynStack(3, 7) ==# ['vimVspecCommand']
    Should SynStack(3, 8) ==# ['vimVspecCommand']
    Should SynStack(3, 9) ==# ['vimVspecCommand']
    Should SynStack(3, 10) ==# ['vimVspecCommand']
    Should SynStack(3, 11) ==# []
    Should SynStack(3, 12) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 13) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 14) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 15) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 16) ==# ['vimOperParen', 'vimParenSep']
    Should SynStack(3, 17) ==# ['vimOperParen']
    Should SynStack(3, 18) ==# ['vimParenSep']
    Should SynStack(3, 19) ==# []
    Should SynStack(3, 20) ==# ['vimOper']
    Should SynStack(3, 21) ==# ['vimOper']
    Should SynStack(3, 22) ==# ['vimOper']
    Should SynStack(3, 23) ==# []
    Should SynStack(3, 24) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 25) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 26) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 27) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(3, 28) ==# ['vimOperParen', 'vimParenSep']
    Should SynStack(3, 29) ==# ['vimOperParen', 'vimString']
    Should SynStack(3, 30) ==# ['vimOperParen', 'vimString']
    Should SynStack(3, 31) ==# ['vimParenSep']

    Should SynStack(4, 1) ==# []
    Should SynStack(4, 2) ==# []
    Should SynStack(4, 3) ==# []
    Should SynStack(4, 4) ==# []
    Should SynStack(4, 5) ==# ['vimVspecCommand']
    Should SynStack(4, 6) ==# ['vimVspecCommand']
    Should SynStack(4, 7) ==# ['vimVspecCommand']
    Should SynStack(4, 8) ==# ['vimVspecCommand']
    Should SynStack(4, 9) ==# ['vimVspecCommand']
    Should SynStack(4, 10) ==# ['vimVspecCommand']
    Should SynStack(4, 11) ==# ['vimVspecCommand']
    Should SynStack(4, 12) ==# ['vimVspecCommand']
    Should SynStack(4, 13) ==# ['vimVspecCommand']
    Should SynStack(4, 14) ==# []
    Should SynStack(4, 15) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 16) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 17) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 18) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 19) ==# ['vimOperParen', 'vimParenSep']
    Should SynStack(4, 20) ==# ['vimOperParen']
    Should SynStack(4, 21) ==# ['vimParenSep']
    Should SynStack(4, 22) ==# []
    Should SynStack(4, 23) ==# ['vimOper']
    Should SynStack(4, 24) ==# ['vimOper']
    Should SynStack(4, 25) ==# ['vimOper']
    Should SynStack(4, 26) ==# []
    Should SynStack(4, 27) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 28) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 29) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 30) ==# ['vimFunc', 'vimFuncName']
    Should SynStack(4, 31) ==# ['vimOperParen', 'vimParenSep']
    Should SynStack(4, 32) ==# ['vimOperParen', 'vimNumber']
    Should SynStack(4, 33) ==# ['vimParenSep']
  end

  it 'should highlight :end properly'
    call s:before()

    Should SynStack(5, 1) ==# []
    Should SynStack(5, 2) ==# []
    Should SynStack(5, 3) ==# ['vimVspecCommand']
    Should SynStack(5, 4) ==# ['vimVspecCommand']
    Should SynStack(5, 5) ==# ['vimVspecCommand']

    Should SynStack(6, 1) ==# ['vimVspecCommand']
    Should SynStack(6, 2) ==# ['vimVspecCommand']
    Should SynStack(6, 3) ==# ['vimVspecCommand']
  end
end
