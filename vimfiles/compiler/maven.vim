" Vim compiler file
" Compiler:         Maven java Compiler
" Maintainer:       Brian Mearns <bmearns@ieee.org>
" Latest Revision:  2014-08-12

if exists("current_compiler")
  finish
endif
let current_compiler = "maven"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
"set cpo&vim

CompilerSet makeprg=mvn

CompilerSet errorformat=
    \[ERROR]\ %f:[%l\\,%v]\ %m,
    \[ERROR]\ %m,
    \[ERROR]%m,
    \%-G[INFO]\ %m,
    \%-G[INFO]%m,
    \%-G[debug]\ %m,
    \%-G[debug]%m

let &cpo = s:cpo_save
unlet s:cpo_save
