" Vim syntax file
" Language:	Diff (context or unified)
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2005 Jun 20

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

set nocursorline
set fdm=syntax

syn match diffOnly	"^Only in .*"
syn match diffIdentical	"^Files .* and .* are identical$"
syn match diffDiffer	"^Files .* and .* differ$"
syn match diffBDiffer	"^Binary files .* and .* differ$"
syn match diffIsA	"^File .* is a .* while file .* is a .*"
syn match diffNoEOL	"^No newline at end of file .*"
syn match diffCommon	"^Common subdirectories: .*"

syn region diffRemoved start="^<" end="^\([^<]\)\@=" fold
syn region diffRemoved start="^-" end="^\([^-]\)\@=" fold

syn region diffAdded start="^>" end="^\([^>]\)\@=" fold
syn region diffAdded start="^+" end="^\([^+]\)\@=" fold

syn region diffChanged start="^!" end="^\([^!]\)\@=" fold
"The designators at the start of each "line" chunk that indicate what portion of each file it came from (usually line numbers).
syn match diffSubname	"^@@ \([^@]\|@[^@]\)\+ @@"ms=s+3,me=e-3 contained contains=diffSubnameLeft,diffSubnameRight
syn match diffSubnameLeft "^@@ \S\+ "ms=s+3,me=e-1 contained
syn match diffSubnameRight " \S\+ @@"ms=s+1,me=e-3 contained


"A diffLine is a chunk of content, preceded by a designator indicating where the chunk came from (usually line numbers).
syn region diffLine	start="^@@ .*$" end="^\(@@ .*\)\@=" end="^\(Index:\)\@=" contains=diffSubname,diffSubnameLeft,diffSubnameRight,diffAdded,diffRemoved,diffChanged,diffContent,diffComment fold
syn region diffLine	start="^\d\+.*" end="^\(\d\+\)\@=" end="^\(Index:\)\@=" contains=diffSubname,diffAdded,diffRemoved,diffChanged,diffContent,diffComment fold
syn region diffLine	start="^\*\*\*\*.*" end="^\(\*\*\*\*\)\@=" end="^\(Index:\)\@=" contains=diffSubname,diffAdded,diffRemoved,diffChanged,diffContent,diffComment fold
"Some versions of diff have lines like "#c#" and "#d#" (where # is a number)
syn region diffLine      start="^\d\+\(,\d\+\)\?[cda]\d\+\>" end="^\(\d\+\(,\d\+\)\?[cda]\d\+\>\)\@=" end="^\s*$" end="^\(###\+\)\@=" end="^\(Index:\)\@=" contains=diffSubname,diffAdded,diffRemoved,diffChanged,diffContent,diffComment fold keepend

"A diffFile includes all the diff content related to a specific file.
syn region diffFile	start="^Index: .*$" end="^\(Index: \)\@=" contains=ALL fold

"diffHeader is the few lines that sometimes precede the actual diffLines in a diffFile, usually telling you which two files are being compared.
syn region diffHeader   start="^\(=\{10,\}\)" end="^\(@@ \)\@=" contains=diffOldFile,diffNewFile,diffComment contained fold

syn match diffOldFile	"^--- .*" contained
syn match diffNewFile	"^+++ .*" contained

"Miscellaneous common content of the compared files.
syn match diffContent "^ .*"

"A comment inserted into the diff to explain the differences.
syn region diffComment start="^#" end="^\([^#]\)\@=" 


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


let b:current_syntax = "diff"

" vim: ts=8 sw=2
