" Vim syntax file
" Language:     Edge (AdonisJS)
" Maintainer:   Chris Watson <cawatson1993@gmail.com>
" Filenames:    *.edge

if exists('b:current_syntax')
    finish
endif

if !exists("main_syntax")
    let main_syntax = 'edge'
endif

syntax include @JS syntax/javascript.vim

runtime! syntax/html.vim
unlet! b:current_syntax

syn case match
syn clear htmlError

if has('patch-7.4.1142')
    syn iskeyword @,48-57,_,192-255,@-@,:
else
    setlocal iskeyword+=@-@
endif

syn region  edgeInterpolation   matchgroup=edgeDelimiter start="{{" end="}}"  contains=@JS containedin=ALLBUT,@edgeExempt transparent
syn region  edgeRawHtml         matchgroup=edgeDelimiter start="{{{" end="}}}" contains=@htmlTop containedin=ALLBUT,@edgeExempt transparent

syn match   edgeKeyword '@!\?\w\+'   nextgroup=edgeHtmlParenBlock skipwhite containedin=ALLBUT,@edgeExempt
syn region  edgeHtmlParenBlock       matchgroup=edgeDelimiter start="\s*(" end=")" contains=@JS skipwhite contained

syn cluster edgeExempt contains=edgeComment,edgeInterpolation,edgeHtmlRegion,edgeHtmlParenBlock,@htmlTop

syn cluster htmlPreproc add=edgeInterpolation,edgeComment,edgeRawHtml

syn case ignore
syn keyword edgeTodo todo fixme xxx note  contained

hi def link edgeDelimiter      PreProc
" hi def link edgeComment        Comment
hi def link edgeTodo           Todo
hi def link edgeKeyword        Statement

let b:current_syntax = 'edge'

if exists('main_syntax') && main_syntax == 'edge'
    unlet main_syntax
endif
