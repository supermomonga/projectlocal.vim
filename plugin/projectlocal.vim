" projectlocal.vim
" Version: 0.0.1
" Author : supermomonga (@supermomonga)
" License : NYSL

if exists('g:loaded_projectlocal')
  finish
endif
let g:loaded_projectlocal = 1

let s:save_cpo = &cpo
set cpo&vim

augroup plugin-projectlocal
  " autocmd FileType * nested call projectlocal#apply()
  " autocmd BufNewFile,BufReadPost * nested call projectlocal#apply()
  " autocmd FileType * call projectlocal#apply()
  " autocmd BufReadPost * call projectlocal#apply()
  " autocmd FileReadPost * call projectlocal#apply()
  autocmd BufEnter * call projectlocal#apply()
  autocmd BufWinEnter * call projectlocal#apply()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
