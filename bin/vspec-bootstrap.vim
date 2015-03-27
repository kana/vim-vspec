function! s:bootstrap()
  let args = argv()
  argdelete *
  enew

  if len(args) == 0 || args[0] ==# '-h' || args[0] ==# '--help'
    verbose echon "Usage: vspec [{dependency-path} ...] {test-script}\n"
    qall!
  endif

  let input_script = args[-1]
  let standard_paths = split(&runtimepath, ',')[1:-2]
  let non_standard_paths = reverse(map(args[:-2], '
  \  fnamemodify(v:val, isdirectory(v:val) ? ":p:h" : ":p")
  \ '))
  let all_paths = copy(standard_paths)
  for i in non_standard_paths
    let all_paths = [i] + all_paths + [i . '/after']
  endfor
  let &runtimepath = join(all_paths, ',')

  1 verbose call vspec#test(input_script)
  qall!
endfunction
call s:bootstrap()
