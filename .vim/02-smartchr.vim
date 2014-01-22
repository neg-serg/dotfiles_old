" smartchr.vim"{{{
inoremap <expr> , smartchr#one_of(', ', ',')
inoremap <expr> ? smartchr#one_of('?', '? ')

" Smart =.
inoremap <expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= '
    \ : search('\(*\<bar>!\)\%#', 'bcn') ? '= '
    \ : smartchr#one_of(' = ', '=', ' == ', '=')
augroup MyAutoCmd
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
autocmd FileType perl,php inoremap <buffer> <expr> . smartchr#loop(' . ', '->', '.')
autocmd FileType perl,php inoremap <buffer> <expr> - smartchr#loop('-', '->')
autocmd FileType vim inoremap <buffer> <expr> . smartchr#loop('.', ' . ', '..', '...')

autocmd FileType haskell,int-ghci
      \ inoremap <buffer> <expr> + smartchr#loop('+', ' ++ ')
      \| inoremap <buffer> <expr> - smartchr#loop('-', ' -> ', ' <- ')
      \| inoremap <buffer> <expr> $ smartchr#loop(' $ ', '$')
      \| inoremap <buffer> <expr> \ smartchr#loop('\ ', '\')
      \| inoremap <buffer> <expr> : smartchr#loop(':', ' :: ', ' : ')
      \| inoremap <buffer> <expr> . smartchr#loop('.', ' . ', '..')
autocmd FileType sh,bash,vim,zsh
      \ inoremap = =
      \| inoremap , ,
autocmd FileType scala
      \ inoremap <buffer> <expr> - smartchr#loop('-', ' -> ', ' <- ')
      \| inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' => ')
      \| inoremap <buffer> <expr> : smartchr#loop(': ', ':', ' :: ')
      \| inoremap <buffer> <expr> . smartchr#loop('.', ' => ')
autocmd FileType eruby,yaml
      \ inoremap <buffer> <expr> > smartchr#loop('>', '%>')
      \| inoremap <buffer> <expr> < smartchr#loop('<', '<%', '<%=')
augroup END
"}}}
