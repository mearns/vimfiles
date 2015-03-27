" Vim syntax file
" Language:	American Power Conversion's proprietary RPU assembly language
" Maintainer:	Brian Mearns <Brian.Mearns@apcc.com>
" Last Change:	2008 Apr 4

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn sync fromstart
syn case match


" Define the instructions
syn keyword rpuInstruction		LDA LDR STA STI GTS RTS GTO IGT ILT IET EFI MUL ADD SR1 SL1 SR3 SL3 LBA
syn keyword rpuPseudoInstruction	NOP NOOP
syn keyword rpuDataInit			INR


" Tags inside comments
syn match rpuTagTodo	"TODO\c"		contained
syn match rpuTagFixme	"FIXME\c"		contained
" The HE trims the : from being highlighted
syn match rpuTagWarning	"WARN:\c"he=e-1		contained
syn match rpuTagError	"ERROR:\c"he=e-1	contained
" Here, the hs also removes the @ from being highlighted
syn match rpuTagCust	"![^:]*:"hs=s+1,he=e-1	contained 

" Documentation tags in comments
syn match rpuDocTags	"@\w\w*"hs=s+1	contained


" Comments
" Comments can contain comment tags
syn match rpuEOLComment	"//.*"		contains=rpuTag.*,rpuDocTags.*
syn region rpuMLineComment	start="/\*"	end="\*/" fold contains=rpuTag.*,rpuDocTags.*

syn match rpuLabel		"^\s*[a-zA-Z01-9\.\-_][a-zA-Z01-9\.\-_]*\s*:"
syn match rpuDataLabel		"^\s*[a-zA-Z01-9\.\-_][a-zA-Z01-9\.\-_]*\s*:\s*INR"me=e-3

syn match rpuMacroArg		"_[A-Z01-9\.\-_][A-Z01-9\.\-_]*_"
syn match rpuMacroName		"__[A-Z01-9\.\-_][A-Z01-9\.\-_]*__"

syn match rpuDecNumber		"0\+[1-7]\=[\t\n$,; ]"
syn match decNumber		"[1-9]\d*"
syn match octNumber		"0[0-7][0-7]\+"
syn match hexNumber		"0[xX][0-9a-fA-F]\+"
syn match binNumber		"0[bB][0-1]*"


" Define the default highlighting.
  if version < 508
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink rpuInstruction		Keyword
  HiLink rpuPseudoInstruction	Keyword
  HiLink rpuDataInit		Operator
  
  HiLink rpuLabel		Label
  HiLink rpuDataLabel		Identifier
  HiLink rpuIdentifier		Identifier
  
  HiLink rpuMacroName		Function
  HiLink rpuMacroArg		Identifier

  HiLink rpuDefine		Define
  HiLink rpuAlloc		Define
  HiLink rpuChoice		PreCondit
  HiLink rpuChoose		PreCondit
  HiLink rpuOpt			PreCondit
  HiLink rpuArray		PreCondit

  HiLink rpuEOLComment		Comment
  HiLink rpuMLineComment	Comment

  HiLink rpuTagTodo		Todo
  HiLink rpuTagFixme		Todo
  HiLink rpuTagWarning		Todo
  HiLink rpuTagError		Error
  HiLink rpuTagCust		Todo

  HiLink rpuDocTags		SpecialComment

  HiLink hexNumber	Number
  HiLink decNumber	Number
  HiLink octNumber	Number
  HiLink binNumber	Number

  delcommand HiLink

let b:current_syntax = "rpu"

" vim: ts=8
