" Vim compiler file
" Compiler:         Python
" Maintainer:       Brian Mearns <bmearns@ieee.org>
" Latest Revision:  2014-08-28

if exists("current_compiler")
  finish
endif
let current_compiler = "python"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
"set cpo&vim

"Okay, but use the :Scons command instead, uses better completion and stuff.
CompilerSet makeprg=python

CompilerSet errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

let &cpo = s:cpo_save
unlet s:cpo_save
