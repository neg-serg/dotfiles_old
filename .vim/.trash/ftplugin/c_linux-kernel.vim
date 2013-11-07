" Linux kernel tags/cscope/include support for vim
" $Id: c_linux-kernel.vim 3078 2008-04-12 03:34:17Z agriffis $
"
" Copyright 2007 Aron Griffis <agriffis n01se.net>
" Released under the GNU GPL v2

" Only do this when not done yet for this buffer
if exists("b:did_c_linux_kernel_ftplugin")
  finish
endif
let b:did_c_linux_kernel_ftplugin = 1

function! LinuxKernel_SetLinuxPath()
  if !has("modify_fname")
    return 0
  endif
  let l:fwd = expand("%:p:h")     " working directory of current file

  let l:matchmin = 0
  while 1
    let l:linux_match = matchstr(l:fwd, '^.\{-' . l:matchmin . ',\}/[^/]*\(linux\|kernel\)[^/]*')
    if !strlen(l:linux_match)
      return 0
    endif
    if filereadable(l:linux_match . '/Kbuild')
      let b:linux_path = l:linux_match
      break
    endif
    let l:matchmin = strlen(l:linux_match)
  endwhile

  return 1
endfunction

if LinuxKernel_SetLinuxPath()
  setlocal shiftwidth=8
  if has("cindent")
    setlocal cinoptions+=:0
  endif

  " set include search path
  let &l:path = b:linux_path . "/include"

  " set tags path
  let &l:tags = b:linux_path . "/tags"

  " load cscope database
  if has('cscope') && filereadable(b:linux_path . "/cscope.out")
    let &l:csprg = &g:csprg . " -k"
    exe "cs add " . b:linux_path . "/cscope.out " . b:linux_path
  endif
endif
