" Vim global plugin for correcting typing mistakes
" Last Change: 2000 Oct 15
" Maintainer: Bram Moolenaar <Bram@vim.org>
" License:	This file is placed in the public domain.

if exists("loaded_typecorr")
  finish
endif
let loaded_typecorr = 1

let s:save_cpo = &cpo
set cpo&vim

iabbrev ad advertisement
iabbrev crv createvar
iabbrev LDD $(LDDIR)
iabbrev ldd $(LDDIR)
iabbrev LDL $(LDLIBS)
iabbrev ldl $(LDLIBS)
iabbrev CO $(COMPILE.c)
iabbrev co $(COMPILE.c)
iabbrev LI $(LINK.c)
iabbrev li $(LINK.c)
iabbrev pr PROGS =
iabbrev pro $(PROGS)
iabbrev //b /*************************************************************************
iabbrev //e <space>*************************************************************************/
iabbrev "b """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev "e """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev /u /usr/local/share/vim/vim72/
iabbrev plu $HOME/.vim/plugin
iabbrev doc $HOME/.vim/doc
iabbrev vimm C:\Program Files\Vim\vim72
iabbrev fil C:\Program Files\Vim\vimfiles
iabbrev teh the
iabbrev otehr other
iabbrev wnat want
iabbrev viod void
iabbrev synchronisation
	\ synchronization
let s:count = 4

if !hasmapto('<Plug>TypecorrAdd')
  map <unique> <Leader>a  <Plug>TypecorrAdd
endif
noremap <unique> <script> <Plug>TypecorrAdd  <SID>Add

noremenu <script> Plugin.Add\ Correction      <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>

function s:Add(from, correct)
  let to = input("type the correction for " . a:from . ": ")
  exe ":iabbrev " . a:from . " " . to
  if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
  let s:count = s:count + 1
  echo s:count . " corrections now"
endfunction

if !exists(":Correct")
  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

let &cpo = s:save_cpo
