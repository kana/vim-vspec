# vim-vspec - Testing framework for Vim script

[![Build Status](https://travis-ci.org/kana/vim-vspec.svg)](https://travis-ci.org/kana/vim-vspec)

vim-vspec is a testing framework for Vim script.  It consists of:

* Utilities to run tests in isolated Vim process,
* A Vim plugin to write tests in a format which resembles [RSpec](https://rspec.info/), and
* Additional syntax/indent files for Vim script to write tests.

vim-vspec is not a tool to set up environment to run tests.  If you want to test a plugin which depends on some other plugins, you have to:

* Install such dependencies to somewhere, and
* Specify where the dependencies are installed to run tests.

These steps are tedious to do by hand.  It is recommended to use [vim-flavor](https://github.com/kana/vim-flavor) to automate setting up test environment and running tests.

See also:

* [A tutorial to use vim-vspec by Vimcasts.org](http://vimcasts.org/episodes/an-introduction-to-vspec/)
* [Introduce unit testing to Vim plugin development with vim-vspec](https://whileimautomaton.net/2013/02/13211500)
* [Use Travis CI for Vim plugin development](https://whileimautomaton.net/2013/02/08211255)




<!-- vim: set expandtab shiftwidth=4 softtabstop=4 textwidth=78 : -->
