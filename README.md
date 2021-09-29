# vim-vspec - A testing framework for Vim script

[![CI](https://github.com/kana/vim-vspec/actions/workflows/ci.yml/badge.svg)](https://github.com/kana/vim-vspec/actions/workflows/ci.yml)

vim-vspec is a testing framework for Vim script.  It consists of:

* Utilities to run tests in an isolated Vim process,
* A testing framework to write tests in a format which resembles [RSpec](https://rspec.info/), and
* Additional syntax/indent files for Vim script to write tests.

A typical test script writtin with vim-vspec looks like as follows:

```vim
runtime plugin/MyGitUtilities.vim

describe 'GetGitBranchName()'
  before
    call delete('tmp/test', 'rf')
    call mkdir('tmp/test', 'p')
    cd tmp/test
  end

  after
    cd -
  end

  context 'in a non-Git directory'
    it 'returns "-"'
      Expect GetGitBranchName('.') ==# '-'
    end
  end

  context 'in a Git repository'
    before
      !git init && touch foo && git add foo && git commit -m 'Initial commit'
    end

    it 'returns the current branch'
      Expect GetGitBranchName('.') ==# 'master'
    end

    it 'detects detached HEAD state'
      !git checkout master~0
      Expect GetGitBranchName('.') ==# 'master~0'
    end
  end
end
```

A typical way to run a test script is as follows:

```bash
$PATH_TO_VSPEC/bin/prove-vspec -d $PWD t/branch.vim
```

Its output looks like as follows:

```
t/branch.vim .. ok
All tests successful.
Files=1, Tests=3,  1 wallclock secs ( 0.02 usr  0.00 sys +  0.07 cusr  0.11 csys =  0.20 CPU)
Result: PASS
```

`prove-vspec` runs a test script in an isolated Vim process, and show
a summary like the above.  User-specific configurations, like `~/.vimrc` and
files in `~/.vim`, will never be used to avoid unintentional dependencies.

Internally, vim-vspec uses
[Test Anything Protocol version 12](https://testanything.org/tap-specification.html)
as its output format.
`prove-vspec` actually invokes [`prove`](https://perldoc.perl.org/App::Prove)
to summary vim-vspec output.  Since Vim typically outputs various stuffs for
many operations, raw output without `prove` include many noises and it's hard
to read.  For example:

```
ok 1 - GetGitBranchName() in a non-Git directory returns "-"
:!git init && touch foo && git add foo && git commit -m 'Initial commit'
Initialized empty Git repository in /Users/kana/tmp/foo/tmp/test/.git/
[master (root-commit) c843aa1] Initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
ok 2 - GetGitBranchName() in a Git repository returns the current branch
:!git init && touch foo && git add foo && git commit -m 'Initial commit'
...
```

For proper testing, you have to set up environment to run tests.  Suppose that
you want to test a plugin which depends on some other plugins, you have to:

* Install such dependencies to somewhere, and
* Specify where the dependencies are installed to run tests.

These steps are tedious to do by hand.  It is recommended to use
[vim-flavor](https://github.com/kana/vim-flavor) to automate setting up test
environment and running tests.

See also:

* [A tutorial to use vim-vspec by Vimcasts.org](http://vimcasts.org/episodes/an-introduction-to-vspec/)
* [Introduce unit testing to Vim plugin development with vim-vspec](https://whileimautomaton.net/2013/02/13211500)
* [How to set up GitHub Actios as CI for Vim plugin development](./TUTORIAL-CI.md)

<!-- vim: set expandtab shiftwidth=4 softtabstop=4 textwidth=78 : -->
