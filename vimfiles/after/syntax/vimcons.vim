" Vim syntax file
" Language:	vimcons
" Maintainer:	Brian Mearns <bmearns@ieee.org>
" Last Change:	2015-03-27

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

set fdm=syntax

syn match cmdLineCmdArgs    '\(^>\s*\S*\s\+\)\@<=.*'
syn match cmdLineCmd    '\(^>\s*\)\@<=\S*'
syn match cmdLinePrompt '^>\s*'

syn region cmdLineBlock start="^>\s*.*" end='\(^$\|^\s\{0,3}\_S\|^>\)\@='re=s-1 fold keepend contains=cmdLineCmdArgs,cmdLineCmd,cmdLinePrompt,cmdLineOutput
syn region cmdLineOutput start='^\s\{4}' end='\(^$\|^\s\{0,3}\_S\|^>\)\@='re=s-1 fold contained contains=cmdLineCmdArgs,cmdLineCmd,cmdLinePrompt


" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link cmdLinePrompt 		Operator
hi def link cmdLineCmd		Function
hi def link cmdLineCmdArgs		Constant
"hi def link diffRemoved		Special
"hi def link diffChanged		PreProc
"hi def link diffAdded		Identifier
"hi def link diffComment		Comment


let b:current_syntax = "diff"

" vim: ts=8 sw=2

