describe 'A vspec test script'
  describe 'with nested :describe'
    it 'is supported'
    end
  end

  context 'with :context'
    it 'is supported'
    end
  end
end

let g:stack = []

describe 'A'
  before
    call add(g:stack, '--')
    call add(g:stack, 'Ab')
  end

  it 'is run at 1st'
    Expect g:stack ==# [
    \   '--', 'Ab'
    \ ]
  end

  describe 'B'
    before
      call add(g:stack, 'Bb')
    end

    it 'is run at 3rd'
      Expect g:stack ==# [
      \   '--', 'Ab', 'Aa',
      \   '--', 'Ab', 'Aa',
      \   '--', 'Ab', 'Bb',
      \ ]
    end

    describe 'C'
      before
        call add(g:stack, 'Cb')
      end

      it 'is run at 5th'
        Expect g:stack ==# [
        \   '--', 'Ab', 'Aa',
        \   '--', 'Ab', 'Aa',
        \   '--', 'Ab', 'Bb', 'Ba', 'Aa',
        \   '--', 'Ab', 'Bb', 'Ba', 'Aa',
        \   '--', 'Ab', 'Bb', 'Cb',
        \ ]
      end

      after
        call add(g:stack, 'Ca')
      end
    end

    it 'is run at 4th'
      Expect g:stack ==# [
      \   '--', 'Ab', 'Aa',
      \   '--', 'Ab', 'Aa',
      \   '--', 'Ab', 'Bb', 'Ba', 'Aa',
      \   '--', 'Ab', 'Bb',
      \ ]
    end

    after
      call add(g:stack, 'Ba')
    end
  end

  it 'is run at 2nd'
    Expect g:stack ==# [
    \   '--', 'Ab', 'Aa',
    \   '--', 'Ab',
    \ ]
  end

  after
    call add(g:stack, 'Aa')
  end
end
