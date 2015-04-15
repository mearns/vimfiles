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

syn match semReference '&[-a-zA-Z0-9_]\+'
syn match semReference '&{[^}]*}'

syn match semRelationship '#[-a-zA-Z0-9_]\+'
syn match semRelationship '#<\@='
syn match semRelationship '#{[^}]*}'

syn match semInvRelationship '\~[-a-zA-Z0-9_]\+'
syn match semInvRelationship '\~<\@='
syn match semInvRelationship '\~{[^}]*}'

"syn match semCurlyBrace '[{}]' contained
syn match semWhisper '<[^>]*>'

syn match semId '@[-a-zA-Z0-9_]\+'
syn match semId '@<\@='
syn match semId '@{[^}]*}'

syn match semCompoundIdDelim '@\[' contained
syn match semCompoundIdDelim '\]' contained

syn region semCompoundId start='@\[' end='\]' contains=semId,semCompoundIdDelim keepend

syn region semBlock start='@\[[^\]]*\]{' start='@\[[^\]]*\]<[^>]*>{' start='[#@~][-a-zA-Z0-9_]\+{' start='[#@~][-a-zA-Z0-9_]\+<[^>]*>{' start='[#@~]{[^}]*}<[^>]*>{' start='[#@~]<[^>]*>{' start='[#@~]{[^}]*}{' end='}' fold contains=semId,semRelationship,semCompoundId,semCompoundIdDelim,semScope,semWhisper,semBlock,semInvRelationship,semReference


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



