describe ':after'
  let g:counter = 0

  after
    let g:counter += 1
  end

  it 'is called for each example (the first time)'
    Expect g:counter == 0
  end

  it 'is called for each example (the second time)'
    Expect g:counter == 1
  end

  it 'is called for each example (the third time)'
    Expect g:counter == 2
  end
end
