" Vim indent file
" Language:     Edge (AdonisJS)
" Maintainer:   Chris Watson <cawatson1993@gmail.com>

if exists('b:did_indent')
    finish
endif

runtime! indent/html.vim
let s:htmlindent = &indentexpr

let b:did_indent = 1

" Doesn't include 'foreach' and 'forelse' because these already get matched by 'for'.
let s:directives_single_line = '!\w\+\|include\|layout\|debugger'

setlocal autoindent
setlocal indentexpr=GetEdgeIndent()
setlocal indentkeys+=0=}},=@end

" Only define the function once.
if exists('*GetEdgeIndent')
    finish
endif

function! s:IsDelimiter(lnum)
    let line = getline(a:lnum)
    return line =~# '^\s*@!\?\w\+'
endfunction

function! s:IsSingleLineDelimiter(lnum)
    let line = getline(a:lnum)
    return line =~# '^\s*@\(\(!\w\+\)\|' . s:directives_single_line . '\)(.*)'
endfunction
    
function! GetEdgeIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    let line = getline(lnum)
    let cline = getline(v:lnum)
    let indent = indent(lnum)

    " echo cline
    " echo s:IsEndDelimiter(lnum)

    " 1. When the current line is an ending delimiter: decrease indentation
    "    if the previous line wasn't a starting delimiter.
    if line =~# '^\s*@end\w*'
        let indent = indent - &sw
        return indent
    endif

    " 3. Increase indentation if the line contains a starting delimiter.
    if s:IsDelimiter(lnum)
        if s:IsSingleLineDelimiter(lnum)
            return indent
        else
            return indent + &sw
        end
    endif

    " 4. External indent scripts (HTML)
    execute 'let indent = ' . s:htmlindent
    return indent
endfunction
