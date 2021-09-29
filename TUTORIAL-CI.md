# How to set up GitHub Actions as CI for Vim plugin development

## Preface

This tutorial describes how to use
[GitHub Actions](https://docs.github.com/en/actions)
as CI for Vim plugin development.

You'll get the following benefits after this tutorial:

* Automatically run tests for each pull request and push to the main branch.
* Regularly run tests with the latest version of dependencies, including Vim
  itself, to detect breaking changes to your Vim plugin.

To set up CI for Vim plugin, you have to choose the following stuffs:

* How to set up environment to run tests.
* How to install Vim itself to run tests.
* How to resolve dependencies for your Vim plugin to run tests.
* How to write tests for your Vim plugin.

There are various choices for them.
In this tutorial, the following toolchain is used:

* How to set up environment to run tests.
  * → [GitHub Actions](https://docs.github.com/en/actions)
* How to install Vim itself to run tests.
  * → [thinca/action-setup-vim](https://github.com/thinca/action-setup-vim)
* How to resolve dependencies for your Vim plugin to run tests.
  * → [vim-flavor](https://github.com/kana/vim-flavor)
* How to write tests for your Vim plugin.
  * → [vim-vspec](https://github.com/kana/vim-vspec)

## Steps

Follow the steps below in the root directory of your Vim plugin repository.

Note that the configuration files described below are just examples.
Feel free to tweak them to match you preference.

### 1. Create files for the toolchain.

#### Update `.gitignore`

Add the following lines to `.gitignore`:

```
.vim-flavor
Flavorfile.lock
Gemfile.lock
```

These files and directories will be created by the toolchain.

#### Create `.vim-version`

Create `.vim-version` with the following line:

```
v8.2.3458
```

This file declares which Vim version to use for CI.

#### Create `.ruby-version`

Create `.ruby-version` with the following line:

```
3.0.2
```

This file declares which Ruby version to use for CI.
It is also used to run tests on your machine.  

#### Create `Gemfile`

Create `Gemfile` with the following content:

```ruby
source 'https://rubygems.org'

gem 'vim-flavor', '~> 4.0'
```

This file is required to install vim-flavor.

#### Create `Rakefile`

Create `Rakefile` with the following content:

```ruby
task :ci => [:dump, :test]

task :dump do
  sh 'vim --version'
end

task :test do
  sh 'bundle exec vim-flavor test'
end
```

This file defines common tasks for CI and local development.

#### [Optional] Create `Flavorfile`

If your Vim plugin doesn't depend on other plugins, you may skip this step.

If your Vim plugin depends on other plugins, you have to declare such
dependencies in `Flavorfile`.

The following example declares your Vim plugin depends on
[kana/vim-textobj-user](https://github.com/kana/vim-textobj-user)
version 0.7 or later (but less than 1.0).

```ruby
flavor 'kana/vim-textobj-user', '~> 0.7'

# vim: filetype=ruby
```

This file is used by vim-flavor to install dependencies for tests.

#### [Optional] Create `.github/dependabot.yml`

If you want to get a pull request to update new vim-flavor version, create
`.github/dependabot.yml` with the following content:

```yaml
version: 2
updates:
  - package-ecosystem: "bundler"
    directory: "/"
    schedule:
      interval: "weekly"
    versioning-strategy: increase
```

Note that the above is just an example to set up Dependabot.  See
[About Dependabot version updates](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/about-dependabot-version-updates)
if you want to tweak update policy.

#### Create `.github/workflows/ci.yml`

Create `.github/workflows/ci.yml` with the following content:

```yaml
name: CI

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
  schedule:
    - cron: 0 0 * * *

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        bundler-cache: true
    - name: Get local Vim version
      run: echo "local_vim_version=$(<.vim-version)" >>$GITHUB_ENV
    - name: Set up Vim
      uses: thinca/action-setup-vim@v1
      with:
        vim_version: ${{ github.event_name == 'schedule' && 'head' || env.local_vim_version }}
        vim_type: vim
        download: never
    - name: Run tests
      # 2>&1 required to avoid interleaved stdout and stderr in log.
      run: rake ci 2>&1
```

This configuration means that:

- Run tests for each pull request and push to the main branch.
  Vim version to run tests is determined by `.vim-version`.
- Run tests everyday with the latest Vim version.

### 2. Install the toolchain.

#### Install [rbenv](https://github.com/rbenv/rbenv)

This is required to run tests on your machine, because vim-flavor is written in
Ruby.  See rbenv repository about how to install it.

#### Install vim-flavor

Run the following command:

```bash
bundle install
```

### 3. Check whether the toolchain properly works on your machine.

Create `t/dummy.vim` with the following content:

```vim
describe 'The toolchain'
  it 'is properly installed and configured'
    Expect 0 == 0
  end
end
```

This is a dummy to check whether the toolchain properly works on your machine.
So that you don't have to commit this file.

Use the following command to run tests:

```bash
rake test
```

If everything works well, expected output looks like as follows:

```
$ rake test
bundle exec vim-flavor test
-------- Preparing dependencies
Checking versions...
  Use kana/vim-vspec ... v1.9.2
Deploying plugins...
  kana/vim-vspec v1.9.2 ... done
Completed.
-------- Testing a Vim plugin
t/dummy.vim .. ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.02 cusr  0.01 csys =  0.05 CPU)
Result: PASS
```

Note that vim-flavor automatically installs the latest vim-vspec version into
`.vim-flavor` directory for tests.  So that you don't have to install vim-vspec
on your `~/.vim` to run tests.  (But it would be better to install vim-vspec
globally if you want to enable syntax highlighting and proper indentation for
vim-vspec keywords like `describe` and `it`)

### 4. Write actual tests.

This step might be the hardest part depending on what your Vim plugin does.

If you decide to write actual tests later, you may commit `t/dummy.vim` created
in the previous step.

See vim-vspec [README](./README.md) and [the reference](./doc/vspec.txt) for
details on writing tests.

[The tests for vim-vspec](./t) might be a useful to know advanced usage, but it
might be hard to grasp for new users, because the tests are written in
a vim-vspec way to test vim-vspec itself.

### 5. Create a pull request with the above changes.

GitHub will run CI for the pull request.

Merge the pull request if CI works well.
From now on, CI is enabled for your Vim plugin repository.
