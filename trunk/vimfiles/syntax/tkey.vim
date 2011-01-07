"Script_name: txt.vim
"Maintainer: Yongping Guo
"Mail: guoyoooping@163.com
"Description: syntax for plain/text.
"Where_to_patch: $HOME/.vim/syntax or $VIMRUNTIME/syntax/
"Date: 2009-12-27
"Language: plain/text :)
"Install_detail:
        "1. put this file in $HOME/.vim/syntax or $VIMRUNTIME/syntax/
        "2. Add the following line in your .vimrc:
        "au BufRead,BufNewFile *.txt setlocal ft=txt
"Version: 1.0.1
"ChangeLog:
        "v1.0: Initial upload
        "v1.0.1: delete the personal configuration in txt.vim, it might not be
        "fit for everyone.

"#============================================================================
" pre set.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn clear
syn case ignore
"Keywords
syn keyword txtTodo   todo note debug MMMMM QQAQQ
syn keyword txtError  error bug QQQQQ

" 路径名:
syn match txtBrackets "^\.[^:]*:"
" 关键字:
syn match cmdLine "(\[.*\])"



"#============================================================================
" color definitions (specific)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi link txtUrl      Underlined"ModeMsg"Tabline"PmenuSbar
hi link txtTitle      Title"ModeMsg"Tabline"PmenuSbar
hi link txtList         SignColumn"Pmenu"DiffText"Statement
hi link txtQuotes       MoreMsg"String
hi link txtApostrophe    WarningMsg"Special
hi link txtParentesis   String"Special "Comment
hi link txtBrackets  Function"Special
hi link txtError  ErrorMsg
hi link txtTodo  Todo
hi link txtEmailMsg     PmenuSbar
hi link txtEmailQuote   Structure
hi link txtComment     comment
hi link cmdLine  Keyword
hi def link cmdOut LineNr
hi def link cmdOutBar Ignore
hi def link txtBookParentesis Macro

"set background=dark
let b:current_syntax = 'tkey'

" vim:tw=0:et
