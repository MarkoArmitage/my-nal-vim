

if exists('loaded_rlaber')
  finish
endif
let loaded_rlaber = 1


" ============================================================================
" syntax highlight 
au BufRead,BufNewFile diCtTmp  setlocal ft=rlabel 
au BufRead,BufNewFile -MiniBufExplorer- setlocal ft=rlabel


" ============================================================================
" variables
let s:rlabel_win_maximized = 0


" ============================================================================
" functions
if !exists('g:Rlabel_WinWidth')
    let g:Rlabel_WinWidth = 24
    let g:miniBufExplVSplit = g:Rlabel_WinWidth
endif


function! s:Rlabel_mbe_Open()
    exec "call NAL_GetSelectedBuffer()"
    " close '-MiniBufExplorer-' window
    close
    exec "call SwitchToBuf('" . g:miniBufExplCurBufName . "')"
endfunction

function! s:Rlabel_Window_Zoom()
    if s:rlabel_win_maximized
        " Restore the window back to the previous size
        exe 'vert resize ' . g:Rlabel_WinWidth
        let s:rlabel_win_maximized = 0
    else
        " Set the window size to the maximum possible without closing other
        " windows
        vert resize
        let s:rlabel_win_maximized = 1
    endif
endfunction

function! s:MyMiniBufExplorer(wflag)
    MiniBufExplorer
endfunction

function! s:MyTlistToggle(wflag)
    TlistToggle
endfunction

function! s:Mydict(wflag)
    if a:wflag == 1
	" . ==> 字符串连接(:help expression-syntax)
        let expl=system('sdcv.sh ' . expand("<cword>"))
    elseif a:wflag == 2
        let fwords=getreg("z")
        let expl=system('sdcv.sh ' . "\"" . fwords . " \"")
    endif

    windo if
    \ expand("%:p")=="/tmp/diCtTmp" |
    \ close|endif
    exec "botright vertical " . g:Rlabel_WinWidth . "split /tmp/diCtTmp"
    "botright aboveleft 20split /tmp/diCtTmp
    setlocal buftype= bufhidden=hide noswapfile
    "setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=expl/
    1
endfunction

" arg1: use `func' to open the window we want to open
" arg2: some information
function! s:Rlabel_Toggle(func, flag)
    let curwinnr = winnr()
    let buf_func = {"Mydict": "diCtTmp",
                  \ "MyTlistToggle": "__Tag_List__", 
                  \ "MyMiniBufExplorer": "-MiniBufExplorer-"}

    " if the window had opened, just close it, expect ...
    let hadopen = 0
    for key in keys(buf_func)
        if key ==# a:func && bufwinnr(buf_func[key]) != -1
            let hadopen = 1
            exec bufwinnr(buf_func[key]) . "wincmd w"
            close
            break
        endif
    endfor
    if hadopen == 1 && buf_func[a:func] !=# "diCtTmp"
        return
    endif

    " loop to all window, we force close it if any one had opened.
    for i in values(buf_func)
        let bufwinnr = bufwinnr(i)
        if bufwinnr != -1
            exec bufwinnr . "wincmd w"
            close
            break
        endif
    endfor

    " use `func' to open it
    exec "call <SID>" . a:func . "(" . a:flag . ")"

    " focus to previous window
    if buf_func[a:func] ==# "diCtTmp"
        exec curwinnr . "wincmd w"
    endif
endfunction


" ============================================================================
" mappings
map <silent> <leader>tl :call <SID>Rlabel_Toggle("MyTlistToggle", 0)<cr>
map <silent> <leader>tm :call <SID>Rlabel_Toggle("MyMiniBufExplorer", 0)<cr>
map <silent> <leader>tf :call <SID>Rlabel_Toggle("Mydict", 1)<cr>
vmap <silent> <leader>tf "zy:call <SID>Rlabel_Toggle("Mydict", 2)<cr>

au FileType rlabel nnoremap <buffer> <silent> q :close<CR>
au FileType rlabel nnoremap <buffer> <silent> x :call <SID>Rlabel_Window_Zoom()<CR>
au FileType rlabel nnoremap <buffer> <silent> t :call <SID>Rlabel_mbe_Open()<CR>

