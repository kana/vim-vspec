" Not to use vim-vspec fetched by mduem.
let &runtimepath =
\ join(
\   filter(split(&runtimepath, ','), 'v:val !~# ''\.mduem/deps/vim-vspec'''),
\   ','
\ )

silent filetype plugin indent on
syntax enable

describe 'Automatic indentation'
  function! s:before()
    new
    setfiletype vim
    setlocal expandtab shiftwidth=2
  endfunction

  function! s:after()
    close!
  endfunction

  it 'should indent lines after :describe'
    call s:before()

    execute 'normal!' 'i' . join([
    \   'describe ''foo''',
    \   'bar',
    \   'end',
    \ ], "\<Return>")

    Expect getline(1, '$') ==# [
    \   'describe ''foo''',
    \   '  bar',
    \   'end',
    \ ]

    call s:after()
  end

  it 'should indent lines after :it'
    call s:before()

    execute 'normal!' 'i' . join([
    \   'describe ''foo''',
    \   'it ''bar''',
    \   'baz',
    \   'end',
    \   'end',
    \ ], "\<Return>")

    Expect getline(1, '$') ==# [
    \   'describe ''foo''',
    \   '  it ''bar''',
    \   '    baz',
    \   '  end',
    \   'end',
    \ ]

    call s:after()
  end
end
