" Language:     hg ignore file
" Author:       Brian Mearns
" Filenames:    .hgignore
" Last Change:  2014/05/06

if exists("b:current_syntax")
    finish
endif

syn region hgignore             start="^\s*syntax\s*:\s*\(glob\|regexp\)" end="\v\%$" end="^\(\s*syntax\s*:\s*\(glob\|regexp\)\)\@=" contains=hgignoreSyntaxSpecifier keepend

syn match hgignoreSyntaxSpecifier "\v^\s*syntax\s*:\s*(glob|regexp)" contained contains=hgignoreGlob,hgignoreRegexp

syn region hgignoreGlob    matchgroup=hgignoreSyntaxType start="\v(^\s*syntax:\s*)\@=\zsglob\ze\s*$" end="\v\%$" contained contains=hgignoreComment,hgignoreGlobPattern
syn region hgignoreRegexp  matchgroup=hgignoreSyntaxType start="\v(^\s*syntax:\s*)\@=\zsregexp\ze\s*$" end="\v\%$" contained contains=hgignoreComment,hgignoreRegexpPattern

syn match hgignoreGlobPattern   "\v[^#]+" contained
syn match hgignoreRegexpPattern   "\v[^#]+" contained
syn match hgignoreComment   "#.*$" contained


hi! def link hgignoreGlobPattern     hgignorePattern
hi! def link hgignoreRegexpPattern     hgignorePattern

hi! def link hgignoreSyntaxSpecifier   Keyword
hi! def link hgignoreSyntaxType      Identifier
hi! def link hgignoreComment         Comment
hi! def link hgignorePattern     String


let b:current_syntax = "hgignore"
