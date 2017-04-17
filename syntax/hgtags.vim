" Language:     hg ignore file
" Author:       Brian Mearns
" Filenames:    .hgignore
" Last Change:  2014/05/06

if exists("b:current_syntax")
    finish
endif



syn match hgtagsLine "^.*$" contains=hgtagsLineFirst,hgtagsLineSingle,hgtagsLineIndented
syn match hgtagsLineSingle "^\S\+$" contained
syn match hgtagsLineIndented "^\s\+.*$" contained

syn match hgtagsLineFirst "^\v\S+\s+" contained contains=hgtagsValidId,hgtagsInvalidIdTooShort,hgtagsInvalidIdTooLong,hgtagsInvalidIdBadForm nextgroup=hgtagsLineSecond
syn match hgtagsLineSecond ".*$" contained contains=hgtagsTagName

syn match hgtagsValidId "^\v[0-9a-fA-F]{40}\ze\s+" contained
syn match hgtagsInvalidIdTooShort "^\v[0-9a-fA-F]{,39}\ze\s+" contained
syn match hgtagsInvalidIdTooLong "^\v[0-9a-fA-F]{41,}\ze\s+" contained
syn match hgtagsInvalidIdBadForm "^\v\S*[^[:space:]0-9a-fA-F]\S*\ze\s+" contained contains=hgtagsInvalidIdChar
syn match hgtagsInvalidIdChar "[^0-9a-fA-F]" contained


syn match hgtagsTagName ".*" contained contains=hgtagsInvalidTagName
syn match hgtagsInvalidTagName ".*:.*" contained contains=hgtagsInvalidTagChar
syn match hgtagsInvalidTagChar ":" contained

hi! def link hgtagsInvalidIdTooShort hgtagsInvalidIdLength
hi! def link hgtagsInvalidIdTooLong hgtagsInvalidIdLength
hi! def link hgtagsInvalidIdLength hgtagsInvalidId
hi! def link hgtagsInvalidIdBadForm hgtagsInvalidId

hi! def link hgtagsInvalidId Error
hi! def link hgtagsInvalidIdChar Underlined

hi! def link hgtagsLineSingle Error
hi! def link hgtagsLineIndented Error

hi! def link hgtagsValidId   Number
hi! def link hgtagsTagName   Identifier
hi! def link hgtagsInvalidTagName   Error
hi! def link hgtagsInvalidTagChar   Underlined



let b:current_syntax = "hgignore"
