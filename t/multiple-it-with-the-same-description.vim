let g:counter = 0

describe 'vspec'
  it 'works'
    let g:counter += 1
  end

  it 'works'
    let g:counter += 10
  end

  it 'works'
    let g:counter += 100
  end
end

describe 'vspec'
  it 'supports multiple :it blocks with the same {example}'
    Expect g:counter == 111
  end
end
