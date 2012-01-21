let g:DUMMY_SCOPE_CONTENT = {'abc': 'ABC', 'def': 'DEF'}
let g:dummy_scope = deepcopy(g:DUMMY_SCOPE_CONTENT)
let g:the_reference_of_dummy_scope = g:dummy_scope
call vspec#hint({'scope': 'g:dummy_scope'})

describe ':ResetContext'
  it 'should reset to the state when vspec#hint() is called'
    Should g:dummy_scope ==# g:DUMMY_SCOPE_CONTENT

    let g:dummy_scope['abc'] = 'aabbcc'  " Modify an existing variable.
    unlet g:dummy_scope['def']  " Delete an existing variable.
    let g:dummy_scope['ghi'] = 'gghhii'  " Add a new variable.

    ResetContext

    Should g:dummy_scope ==# g:DUMMY_SCOPE_CONTENT
    Should g:dummy_scope is# g:the_reference_of_dummy_scope
  end
end

describe ':SaveContext'
  it 'should save the current state for :ResetContext'
    ResetContext

    Should g:dummy_scope ==# g:DUMMY_SCOPE_CONTENT
    Should g:dummy_scope is# g:the_reference_of_dummy_scope

    let g:dummy_scope['abc'] = 'aabbcc'  " Modify an existing variable.
    unlet g:dummy_scope['def']  " Delete an existing variable.
    let g:dummy_scope['ghi'] = 'gghhii'  " Add a new variable.
    SaveContext

    Should g:dummy_scope ==# {'abc': 'aabbcc', 'ghi': 'gghhii'}
    Should g:dummy_scope is# g:the_reference_of_dummy_scope

    let g:dummy_scope['abc'] = 'cba'
    let g:dummy_scope['def'] = 'fed'
    unlet g:dummy_scope['ghi']

    Should g:dummy_scope ==# {'abc': 'cba', 'def': 'fed'}
    Should g:dummy_scope is# g:the_reference_of_dummy_scope

    ResetContext

    Should g:dummy_scope ==# {'abc': 'aabbcc', 'ghi': 'gghhii'}
    Should g:dummy_scope is# g:the_reference_of_dummy_scope

    call filter(g:dummy_scope, '0')
    call extend(g:dummy_scope, deepcopy(g:DUMMY_SCOPE_CONTENT), 'force')

    Should g:dummy_scope ==# g:DUMMY_SCOPE_CONTENT
    Should g:dummy_scope is# g:the_reference_of_dummy_scope
  end
end
