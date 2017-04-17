" Vim compiler file
" Compiler:         Python
" Maintainer:       Brian Mearns <bmearns@ieee.org>
" Latest Revision:  2014-08-28

if exists("current_compiler")
  finish
endif
let current_compiler = "setup_py"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
"set cpo&vim

CompilerSet makeprg=python\ setup.py

CompilerSet errorformat=
    \%-G%\\s%#,
    \%f:%l:\ %tARNING:\ %m,
    \%.%#:\ %tARNING:\ %m,
    \%-Gbuilding\ %.%#\ all\ source\ files,
    \%-Gupdating\ environment:\ %.%#,
    \%-Glooking\ for\ now-outdated\ files...\ %.%#\ found,
    \%-G%.%#...\ done,
    \%-Greading\ sources...\ %.%#\ %f,
    \%-Gwriting\ output...\ %.%#\ %f,
    \%-Gwriting\ additional\ files%.%#,
    \%+Ibuild\ succeeded.,
    \%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

let &cpo = s:cpo_save
unlet s:cpo_save
