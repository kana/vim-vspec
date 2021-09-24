function! s:bootstrap(vspec_path)
  let args = argv()
  argdelete *
  enew

  if len(args) == 0 || args[0] ==# '-h' || args[0] ==# '--help'
    verbose echon "Usage: vspec [{dependency-path} ...] {test-script}\n"
    qall!
  endif

  let test_script = args[-1]
  let standard_paths = split(&runtimepath, ',')[1:-2]
  let dependency_paths =
  \ filter(
  \   map(args[:-2], 'fnamemodify(v:val, isdirectory(v:val) ? ":p:h" : ":p")'),
  \   'v:val !=# a:vspec_path'
  \ )
  \ + [a:vspec_path]
  let all_paths =
  \   dependency_paths
  \ + standard_paths
  \ + map(reverse(copy(dependency_paths)), 'v:val . "/after"')
  let &runtimepath = join(all_paths, ',')

  " Adjust &shellredir to include both stdout and stderr to emulate typical
  " environment.  This script is executed in the middle of --cmd, and
  " &shellredir is set to '>' in that context.
  "
  " Another solution is to use -c instead of --cmd.  But it causes a side
  " effect -- loading the test script as the first buffer.
  set shellredir=>%s\ 2>&1

  1 verbose call vspec#test(test_script)
  qall!
endfunction
call s:bootstrap(expand('<sfile>:p:h:h'))
