" Vim syntax file
" Language: Markdown
" Maintainer: Ben Williams <benw@plasticboy.com>
" URL: http://plasticboy.com/markdown-vim-mode/
" Version: 9
" Last Change: 2009 May 18
" Remark: Uses HTML syntax file
" Remark: I don't do anything with angle brackets (<>) because that would too easily
" easily conflict with HTML syntax
" TODO: Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlItalic start="\\\@<!\*\S\@=" end="\S\@<=\\\@<!\*" keepend oneline
syn region htmlItalic start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@=" keepend oneline
syn region htmlBold start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" keepend oneline
syn region htmlBold start="\S\@<=__\|__\S\@=" end="\S\@<=__\|__\S\@=" keepend oneline
syn region htmlBoldItalic start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" keepend oneline
syn region htmlBoldItalic start="\S\@<=___\|___\S\@=" end="\S\@<=___\|___\S\@=" keepend oneline

" [link](URL) | [link][id] | [link][]
syn region mkdFootnotes matchgroup=mkdDelimiter start="\[^" end="\]"
syn region mkdID matchgroup=mkdDelimiter start="\[" end="\]" contained oneline
syn region mkdURL matchgroup=mkdDelimiter start="(" end=")" contained oneline
syn region mkdLink matchgroup=mkdDelimiter start="\\\@<!\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURL,mkdID skipwhite oneline
" mkd inline links: protocol optional user:pass@ sub/domain .com, .co.uk, etc optional port path/querystring/hash fragment
" ------------ _____________________ --------------------------- ________________________ ----------------- __
syntax match mkdInlineURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

" Link definitions: [id]: URL (Optional Title)
" TODO handle automatic links without colliding with htmlTag (<URL>)
syn region mkdLinkDef matchgroup=mkdDelimiter start="^ \{,3}\zs\[" end="]:" oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]" contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+"+ end=+"+ contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+'+ end=+'+ contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+(+ end=+)+ contained

"define Markdown groups
syn match mkdLineContinue ".$"
syn match mkdLineBreak / \+$/
syn region mkdBlockquote start=/^\s*>/ end=/$/ contains=mkdLineBreak,mkdLineContinue,@Spell,txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn region mkdCode start=/\(\([^\\]\|^\)\\\)\@<!`/ end=/\(\([^\\]\|^\)\\\)\@<!`/  contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn region mkdCode start=/\s*``[^`]*/ end=/[^`]*``\s*/  contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn region mkdCode start=/^```\s*\w*\s*$/ end=/^```\s*$/  contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn region mkdCode start="<pre[^>]*>" end="</pre>"  contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn region mkdCode start="<code[^>]*>" end="</code>"  contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn match mkdCode /^\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/ contains=txtApostrophe,txtQuotes,txtUrl,txtEmailMsg,txtComment,txtBrackets
syn match mkdListItem "^\s*[-*+]\s\+"
syn match mkdListItem "^\s*\d\+\.\s\+"
syn match mkdRule /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match mkdRule /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match mkdRule /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match mkdRule /^\s*-\{3,}$/
syn match mkdRule /^\s*\*\{3,5}$/

"HTML headings
syn region htmlH1 start="^\s*#" end="\($\|#\+\)" contains=@Spell
syn region htmlH2 start="^\s*##" end="\($\|#\+\)" contains=@Spell
syn region htmlH3 start="^\s*###" end="\($\|#\+\)" contains=@Spell
syn region htmlH4 start="^\s*####" end="\($\|#\+\)" contains=@Spell
syn region htmlH5 start="^\s*#####" end="\($\|#\+\)" contains=@Spell
syn region htmlH6 start="^\s*######" end="\($\|#\+\)" contains=@Spell
syn match htmlH1 /^.\+\n=\+$/ contains=@Spell
syn match htmlH2 /^.\+\n-\+$/ contains=@Spell

"txtApostrophe: text in the apostrophe
"单引号内文字
syn match   txtApostrophe  '\'[^\']\+\''hs=s+1,he=e-1

"txtQuotes: text in the quotoes
"双引号内文字, 包括全角半角, 作用范围最多两行
syn match   txtQuotes     '["“][^"”]\+\(\n\)\=[^"”]*["”]'hs=s+1,he=e-1

"txtParentesis: text in the parentesis
"括号内文字, 不在行首(为了和txtList区别), 作用范围最多两行
syn match   txtParentesis "[(（][^)）]\+\(\n\)\=[^)）]*[)）]" contains=txtUrl

"txtBrackets: text in the brackets
"其它括号内文字, 作用范围最多两行, 大括号无行数限制
"syn match txtBrackets     '<[^<]\+\(\n\)\=[^<]*>'hs=s+1,he=e-1 contains=txtUrl
syn match txtBrackets     '\[[^\[]\+\(\n\)\=[^\[]*\]'hs=s+1,he=e-1 contains=txtUrl

"link url
syn match txtUrl '\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\{2,4}\>\(?[A-Za-z0-9%&=+.,@*_-]\+\)\='
syn match txtUrl   '\<\(\(https\=\|file\|ftp\|news\|telnet\|gopher\|wais\)://\([A-Za-z0-9._-]\+\(:[^ @]*\)\=@\)\=\|\(www[23]\=\.\|ftp\.\)\)[A-Za-z0-9%._/~:,=$@-]\+\>/*\(?[A-Za-z0-9/%&=+.,@*_-]\+\)\=\(#[A-Za-z0-9%._-]\+\)\='

"email text:
syn match txtEmailMsg '^\s*\(From\|De\|Sent\|To\|Para\|Date\|Data\|Assunto\|Subject\):.*'

syn match  txtComment '\/\/.*$' contains=txtTodo


"highlighting for Markdown groups
HtmlHiLink mkdString String
HtmlHiLink mkdCode LineNr
HtmlHiLink mkdBlockquote Comment
"HtmlHiLink mkdLineContinue Comment
HtmlHiLink mkdListItem Identifier
HtmlHiLink mkdRule Identifier
HtmlHiLink mkdLineBreak Todo
HtmlHiLink mkdFootnotes htmlLink
HtmlHiLink mkdLink htmlLink
HtmlHiLink mkdURL htmlString
HtmlHiLink mkdInlineURL htmlLink
HtmlHiLink mkdID Identifier
HtmlHiLink mkdLinkDef mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle htmlString

HtmlHiLink mkdDelimiter Delimiter


"hi link mkdCode         PmenuSbar
hi link txtApostrophe   WarningMsg"Special
hi link txtQuotes       MoreMsg"String
hi link txtParentesis   String"Special "Comment
hi link txtBrackets     Function"Special
hi link txtUrl          Underlined"ModeMsg"Tabline"PmenuSbar
hi link txtEmailMsg     PmenuSbar
hi link txtComment      Comment


let b:current_syntax = "markdown"

delcommand HtmlHiLink
" vim: ts=8
