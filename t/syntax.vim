silent filetype plugin on
syntax enable

let s:symbol_table = {
\   ' ': ' ',
\   'vimNumber': 'N',
\   'vimOper': 'O',
\   'vimSet': ' ',
\   'vimString': 'S',
\   'vimVspecCommand': 'c',
\   'vimVspecExpectation': '_',
\   'vimVspecLambda': 'l',
\   'vimVspecLambdaBody': 'b',
\   'vimVspecOperator': 'o',
\ }

function! s:syntax_at(lnum, col)
  let name = synIDattr(synID(a:lnum, a:col, 0), 'name')
  return get(s:symbol_table, name != '' ? name : ' ', '.')
endfunction

function! HighlightingOf(file)
  new
  try
    setfiletype vim
    silent read `=a:file`
    let xs = []
    for l in range(1, line('$'))
      call add(
      \   xs,
      \   join(map(range(1, col([l, "$"]) - 1), 's:syntax_at(l, v:val)'), '')
      \ )
    endfor
    return xs
  finally
    close!
  endtry
endfunction

function! Like(file)
  return readfile(a:file)
endfunction

describe 'Syntax highlighting'
  it 'works well'
    Expect HighlightingOf('t/fixtures/sample.vim')
    \  ==# Like('t/fixtures/sample.vim.expected')
  end

  it 'does not work in invalid context'
    Expect HighlightingOf('t/fixtures/invalid.vim')
    \  ==# Like('t/fixtures/invalid.vim.expected')
  end
end
