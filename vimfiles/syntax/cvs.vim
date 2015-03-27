" Vim syntax file
" Language:	CVS commit file
" Maintainer:	Matt Dunford (zoot@zotikos.com)
" URL:		http://www.zotikos.com/downloads/cvs.vim
" Last Change:	Sat Nov 24 23:25:11 CET 2001

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn region cvsLine start="^CVS: " end="$" contains=cvsFile,cvsCom,cvsFiles,cvsTag
syn match cvsFile  contained " \t\(\(\S\+\) \)\+"
syn match cvsTag   contained " Tag:"
syn match cvsFiles contained "\(Added\|Modified\|Removed\) Files:"
syn region cvsCom start="Committing in" end="$" contains=cvsDir contained extend keepend
syn match cvsDir   contained "\S\+$"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cvs_syn_inits")
	if version < 508
		let did_cvs_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink cvsLine		Type
	HiLink cvsDir		cvsFile
	HiLink cvsFile		Constant
	HiLink cvsFiles		cvsCom
	HiLink cvsTag		cvsCom
	HiLink cvsCom		Statement

	delcommand HiLink
endif

syn match diffOnly	"^Only in .*"
syn match diffIdentical	"^Files .* and .* are identical$"
syn match diffDiffer	"^Files .* and .* differ$"
syn match diffBDiffer	"^Binary files .* and .* differ$"
syn match diffIsA	"^File .* is a .* while file .* is a .*"
syn match diffNoEOL	"^No newline at end of file .*"
syn match diffCommon	"^Common subdirectories: .*"

syn match diffRemoved	"^-.*"
syn match diffRemoved	"^<.*"
syn match diffAdded	"^+.*"
syn match diffAdded	"^>.*"
syn match diffChanged	"^! .*"

syn match diffSubname	" @@..*"ms=s+3 contained
syn match diffLine	"^@.*" contains=diffSubname
syn match diffLine	"^\<\d\+\>.*"
syn match diffLine	"^\*\*\*\*.*"

"Some versions of diff have lines like "#c#" and "#d#" (where # is a number)
syn match diffLine	"^\d\+\(,\d\+\)\=[cda]\d\+\>.*"

syn match diffFile	"^diff.*"
syn match diffFile	"^+++ .*"
syn match diffFile	"^Index: .*$"
syn match diffFile	"^==== .*$"
syn match diffRcs	"^RCS file: .*"
syn match diffRetrieve	"retrieving revision .*"
syn match diffOldFile	"^\*\*\* .*"
syn match diffNewFile	"^--- .*"

syn match diffComment	"^#.*"

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link diffOldFile		diffFile
hi def link diffNewFile		diffFile
hi def link diffFile		Type
hi def link diffOnly		Constant
hi def link diffIdentical	Constant
hi def link diffDiffer		Constant
hi def link diffBDiffer		Constant
hi def link diffIsA		Constant
hi def link diffNoEOL		Constant
hi def link diffCommon		Constant
hi def link diffRemoved		Special
hi def link diffChanged		PreProc
hi def link diffAdded		Identifier
hi def link diffLine		Statement
hi def link diffSubname		PreProc
hi def link diffComment		Comment
hi def link diffRcs		Comment
hi def link diffRetrieve	Comment

let b:current_syntax = "cvs"
