let mapleader=","
"kkkkkk" ……
" :echo $VIMRUNTIME/../vimfiles/plugin/
":bdelete 3     "把一个缓冲区从列表中去除
":bwipe         "把一个缓冲区从列表中彻底去除

"中文帮助
"if version > 603
    "set helplang=cn
"end

if v:progname =~? "evie"
	finish
endif


if has("win32")
    set fileencoding=chinese
    if has("gui_running")
	"设定 windows 下 gvim 启动时最大化
	"autocmd GUIEnter * simalt ~
	set lines=48
	set columns=84
	winpos  10  0
	if exists("&cursorline")
	    set cursorline  "Highlight current
	endif
    else
	set lines=30
	set columns=86
	winpos  80  10
    endif
else
    set fileencoding=utf-8
    if has("gui_running")
	set lines=48
	set columns=134
	winpos  140  0
	if exists("&cursorline")
	    set cursorline
	endif
    else
	set lines=30
	set columns=86
	winpos  80  10
    endif
endif

" Platform
function! MySys()
    if has("win32")
	return "windows"
    else
	return "linux"
endfunction

" Switch to buffer according to file name
function! SwitchToBuf(filename)
    let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")   "For linux
    "把filename赋给fullfn, 不作任何替换
    "let fullfn = substitute(a:filename, "NotFounded", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(fullfn)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(fullfn)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . fullfn
    endif
endfunction

"用sdcv对vim进行屏幕取词
"echo "$Definition" |
"sed -n '1,/^[A-Z]/p' |
"#  从输出的第一行打印到下一部分的第一行.
"sed '$d' | sed '$d'

function! Mydict()
	"let expl0=system('sdcv -n ' .
	let expl=system('sdcv.sh ' .
	\ expand("<cword>"))
	windo if
	\ expand("%:p")=="/tmp/diCtTmp" |
	\ wq!|endif
	botright vertical 20split /tmp/diCtTmp
	"25vsp diCtTmp
	"botright aboveleft 20split /tmp/diCtTmp
	setlocal buftype= bufhidden=hide noswapfile
	"setlocal buftype=nofile bufhidden=hide noswapfile
	1s/^/\=expl/
	1
endfunction

function! Firefox_jsp()
	let ttmp=expand("<cWORD>")
	let jsp_path="http://10.3.10.19:8080/sy/"
	" jsp_fullpath="http://10.3.10.19:8080/sy/$ttmp"
	let jsp_fullpath= jsp_path . ttmp			
	let t3=system('firefox -height 50 -width 40 ' . jsp_fullpath)
endfunction

function! Testfun()
	let ttmp=expand("<cWORD>")
	let jsp_path="http://10.3.10.19:8080/sy/"
	echo ttmp
	let t2= jsp_path . ttmp
	echo t2
	let t3=system('firefox ' . t2)
	echo t3
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    map <silent> <leader>wvim :call SwitchToBuf("/media/C/Vim/Vim/_vimrc")<cr>
    map <silent> <leader>vio :call SwitchToBuf("/media/F/notes/blog/vim/13vim_skill.txt")<cr>
    map <silent> <leader>vib :call SwitchToBuf("/media/F/notes/blog/book/01.txt")<cr>
    map <silent> <leader>vik :call SwitchToBuf("/media/F/notes/blog/vim/script/vim_script_settings_of_me.txt")<cr>
    map <silent> <leader>vie :call SwitchToBuf("/media/F/notes/blog/english/e-new-words.txt")<cr>
    map <silent> <leader>vif :call SwitchToBuf("~/.vimperatorrc")<cr>
    map <silent> <leader>vir :call SwitchToBuf("/media/F/notes/blog/vim/regular-expression/regular_expressions.txt")<cr>
    map <silent> <leader>vig :call SwitchToBuf("/media/F/notes/blog/vim/regular-expression/regular_expressions_test.txt")<cr>
    map <silent> <leader>viw :call SwitchToBuf("/media/F/notes/blog/z_other/01OneThousandWrods.txt")<cr>
    map <silent> <leader>vll :call SwitchToBuf("~/.vim/log.txt")<cr>
    "Fast reloading of the .vimrc
    map <silent> <leader>vis :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>vim :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    let path="C:\Vim\Vim"
    "Fast reloading of the _vimrc
    map <silent> <leader>vis :source ~\_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>vim :call SwitchToBuf("C:/Vim/Vim/_vimrc")<cr>
    map <silent> <leader>vio :call SwitchToBuf("F:/notes/blog/vim/13vim_skill.txt")<cr>
    map <silent> <leader>vib :call SwitchToBuf("F:/notes/blog/book/01.txt")<cr>
    map <silent> <leader>vik :call SwitchToBuf("F:/notes/blog/vim/script/vim_script_settings_of_me.txt")<cr>
    map <silent> <leader>vie :call SwitchToBuf("F:/notes/blog/english/e-new-words.txt")<cr>
    map <silent> <leader>vif :call SwitchToBuf("C:/Vim/Vim/_vimperatorrc")<cr>
    map <silent> <leader>vig :call SwitchToBuf("F:/notes/blog/vim/regular-expression/regular_expressions_test.txt")<cr>
    map <silent> <leader>viw :call SwitchToBuf("F:/notes/blog/z_other/01OneThousandWrods.txt")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~\_vimrc
endif

"#############################################################################
" settings sets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c,cpp set nomodeline " @@@@@
au FileType text, txt, TXT set tw=78 fo+=Mm "选中，然后按gq就可以
autocmd BufReadPost *       " @@@@@
\ if line("°\"") > 0 && line("°\"") <= line("$") |
\ exe "normal g`\"" |
\ endif

filetype on
filetype plugin on "自动识别文件类型，自动匹配对应的文件类型Plugin.vim文件
filetype plugin indent  on "自动识别文件类型，自动匹配对应的文件类型Plugin.vim文件
set statusline=%f%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\
\ %p%%\ \ \ [%L\ lines]         "设置在状态行显示的信息

set ai
set ambiwidth=double            "字体为全角
set autochdir                   "自动切换目录
set autoindent                  "设置自动缩进
set backspace=indent,eol,start  "在插入状态使得可以用退格键和Delete键删除回车符
set backup
set backupcopy=yes              "设置备份时的行为为覆盖
set bsdir=buffer                "设定文件浏览器目录为当前目录
set cindent                     "设置为 C 语言风格的缩进模式
set cmdheight=1                 "设定命令行的行数为 1
set fileencodings=utf-8,chinese "@@@@@
set foldmethod=marker		"按缩进进行折叠
set formatoptions+=tcqroMm      "使得注释换行时自动加上前导的空格和星号
set guioptions-=L
set guioptions-=m               "去除菜单栏
set guioptions-=r               "去除右边滚动条
set guioptions-=T               "去除工具栏
set history=400                 "设置冒号命令和搜索命令的命令历史列表的长度
set hlsearch                    "搜索结果高亮度显示
set incsearch                   "输入搜索内容时就显示搜索结果
set laststatus=1                "2为显示状态栏 (默认值为 1, 无法显示状态栏)
set linespace=2                 "行间距
set matchtime=7
set mouse=a
set nobackup                    "覆盖文件时不备份
set nocompatible                "不兼容vi
set noeb
set nolinebreak                 "在单词中间断行
set novb
set nowarn
set number                      "显示行号
set ruler                       "show the cursor position all the time
set scrolloff=2                 "设定光标离窗口上下边界2行时窗口自动滚动
set showcmd                     "在状态栏显示目前所执行的指令 @@@@@
set showmatch
set smartindent
set shiftwidth=4                "设定 << 和 >> 命令移动时的宽度
set softtabstop=4               "使得按退格键时可以一次删掉 4 个空格
set tabstop=8                   "tab宽度为四个字符
"set textwidth=78 fo+=Mm         "对当前文件文字自动换行
set title                       "在标题中显示文件是否可以或已经被修改
set whichwrap=b,s,<,>,[,]       "左右前头跨行移动
syntax enable
syntax on                       "设置语法高亮

"colorscheme  candycode
"colorscheme  darkblue
colorscheme default
"colorscheme peachpuff
"colorscheme  relaxedgreen
"colors settings
"hi Normal guibg=#cfe8cc ctermfg=gray ctermbg=black
"set background=dark
set background=light
hi Normal guibg=#cfe8cc

"lcd e:/vimroot                 "设置GVIM默认目录
"set comments=://   "C/C++注释
"set comments=s1:/*,mb:*,ex0:/  "修正自动C式样注释功能 <2005/07/16>
"set confirm                    "用确认对话框弹出警告信息
"set display=lastline           "长行不能完全显示时显示当前屏幕能显示的部分
"set encoding=utf-8             "设置字符编码 @@@@@
"set expandtab                  "使用space代替tab.
"set fileformats=unix,dos       "设置保存文件格式
"set filetype=php               "设置默认文件类型
"set guifont=SimSun\ 10         "设置用于GUI图形用户界面的字体列表。
"set hidden                     "允许在有未保存的修改时切换缓冲区
"set ignorecase smartcase       "搜索忽略大小写, 但在有一个以上大写字母时仍敏感
"set list                       "显示换行符$
"set noignorecase               "不区分大小写
"set nowrap                     "允许向左右滚屏
"set vb t_vb=                   "关闭响铃
"set vb                         "出错时闪屏
"set viminfo @@@@@
"set viminfo='20,<50,s10,h
"########################## end of settings ##################################
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"#############################################################################
" use iabbrev
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"下面的命令告诉Vim你想在每次键入"ad"和空格后都自动扩展为"advertisement":
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
iabbrev inc include
iabbrev PR PROGS =
iabbrev pr PROGS =
iabbrev pro $(PROGS)
"iabbrev ob objects =
"iabbrev obj $(objects)
iabbrev //b /*************************************************************************
iabbrev //e <space>*************************************************************************/
iabbrev "b """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev "e """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev /u /usr/local/share/vim/vim72/
iabbrev plu $HOME/.vim/plugin
iabbrev doc $HOME/.vim/doc
iabbrev vimm C:\Program Files\Vim\vim72
iabbrev fil C:\Program Files\Vim\vimfiles
"######################## end of iabbrev #####################################



"#############################################################################
" use abbreviate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
abbreviate teh the
abbreviate mian main
"######################## end of abbreviate ##################################



"#############################################################################
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=============================================================================
" ctags settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap g] g]:pwd<cr>
nmap <C-T> <C-T>:pwd<cr>
set complete=.,w,b,u,t,i
"set tags=/home/liaocaiyuan/book/unpv22e/tags
set tags+=tags "最好写成+=
set tags+=./tags,./../tags,./../../tags,./../../../tags,./**/tags,tags
if MySys() == 'linux'
    au FileType c     set tags+=/home/scr/lang/cpp/minix_svn/tags
    "au FileType c,cpp set tags+=/home/scr/lang/0ctope/libc/libc/tags
    "au FileType c,cpp set tags+=/home/scr/lang/0ctope/cpp/cpp_src/tags
    "au FileType c,cpp set tags+=/home/scr/lang/0ctope/win32/winapi/tags
    "au FileType   cpp set tags+=/home/scr/lang/0ctope/win32/mfc/tags
    au FileType  java set tags+=/home/scr/lang/0ctope/java_api/src/tags
elseif MySys() == 'windows'
    au FileType c,cpp set tags+=E:\lang\cpp\cpp\cpp_src\tags "cpp_src.tar.bz2
    au FileType c,cpp set tags+=E:\lang\win32\mfc\tags
    au FileType c,cpp set tags+=E:\lang\win32\winapi\tags
    au FileType c,cpp set tags+=C:\project\orge\OgreSDK\orge_main_src\tags
    au FileType c,cpp set tags+=E:\liaocaiyuan\destop\ogre\ogre2\include\orz\tags
    au FileType c,cpp set tags+=C:\project\orge\OgreSDK\include\tags
    au FileType  java set tags+=E:\lang\java\java_api\src\tags
endif

"=============================================================================
"vimgdb settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimgdb_debug_file = ""
run macros/gdb_mappings.vim
"map <silent><leader>gdb :run macros/gdb_mappings.vim<cr>
"run C:\\Program Files\\Vim\\vim72\\macros\\gdb_mappings.vim
noremap <silent> <leader>dva 15<C-W>+
iabbrev fo follow-fork-mode
iabbrev pa parent
iabbrev ch child
"set follow-fork-mode  parent/child   "设置需跟踪的进程

"=============================================================================
"cscope settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set cscopequickfix=s-,c-,d-,i-,t-,e-
" cscope 查找的相关设置见 C:\Program Files\Vim\vimfiles\plugin\cscope_map.vim
" nmap <C-\>s      nmap <C-@>s      nmap <C-@><C-@>s
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    " s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    " g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
    " c: 查找调用本函数的函数
    " d: 查找本函数调用的函数
    " t: 查找指定的字符串
    " e: 查找egrep模式，相当于egrep功能，但查找速度快多了
    " f: 查找并打开文件，类似vim的find功能
    " i: 查找包含本文件的文件
if MySys() == 'linux'
    "cs a /home/scr/lang/0ctope/win32/mfc/cscope.out
    "cs a /home/scr/lang/0ctope/win32/winapi/cscope.out
    "cs a /home/scr/lang/0ctope/libc/libc/cscope.out
    "cs a /home/scr/lang/0ctope/java_api/src/cscope.out
elseif MySys() == 'windows'
    "cs a E:\lang\win32\mfc\cscope.out
    "cs a E:\lang\win32\winapi\cscope.out
    "cs a E:\lang\java\java_api\src\cscope.out
endif
" 显示当前的连接。
"map <silent> <leader>csh :cs show<cr>
" 重新初始化所有连接。
map <silent> <leader>cre :cs reset<cr>

"=============================================================================
"TagList settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TlistToggle_close_diCtTmp(filename, flag)
	let bufwinnr = bufwinnr(a:filename)
	if bufwinnr != -1
		"把光标焦点移到号为bufwinnr的窗口
		exec bufwinnr . "wincmd w"
		close
	endif
	if a:flag == 0
		TlistToggle
	elseif a:flag == 1
		call Mydict()
	endif
endfunction "tll
map <silent> <leader>tl :call TlistToggle_close_diCtTmp("diCtTmp", 0)<cr>
map <silent> <leader>tf  :call TlistToggle_close_diCtTmp("__Tag_List__", 1)<cr>j<C-W>h
"map <silent> <leader>tl :TlistToggle<CR>

let Tlist_Show_One_File=4
let Tlist_OnlyWindow=0
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=0 "最好设为0
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=28
let Tlist_Use_Horiz_Window=0
let Tlist_Inc_Winwidth=0  "如果启动的是vim而不是gvim, 则项必须设置为0.
let TlistShowPrototype = 50

"=============================================================================
"BufExploer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExporerDefaultHelp=0       "Do not show default help
let g:bufExporerShowRelativePath=1  "Show relative paths
let g:bufExporersortBy='mru'        "Sort by most recently used
let g:bufExporerSplitRight=0        "Split left
let g:bufExporerSplitVerTical=1     "Split vertical
let g:bufExporerSplitVerTSize=25    "Split width
let g:bufExporerUseCurrentWindow=1  "Open in new window
map <silent> <leader>hb :HSBufExplorer<cr>

"=============================================================================
"MiniBufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mbt mbe mbc mbu
"map <silent> <leader>mbc ,mbe:q!<cr>

"=============================================================================
"WinManager 功能:控制各插件的窗口布局
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout="BufExplorer|TagList"
let g:winManagerWindowLayout='FileExplorer|BufExplorer'
let g:persistentBehaviour=0		"只剩一个窗口时, 退出vim.
let g:winManagerWidth=26
let g:defaultExplorer=1
nmap <silent> <leader>fir :FirstExplorerWindow<cr>
nmap <silent> <leader>bot :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>

"=============================================================================
" c.vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == 'linux'
    let g:C_GlobalTemplateFile =
\   "/usr/local/share/vim/vimfiles/c-support/templates/Templates"
elseif MySys() == 'windows'
    let g:C_GlobalTemplateFile =
\   "C:\\vim\\Vim\\vimfiles\\c-support\\templates\\Templates"
endif
let g:C_Ctrl_j = "on"
"
"  g:C_CodeSnippets           plugin_dir."/c-support/codesnippets/"
"  g:C_Dictionary_File        ""
"  g:C_LoadMenus              "yes"
"  g:C_MenuHeader             "yes"
"  g:C_OutputGvim             "vim"
"  g:C_XtermDefaults          "-fa courier -fs 12 -geometry 80x24"
"  g:C_Printheader            "%<%f%h%m%<  %=%{strftime('%x %X')}     Page %N"
"  g:C_MapLeader              '\'
"
"  Linux/UNIX:
"   g:C_ObjExtension          ".o"
"   g:C_ExeExtension          ""
"   g:C_CCompiler             "gcc"
"   g:C_CplusCompiler         "g++"
"   g:C_Man                   "man"
"  Windows:
"   g:C_ObjExtension          ".obj"
"   g:C_ExeExtension          ".exe"
"   g:C_CCompiler             "gcc.exe"
"   g:C_CplusCompiler         "g++.exe"
"   g:C_Man                   "man.exe"
"  g:C_CFlags                 "-Wall -g -O0 -c"
"  g:C_LFlags                 "-Wall -g -O0"
"  g:C_Libs                   "-lm"
"  g:C_LineEndCommColDefault  49
"  g:C_CExtension             "c"
"  g:C_TypeOfH                "cpp"
"  g:C_SourceCodeExtensions   "c cc cp cxx cpp CPP c++ C i ii"
"
"  g:C_CodeCheckExeName       "check"
"  g:C_CodeCheckOptions       "-K13"

"=============================================================================
" omnicppcomplete.vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"整行补全                        CTRL-X CTRL-L
"根据当前文件里关键字补全        CTRL-X CTRL-N
"根据字典补全                    CTRL-X CTRL-K
"根据同义词字典补全              CTRL-X CTRL-T
"根据头文件内关键字补全          CTRL-X CTRL-I
"根据标签补全                    CTRL-X CTRL-]
"补全文件名                      CTRL-X CTRL-F
"补全宏定义                      CTRL-X CTRL-D
"补全vim命令                     CTRL-X CTRL-V
"用户自定义补全方式              CTRL-X CTRL-U
"拼写建议                        CTRL-X CTRL-S
set completeopt=longest
" CTRL-X CTRL-O 全能补全, 用"CTRL-E"停止补全并回到原来录入的文字。用"CTRL-Y"可
" 以停止补全，并接受当前所选的项目
"map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"map <F11> :!ctags -R <CR>
" 下一行不起作用, 为什么呢?????
"inoremap <C-D> <C-X><C-F>
"inoremap <expr> <C-J>    pumvisible() ? "\<PageDown>\<C-N>\<C-P>" : "\<C-X><C-O>"
"inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
"inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
"inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowPrototypeInAbbr = 0 " 1: 显示函数签名
let OmniCpp_ShowAccess = 1 " 是否显示属性
let OmniCpp_MayCompleteScope = 0 " ::后是否弹出
let OmniCpp_ShowScopeInAbbr = 0 " 1: 作用域 类名/函数名;  0: 相反
"0 = don't select first popup item
"1 = select first popup item (inserting it to the text)
"2 = select first popup item (without inserting it to the text)
let OmniCpp_SelectFirstItem = 2
"0 = use standard vim search function
"1 = use local search function
let OmniCpp_LocalSearchDecl = 1

"=============================================================================
" DoxygenToolkit.vim 文档工具
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 全部的命令和对应的解释:
" Dox                       Function / class comment
" DoxLic                    License
" DoxAuthor                 DoxAuthor
" DoxBlock                  Group
" DoxUndoc(DEBUG) !         Ignore code fragment
let g:DoxygenToolkit_commentType = "C"
let g:DoxygenToolkit_briefTag_pre="@Description:  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns:   "
let g:DoxygenToolkit_blockHeader="************************************************************************"
let g:DoxygenToolkit_blockFooter="************************************************************************"
let g:DoxygenToolkit_authorName="nuoerll (nuoliu), lcy3636@126.com"
let g:DoxygenToolkit_licenseTag="Reserve"
"nmap <silent> <leader>dox :Dox<cr><esc>mzkddk3lvf/r*f<space>D0%ddr*wh.f<space>D`za
"nmap <silent> <leader>dox :Dox<cr><esc>mzkddk2lvf/r=xxf<space>D0%ddr*llvf/hhr=f<space>D`za
nmap <silent> <leader>dox :Dox<cr><esc>mzkddk2lvf/r=xf<space>Dr*0%hmxl
\<C-E>%lr*hj<C-E>`xjr<space>`xjllvf/hr=f<space>Dhr*`za<C-W>:<Tab>

"=============================================================================
" winmove.vim	settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wm_move_x = 85
let g:wm_move_y = 20

"=============================================================================
" a.vim	settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>ihh :IH<cr>
nmap <silent> <leader>ihs :IHS<cr>
nmap <silent> <leader>ihv :IHV<cr>
"	a.vim主要命令如下:
"		:A switches to the header file corresponding to the current file being edited (or vise versa)
"		:AS splits and switches
"		:AV vertical splits and switches
"		:AT new tab and switches
"		:AN cycles through matches
"		:IH switches to file under cursor
"		:IHS splits and switches
"		:IHV vertical splits and switches
"		:IHT new tab and switches
"		:IHN cycles through matches
"		<Leader>ih switches to file under cursor
"		<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
"		<Leader>ihn cycles through matches

"=============================================================================
" VisualMark.vim插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VisualMark.vim插件主要命令如下:
		" 1.  For gvim, use "Ctrl + F2" to toggle a visual mark.
		"     For both vim and gvim, use "mm" to toggle a visual mark.
		" 2.  Use "F2" to navigate through the visual marks forward in the file.
		" 3.  Use "Shift + F2" to navigate backwards.
" 对应VisualMark中的设置如下:
	"  map <unique> <c-F2> <Plug>Vm_toggle_sign
	"  map <silent> <unique> mm <Plug>Vm_toggle_sign
	"  map <unique> <F2> <Plug>Vm_goto_next_sign
	"  map <unique> <s-F2> <Plug>Vm_goto_prev_sign

"=============================================================================
" Mark.vim插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mark.vim中的设置如下:
    "nmap <unique> <silent> <leader>m <Plug>MarkSet " mark or unmark the word
"under (or before) the cursor
    "nmap <unique> <silent> <leader>r <Plug>MarkRegex  "manually input a
"regular expression. 用于搜索.
    "nmap <unique> <silent> <leader>c <Plug>MarkClear " clear this mark (i.e.
"the mark under the cursor), or clear all highlighted marks .
	"nnoremap <silent> <leader>* :call <sid>SearchCurrentMark()<cr>
	"nnoremap <silent> <leader># :call <sid>SearchCurrentMark("b")<cr>
	"nnoremap <silent> <leader>/ :call <sid>SearchAnyMark()<cr>
	"nnoremap <silent> <leader>? :call <sid>SearchAnyMark("b")<cr>
	"nnoremap <silent> * :if !<sid>SearchNext()<bar>execute "norm! *"<bar>endif<cr>
	"nnoremap <silent> # :if !<sid>SearchNext("b")<bar>execute "norm! #"<bar>endif<cr>
	"command! -nargs=? Mark call s:DoMark(<f-args>)

"=============================================================================
" code_complete.vim插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab           " 生成参数提示信息
" Ctar + j      " 跳到下一个参数处

"=============================================================================
" pyclewn settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"C-B : break "${fname}":${lnum} # set breakpoint at current line
"C-D : down
"C-E : clear "${fname}":${lnum} # clear breakpoint at current line
"C-N : next
"C-P : print ${text}            # print value of selection at mouse position
"C-U : up
"C-X : print *${text}           # print value referenced by word at mouse position
"C-Z : sigint                   # kill the inferior running program
"S-A : info args
"S-B : info breakpoints
"S-C : continue
"S-F : finish
"S-L : info locals
"S-Q : quit
"S-R : run
"S-S : step
"S-W : where
"S-X : foldvar ${lnum}          # expand/collapse a watched variable
map <silent> <leader>exl :C target exec Example.exe<CR>
map <silent> <leader>efl :C file Example.exe <CR>
"nmap <silent> <C-B> :call <SID>Breakpoint("break")<CR>
":map <F8> :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>
"map <F7> :exe "Cbreak " expand("%") ":" . line(".")<CR>
map <F8> :exe "Cclear " expand("%") ":" . line(".")<CR>
map <F9> :exe "C p " expand("<cword>") <CR>
map <F10> :exe "C p " expand("<cWORD>") <CR>
"map <F11> :exe "Cfoldvar " . line(".")<CR>
map <silent> <leader>eib :exe "C info breakpoints"<CR>
map <silent> <leader>efn :exe "C finish"<CR>
map <silent> <leader>eru :exe "C run"<CR>
map <silent> <leader>ede :C delete
map <silent> <leader>efi :C file
map <silent> <leader>eex :C target exec
map <silent> <leader><space><space> q:
"vnoremap <C-N> :exe "C n"<CR> alt
nmap <silent> <C-N> :exe "C n"<CR>
"nmap <silent> <C-S> :exe "C s"<CR>
nmap <silent> <C-C> :exe "C c"<CR>
nmap <silent> <leader>ezo :exe "Cfoldvar " . line(".")<CR>

"=============================================================================
" project.vim   project.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>pr :Project Project<CR> zR
" 切换打开和关闭project窗口
nmap <silent> <Leader>P <Plug>ToggleProject
"插件项目窗口宽度.    默认值: 24
let g:proj_window_width=24
"当按空格键<space>或者单击鼠标左键<LeftMouse>时项目窗口宽度增加量,默认值:100
let g:proj_window_increment=90
let g:proj_flags='i'    "当选择打开一个文件时会在命令行显示文件名和当前工作路径.
"在常规模式下开启 |CTRL-W_o| 和 |CTRL-W_CTRL_O| 映射, 使得当前缓冲区成为唯一可
"见的缓冲区, 但是项目窗口仍然可见.
let g:proj_flags='m'
let g:proj_flags='t'    "用按 <space> 进行窗口加宽.
let g:proj_flags='F'   "显示浮动项目窗口. 关闭窗口的自动调整大小和窗口替换.
let g:proj_flags='L'    "自动根据CD设置切换目录.
"let g:proj_flags='n'    "显示行号.
let g:proj_flags='T'    "子项目的折叠在更新时会紧跟在当前折叠下方显示(而不是其底部).
let g:proj_flags='v'    "设置后将, 按 \G 搜索时用 :vimgrep 取代 :grep.
let g:proj_flags='c'    "设置后, 在项目窗口中打开文件后会自动关闭项目窗口.
let g:proj_flags='S'    "启用排序.
let g:proj_flags='s'    "开启语法高亮.
"let g:proj_run1='!p4 edit %f'      "g:proj_run1 ...  g:proj_run9 用法.
let g:proj_run3='silent !gvim %f'
"let g:proj_run4="echo 'Viewing %f'|sil !xterm -e less %f & & pause"
"
"MAPPINGS                            *project-mappings*
""映射                        动作 ~
"\r        根据过滤符更新光标处的项目.如果在一行最后使用了"#pragmakeep"(不含
           "双引号),那么该行将保留,
"\R        递归执行\r.
"\c        创建一个项目.对于使用|netrw|浏览的项目不适用.
"\C        为目录及其子目录下的文件递归创建一个项目.
"<Return>  在前一窗口或者另外一个新窗口中打开光标处的文件.如果光标位于折叠上
"<space>   按此键扩大或缩小浏览界面.
"<S-Return>
"\s        跟<Return>一样,但会水平分割目标窗口.
"\S        加载所有文件到当前窗口,当前窗口会被水平分割显示所有文件.
"<C-Return>
"\o        同<Return>在一个窗口中打开当前文件,同时关闭其他所有打开的窗口.
"<M-Return>
"\v        同<Return>仅仅显示文件内容,而光标依然停留在项目窗口中.
"<CTRL-Up>
"\<Up>     移动文本或者折叠到当前光标的上一行.在有的终端中可能无法识别此绑定而失效
"<CTRL-Down>
"\<Down>
"          移动文本或者折叠到当前光标的下一行.在有的终端中可能无法识别此绑定而失效
"\i        在状态栏中显示光标所在折叠完全解析和继承的参数.
"\I        在状态栏显示光标下文件名的全名(含路径).此功能是插件调用
"\l        加载当前项目中的所有文件到Vim中,在加载过程中按任何键可以停止加载.
"\w        删除当前项目层次中的所有文件.(并非真正删除文件,只针对该项目组织而言.
"\W        删除当前项目层及其子层次中的所有文件.(并非真正删除文件,只针对该项目组
"\g        搜索当前项目层所有文件.
"
"# pragma keep     "如果在一行最后使用了 # pragma keep, 那么该行将保留, 不会被
"在更新时被删除.
"change the Project File, do a :bwipe in the Project Buffer, then re-invoke.

"=============================================================================
"NERD_tree.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let loaded_nerd_tree=1    " 禁用所有与NERD_tree有关的命令
nmap <silent> <leader>tto :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.vm$', '\~$']    " 不显示指定的类型的文件
let NERDTreeShowHidden=0    " 不显示隐藏文件(好像只在linux环境中有效)
let NERDTreeSortOrder=['\/$','\.cpp$','\.c$', '\.h$','\.java','.class','*']    " 排序
let NERDTreeCaseSensitiveSort=0     " 不分大小写排序
let NERDTreeWinSize=23
" let NERDTreeShowLineNumbers=1
let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=0    " 1: 打开文件后, 关闭NERDTrre窗口
" let NERDTreeHighlightCursorline=1     " 高亮NERDTrre窗口的当前行
" nmap <silent> <leader>tmk :Bookmark expand("<cword>")<cr>  "

"=============================================================================
" NERD_commenter.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ccc ,cc<cr>k
imap <silent> <leader>ccc /*<esc>a
map <silent> <leader>cca ,ca<cr>k
map <silent> <leader>ccs mz:.,.s/ //g<cr>/<Up><Up><cr>`z
vnoremap <silent> <leader>scs :s/ //g<cr>
vmap <silent> <leader>ct :s/\( .*$\)/ (\^\1\^)<cr>
"map <silent> <leader>ct $F!,c$<cr>k$F!x
map <silent> <leader>ct $F<space>l,c$<cr>k$2F<space>l
map <silent> <leader>cis :source $VIM/vimfiles/syntax/txt.vim<cr>
"map <silent> <leader>cqt qa,ctjq10@a
"map <F2> $F<space>l,c$<cr>k
"let NERD_java_alt_style=1
" Default mapping: [count],cc   " 以行为单位进行注释.
" ,c<space>     " comment <--> uncomment.
" ,cm           " 以段作为单位进行注释.
" ,cs           " 简洁美观式注释.
" ,cy           " Same as ,cc except that the commented line(s) are yanked first.
" ,c$           " 注释当前光标到行未的内容.
" ,cA           " 在行尾进行手动输入注释内容.
" ,ca           " 切换注释方式(/**/ <--> //).
" ,cl           " Same cc, 并且左对齐.
" ,cb           " Same cc, 并且两端对齐.
" ,cu           " Uncomments the selected line(s).
"

"=============================================================================
" sketch.vim   用鼠标作画
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>stc :call ToggleSketch()<CR>

"=============================================================================
" javacomplete.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au FileType java imap <silent> <leader>. :<C-X> <C-O>
setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

"=============================================================================
" Calendar.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <silent> <leader>cal :Calendar<cr>
map <silent> <leader>cah :CalendarH<cr>

"=============================================================================
" JumpInCode_Plus.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader>jc  Generate tags and cscope database from current directory to :
                 "CurrentDirectory/OutDB/cscope.out,tags
" <leader>jst       list existed tags full name and choose tags
" <leader>jsc      list existed cscope database full name and choose cscope.out
" 显示已连接的数据库
map <silent> <leader>jlt :set tags<cr>
map <silent> <leader>jlc :cs show<cr>

"=============================================================================
" txtbrowser.zip
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"plain text brower(show the document map and syntax highlight in plain text)
"help txt-keywords
"以空格打头, 后跟关键字"figure"的行定义为"文本图",该行将被列在taglist窗口中.
"以空格打头, 后跟关键字"table"的行定义为"文本表",该行将被列在taglist窗口中.
map <silent> <leader>bft :set ft=txt<cr>
"<Leader>g / TxtBrowserUrl		"打开URL
"<Leader>f / TxtBrowserWord		"查单词
"<Leader>s / TxtBrowserSearch	"search word under cursor
map <silent> <leader>bgu :TxtBrowserUrl<cr>
map <silent> <leader>bgw :TxtBrowserWord<cr>
map <silent> <leader>bgs :TxtBrowserSearch<cr>
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
let TxtBrowser_Dict_Url='http://dict.cn/text'	"英文词典
let Txtbrowser_Search_Engine='http://www.baidu.com/s?wd=text&oq=text&f=3&rsp=2'
au BufRead,BufNewFile *.txt setlocal ft=txt "syntax highlight txt for txt.vim
"au BufRead,BufNewFile *.log setlocal ft=txt "syntax highlight log for txt.vim
au BufRead,BufNewFile *log setlocal ft=txt "syntax highlight log for txt.vim

"=============================================================================
" ZoomWin.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Press <c-w>o : the current window zooms into a full screen
" Press <c-w>o again: the previous set of windows is restored

"=============================================================================
" FindMate.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快速查找文件
" You can launch FindMate by typing:
"       ,, File_name
" Or
"       :FindMate File_name
" The shortcut can be redefined by using:
"       map your_shortcut   <Plug>FindMate
" In your .vimrc file

"=============================================================================
" grep.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"=============================================================================
" DrawIt.vba.gz
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " :help DrawIt
    " ,di	  to start DrawIt and
    " ,ds	  to stop  DrawIt.
    "<left>       move and draw left
    "<right>      move and draw right, inserting lines/space as needed
    "<up>         move and draw up, inserting lines/space as needed
    "<down>       move and draw down, inserting lines/space as needed

"=============================================================================
" vimdiff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置其是否同时滚动
map <silent> <leader>sc :set scrollbind<cr>
map <silent> <leader>nsc :set noscrollbind<cr>
"vimdiff文件比较,定位到文件不同处, <向前, 向后>
map <silent> <leader>w ]c<cr>
map <silent> <leader>s [c<cr>

"=============================================================================
" quickfix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"对于quickfix(gcc make),经常用到的命令，定义映射
autocmd FileType c,cpp,h map <buffer> <leader><space> :w<cr>:make<cr>:cw 10<cr>:cn<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr> :cn<cr>
"######################## end of plugins #####################################



"#############################################################################
" 项目相关设置 pj
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=./**

":cd src                            "切换到/home/easwy/src/vim70/src目录
":set sessionoptions-=curdir        "在session option中去掉curdir
":set sessionoptions+=sesdir        "在session option中加入sesdir
":mksession vim70.vim               "创建一个会话文件
":wviminfo vim70.viminfo            "创建一个viminfo文件
":qa                                "退出vim

"在vim载入会话文件的最后一步, 它会查找一个额外的文件(*x.vim)并执行其中的ex命令.
"然后再编辑一个名为~/src/vim70/vim70x.vim (*x.vim) 的文件，文件的内容为:
""set project path
"set path+=~/src/vim70/**

"退出vim后，在命令行下执行gvim &，再次进入vim，这时看到的是一个空白窗口。然后执行下面的命令：
":source ~/src/vim70/src/vim70.vim  '载入会话文件
":rviminfo vim70.viminfo            '读入viminfo文件


" execute project related configuration in current directory
if filereadable("workspace.vim")
    source workspace.vim
endif
if filereadable("vim72_wp.vim")
   source vim72_wsp.vim
endif



"#############################################################################
"maps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for jsp jsps
map <silent> <leader>utf mz:%s/GB2312/UTF-8/gi<cr>`z
map <silent> <leader>b23 mz:%s/utf-8/GB2312/gi<cr>`z
map <silent> <leader>sps gg0:w <C-R><C-W>.jsp<cr>,cccjfGcwutf-8<esc>
map <silent> <leader>sfj mzgg0W :call Firefox_jsp()<cr>`z

" for shell-script
map <silent> <leader>ssa gg/^$<cr>qz"apjjf"mzggjlv$hy*`zpjqi
map <silent> <leader>ssb gg/^$<cr>qz"bpjjf"mzggjlv$hy*`zpjqi
map <silent> <leader>sss gg/#!<cr>h<C-E>G0dkddkddpi#<esc>

map <silent> <leader>d2s mz:%s/，/, /ge<cr>:%s/。/. /ge<cr>:%s/；/; /ge<cr>
\:%s/：/: /ge<cr>:%s/　/  /ge<cr>:%s/“/"/ge<cr>:%s/”/"/ge<cr>:%s/？/?/ge<cr>
\:%s/！/!/ge<cr>:%s/、/,/ge<cr>:%s/）/)/ge<cr>:%s/（/(/ge<cr>:%s/…/.../ge<cr>
\:%s/＝/=/ge<cr>:%s/／/\//ge<cr>:%s/＊/\*/ge<cr>:%s/—/-/ge<cr>:%s/＃/#/ge<cr>
\:%s/１/1/ge<cr>:%s/２/2/ge<cr>:%s/－/-/ge<cr>:%s/―/-/ge<cr>
\`z
":%s/―/--/ge<cr>
map <silent> <leader>s2t :%s/	/    /g<cr>
map <silent> <leader>pwd :pwd<cr>
map <silent> <leader>y mz:r!cat /tmp/pwd2vim.tmp<cr>0vEd`zi <esc>Pjdd`zf<Space>x
map <F3> :tabclose<CR>
map <F4> :tabnew<CR>
map <F5> :tabprevious<CR>
map <F6> :tabnext<CR>
"-------------------------窗口相关--------------------------------------------
"改变窗口高度, 宽度
noremap <silent> <leader>wi 10<C-W>+
noremap <silent> <leader>wd 10<C-W>-
noremap <silent> <leader>vwi 18<C-W>>
noremap <silent> <leader>vwd 18<C-W><
"移动窗口位置
noremap <silent> <leader>mr <C-W>R
noremap <silent> <leader>mh <C-W>H
noremap <silent> <leader>mk <C-W>K
noremap <silent> <leader>mj <C-W>J
noremap <silent> <leader>ml <C-W>L
"平分所有窗口大小
noremap <silent> <leader>mq <C-W>=
"在窗口间移动鼠标焦点
noremap <silent> <leader>sh <C-W>h
noremap <silent> <leader>sk <C-W>k
noremap <silent> <leader>sj <C-W>j
noremap <silent> <leader>sl <C-W>l
map <silent> <leader>nww :split<cr>
noremap <C-Q>		:close<cr>
" 当只剩下一个窗口时, 不能关闭
map <silent> <leader>clo :close<cr>
"only retain one splip window
map <silent> <leader>onl :only<cr>
"打开一个新窗口
map <silent> <leader>new :new<cr>
"垂直分割窗口
map <silent> <leader>vnw :vsplit<cr>
map <silent> <leader>vne :vnew<cr>
"-------------------------end of 窗口相关---------------------------------
map <silent> <leader>afg A @@@@@<esc>
map <silent> <leader>dfg $bhde<esc>
" 从光标所在的行开始, 对下一个空行间的所有行进行排序
map <silent> <leader>sfl :.,/^$/-1!sort<cr>
map <silent> <leader>sor :!sort<cr>
" 把选中区域中的空行删除掉
map <silent> <leader>dsp mz:g/^$/d<cr>`z
" 删除选中区域中行末空格
map <silent> <leader>dep mz:%s/  *$//g<cr>`z
" 加上行号
map <silent> <leader>anu :%s/^/\=line(".")." "/g<cr>
" 字符数
map <silent> <leader>coc :%s/./&/gn<cr>
" 单词数
map <silent> <leader>cow :%s/\i\+/&/gn<cr>
" 行数
map <silent> <leader>col :%s/^//n<cr>
" 统计光标下单词在文中出现的次数
map <silent> <leader>cos mz:%s/\<<C-R><C-W>\>/&/gn<cr>`z
map <silent> <leader>cos mz:%s/<C-R><C-W>/&/gn<cr>`z
" \ ==> /
map <silent> <leader>tof V:s/\\/\//g<cr>
" source $VIMRUNTIME/syntax/2html.vim
map <silent> <leader>v2h :source $VIMRUNTIME/syntax/2html.vim<cr>
" write date under cursor
map <silent> <leader>dte :r ! date<cr>I(<Esc>A)<Esc>o<Esc>i#<esc>77a=<Esc>0
"给某个单词加上()
map <silent> <leader>eas i(<Esc>ea)<Esc>
map <silent> <leader>eam i[<Esc>ea]<Esc>
map <silent> <leader>eab i{<Esc>ea}<Esc>
map <silent> <leader>bas i(<Esc>$a)<Esc>
map <silent> <leader>bam i[<Esc>$a]<Esc>
map <silent> <leader>bab i{<Esc>$a}<Esc>
map <silent> <leader>g %
map <silent> <leader>hh [[
map Q gq
map <silent> <leader>lhd o<Esc>I#ifdef  _NAL_HDEBUG_<Esc>o#else<Esc>o#endif
"In order to use "p" in visual mordel
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
"中文也可以达78个字符时自动换行
map <silent> <leader>sfo :set fo+=Mm<cr>
map <silent> <leader>q :set noai<cr>:set fo+=Mm<cr>Vgq:set ai<cr>
inoremap <C-U> <C-G>u<C-U>
"########################end of map##########################################



"#############################################################################
" some settings for windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x
" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP
cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+
" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>
" Use CTRL-E to do what CTRL-V used to do
"选中块
noremap <C-E>		<C-V>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>
" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif
" CTRL-Z is Undo; not in cmdline though
"noremap <C-Z> u
"inoremap <C-Z> <C-O>u
" CTRL-Y is Redo (although not repeat); not in cmdline though
"noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>
" Alt-Space is System menu
if has("gui")
    noremap <M-Space> :simalt ~<CR>
    inoremap <M-Space> <C-O>:simalt ~<CR>
    cnoremap <M-Space> <C-C>:simalt ~<CR>
endif
"对光标下的数字增1
noremap <M-C-A> <C-A>
"对光标下的数字减1
noremap <M-C-X> <C-X>
" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w
" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c
" restore 'cpoptions'
"set cpo&
"if 1
"  let &cpoptions = s:save_cpo
"  unlet s:save_cpo
"endif
"######################## end of windows settings ############################




"#############################################################################
" notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"*Q_fo*		Folding
"Q_re
"i_CTRL-R
"-----------------------------------------------------------------------------
"|:dig|	   :dig[raphs]		show current list of digraphs
"|i_CTRL-K|	CTRL-K {char1} {char2}
"-----------------------------------------------------------------------------
"|:r!|	   :r! {command}   insert the standard output of {command} below the cursor
"-----------------------------------------------------------------------------
"|quote|	  "{char}	use register {char} for the next delete, yank, or put
"-----------------------------------------------------------------------------
"   "ay     "ap
"-----------------------------------------------------------------------------
"|:ce|	  :[range]ce[nter] [width]      center the lines in [range]
"|:le|	  :[range]le[ft] [indent]       left-align the lines in [range] (with [indent])
"|:ri|	  :[range]ri[ght] [width]       right-align the lines in [range]
"-----------------------------------------------------------------------------
"|&|	      &		Repeat previous ":s" on current line without options
"-----------------------------------------------------------------------------
"Q_to
"|v_a'|	   N  a'	Select "a single quoted string"
"|v_i'|	   N  i'	Select "inner single quoted string"
"|v_aquote| N  a"	Select "a double quoted string"
"|v_iquote| N  i"	Select "inner double quoted string"
"|v_a`|	   N  a`	Select "a backward quoted string"
"|v_i`|	   N  i`	Select "inner backward quoted string"
"-----------------------------------------------------------------------------
"|ga|		   ga		show ascii value of character under cursor in decimal, hex, and octal
"|g8|		   g8		for utf-8 encoding: show byte sequence for character under cursor in hex.
"-----------------------------------------------------------------------------
"|ZZ|	     ZZ			Same as ":x".
"|ZQ|	     ZQ			Same as ":q!".
"|:stop|	  :st[op][!]		Suspend VIM or start new shell.  If 'aw' option
"|CTRL-Z|     CTRL-Z		Same as ":stop"
"-----------------------------------------------------------------------------
"|CTRL-W_]|	CTRL-W ]		Split window and jump to tag under cursor
"|CTRL-W_f|	CTRL-W f		Split window and edit file name under the cursor
"|CTRL-W_^|	CTRL-W ^		Split window and edit alternate file
"|CTRL-W_n|	CTRL-W n  or  :new	Create new empty window
"|CTRL-W_q|	CTRL-W q  or  :q[uit]	Quit editing and close window
"|CTRL-W_c|	CTRL-W c  or  :cl[ose]	Make buffer hidden and close window
"|CTRL-W_o|	CTRL-W o  or  :on[ly]	Make current window only one on the screen
"|CTRL-W_j|	CTRL-W j		Move cursor to window below
"|CTRL-W_k|	CTRL-W k		Move cursor to window above
"|CTRL-W_CTRL-W|	CTRL-W CTRL-W		Move cursor to window below (wrap)
"|CTRL-W_W|	CTRL-W W		Move cursor to window above (wrap)
"|CTRL-W_t|	CTRL-W t		Move cursor to top window
"|CTRL-W_b|	CTRL-W b		Move cursor to bottom window
"|CTRL-W_p|	CTRL-W p		Move cursor to previous active window
"|CTRL-W_r|	CTRL-W r		Rotate windows downwards
"|CTRL-W_R|	CTRL-W R		Rotate windows upwards
"|CTRL-W_x|	CTRL-W x		Exchange current window with next one
"|CTRL-W_=|	CTRL-W =		Make all windows equal height
"|CTRL-W_-|	CTRL-W -		Decrease current window height
"|CTRL-W_+|	CTRL-W +		Increase current window height
"|CTRL-W__|	CTRL-W _		Set current window height (default:
"-----------------------------------------------------------------------------
"C-W    C-U     C-E     C-U
"-----------------------------------------------------------------------------
"命令 CTRL-R {register} 插入寄存器里的内容。它的用处是让你不必键入长词。例如，
"-----------------------------------------------------------------------------
" 编辑二进制文件
" vim -b file     %!xxd 切换为十六进制
"-----------------------------------------------------------------------------
" 把當前文件復制一份, 其後綴名為A.txt
"map <silent> <leader>no :A.txt<esc>
"-----------------------------------------------------------------------------
" 大小写转换
" gu gU
" guW guw  对应一词
" guE gue  对应一词
" guU guu  对应一行
" gggUG gggug  对应一个文件
"-----------------------------------------------------------------------------
"实现用vim自动输入一个数字序列的命令:
"	 i2.<esc>
"	 qa
"	 yyp<C-a>q
"	 98@a
"-----------------------------------------------------------------------------
"双击m键可以删除Win下生成的多余换行符CR（在Vim中可以看到蓝色的^M）
"nmap mm :%s/\r//g<cr>
"-----------------------------------------------------------------------------
"双击t键实现对在起点下载的TXT文本进行排版并删除里面多余的广告等
"nmap tt :%s/^\([\s　]\+\)/    /g<cr>:%s/^更新时间.*\d$//g<cr>:%s/<a href.*<\/a>$//g<cr>:%s/\([\s　]*\n\)\+/\r\r/<cr>
"-----------------------------------------------------------------------------
"vimgrep 的使用
":cd ~/src/vim70
":vimgrep /\<main\>/ src/*.c
":cw
"-----------------------------------------------------------------------------
":Explore"等Ex命令来打开文件浏览器
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"######################## end of notes #######################################
"
"set sessionoptions+=slash
