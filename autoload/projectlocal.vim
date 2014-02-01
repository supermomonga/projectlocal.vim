let s:save_cpo = &cpo
set cpo&vim


" Default settings
let g:projectlocal#projectfile       = get(g:, 'projectlocal#projectfile', 'Projectfile')
let g:projectlocal#default_filetypes = get(g:, 'projectlocal#default_filetypes', ['project'])


function! projectlocal#apply()
  let l:projectfile = findfile(g:projectlocal#projectfile, '.;')
  if l:projectfile != ''
    " Set filetypes
    let l:projectfile_filetypes = copy(g:projectlocal#default_filetypes)
    let l:projectfile_filetypes = extend(l:projectfile_filetypes, split(&filetype, '\.'))
    for l:line in readfile(l:projectfile, '')
      if l:line != ''
        let l:projectfile_filetypes = extend(l:projectfile_filetypes, split(line, '\s*,\s*'))
      endif
    endfor
    let &l:filetype = join(l:projectfile_filetypes, '.')
    " Set project root dir
    let l:rootdir = fnamemodify(l:projectfile, ':p:h')
    let b:projectlocal_root_dir = l:rootdir
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
