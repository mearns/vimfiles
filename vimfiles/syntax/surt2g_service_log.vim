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

syn match surt2gComment         "^#.*"
syn region surt2gCountdown       start=/^\s*\d/ms=e-1                   end=/\s/me=s-1
syn region surt2gEntryNum        start=/\[\#\s*/ms=e+1            end=/\]/me=s-1 
syn region surt2gTimeSetting     start=/\[ts:\s*/ms=e+1           end=/\]/me=s-1
syn region surt2gTimeStamp       start=/\[\(\s\|\d\)\+:\s*/ms=s+1           end=/\]/me=s-1 contains=surt2gTimeStampTop,surt2gTimeStampBottom 
syn region surt2gTimeStampTop    start=/\[\@<=\s*/ms=e+1                   end=/:/me=s-1 contained
syn region surt2gTimeStampBottom start=/:\s*/ms=e+1                    end=/\]/me=s-1 contained
syn match surt2gSource /\[\(\s\|\d\)\{3\}\]/ms=s+1,me=e-1 
syn region surt2gEventCode       start=/Code\[\s*/ms=e+1      end=/\]/me=s-1 
syn region surt2gData           start=/Data\[/ms=e+1            end=/\]/me=s-1  contains=surt2gDataWord 
syn match surt2gDataWord        /[0-9a-fA-F]\+/  contained
syn match surt2gDescription     /\%100c.*$/ 


"A comment inserted into the diff to explain the differences.

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link surt2gComment	Comment
hi def link surt2gDescription   Comment
hi def link surt2gEventCode Identifier

hi surt2gEntryNum guifg=gold
hi surt2gSource guifg=cyan gui=bold
hi surt2gTimeStampTop guifg=pink
hi surt2gTimeStampBottom guifg=pink
hi def link surt2gDataWord Constant


let b:current_syntax = "surt2g_service_log"

" vim: ts=8 sw=2
