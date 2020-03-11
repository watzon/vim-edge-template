" Vim filetype plugin
" Language:     Edge (AdonisJS)
" Maintainer:   Chris Watson <cawatson1993@gmail.com>

if exists('b:did_ftplugin')
    finish
endif

runtime! ftplugin/html.vim
let b:did_ftplugin = 1

setlocal suffixesadd=.edge
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal path+=resources/views;
setlocal include=\\w\\@<!@\\%(include\\\|extends\\)
setlocal define=\\w\\@<!@\\%(yield\\)

" if exists('loaded_matchit') && exists('b:match_words')
"     " Append to html matchit words
"     let b:match_words .= ',' .
"                 \ '@\%(section\s*([^\,]*)\|if\|unless\|foreach\|forelse\|for\|while\|push\|can\|cannot\|hasSection\|' .
"                 \     'php\s*(\@!\|verbatim\|component\|slot\|prepend\)' .
"                 \ ':' .
"                 \ '@\%(else\|elseif\|empty\|break\|continue\|elsecan\|elsecannot\)\>' .
"                 \ ':' .
"                 \ '@\%(end\w\+\|stop\|show\|append\|overwrite\)' .
"                 \ ',{:},\[:\],(:)'
"     let b:match_skip = 'synIDattr(synID(line("."), col("."), 0), "name") !=# "edgeKeyword"'
"     let b:match_ignorecase = 0
" endif
