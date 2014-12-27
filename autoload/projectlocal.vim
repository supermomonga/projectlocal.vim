let s:save_cpo = &cpo
set cpo&vim


" Default settings
let g:projectlocal#projectfile       = get(g:, 'projectlocal#projectfile', 'Projectfile')
let g:projectlocal#default_filetypes = get(g:, 'projectlocal#default_filetypes', ['project'])


function! projectlocal#apply()
  let l:projectfile = fnamemodify(findfile(g:projectlocal#projectfile, '.;'), ':p')
  if l:projectfile != ''
    " Set filetypes
    let l:projectfile_filetypes = copy(g:projectlocal#default_filetypes)
    let l:projectfile_filetypes += split(&filetype, '\.')
    for l:line in readfile(l:projectfile, '')
      if l:line != ''
        let l:projectfile_filetypes += split(l:line, '\s*,\s*')
      endif
    endfor
    let l:projectfile_filetypes = projectlocal#uniq(sort(l:projectfile_filetypes))
    let l:filetype = join(l:projectfile_filetypes, '.')
    let &filetype = l:filetype
    " Set project root dir
    let l:rootdir = fnamemodify(l:projectfile, ':p:h')
    let b:projectlocal_root_dir = l:rootdir
  endif
endfunction

" uniq function was introduced in vim version 7.4.218.
" To avoid calling a missing function, we use our uniq function if there is
" no uniq.
" See https://github.com/LaTeX-Box-Team/LaTeX-Box/issues/190#issuecomment-47459338.
function! projectlocal#uniq(list)
    if exists("*uniq")
        return uniq(a:list)
    endif

    let list = copy(a:list)
    let i = 0
    let seen = {}
    while i < len(list)
        if has_key(seen, list[i])
            call remove(list, i)
        else
            let seen[list[i]] = 1
            let i += 1
        endif
    endwhile
    return list
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
