describe 'Syntax highlighting'
  before
    set ignorecase
  end
  after
    set ignorecase&
  end
  it 'highlights vspec-specific keywords'
    Expect type(s) ==# type('')
    Expect type(s) not ==# type(0)
    Expect expr { {'': '}'} } to_throw
    SKIP
    TODO
  end
  context 'with a nested suite'
    it 'is supported'
    end
  end
end
