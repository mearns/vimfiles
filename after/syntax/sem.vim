" Vim syntax file
" Language:	sem
" Maintainer:	Brian Mearns <bmearns@ieee.org>
" Last Change:	2015-04-15

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let b:current_syntax = 'sem'

set fdm=syntax

let s:name = '[-_\.a-zA-Z0-9]*[_a-zA-Z0-9]\+'

exec "syn match semReference '&" . s:name . "'"

exec "syn match semRelationship '#" . s:name . "'"
syn match semRelationship '#<\@='

exec "syn match semInvRelationship '\\~" . s:name . "'"
syn match semInvRelationship '\~<\@='

"syn match semCurlyBrace '[{}]' contained
syn match semWhisper '<[^>]*>'

exec "syn match semId '@" . s:name . "'"
syn match semId '@<\@='

syn match semCompoundIdDelim '@\[' contained
syn match semCompoundIdDelim '\]' contained

syn region semCompoundId start='@\[' end='\]' contains=semId,semCompoundIdDelim keepend

syn region semBlock start='{' end='}' fold contains=semId,semRelationship,semCompoundId,semCompoundIdDelim,semScope,semWhisper,semBlock,semInvRelationship,semReference


" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link semRelationship 		Function
hi def link semInvRelationship 		Function
hi def link semId		        Constant
hi def link semReference         Special
hi def link semCompoundIdDelim		PreProc
hi def link semWhisper                  Comment
"hi def link semCurlyBrace                  Special

"hi def cmdLineOutputDark guifg=white guibg=black
"hi def cmdLineOutputLight guifg=black guibg=white



