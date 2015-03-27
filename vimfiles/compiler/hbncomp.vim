" Vim compiler file
" Compiler:         Maven java Compiler
" Maintainer:       Brian Mearns <bmearns@ieee.org>
" Latest Revision:  2014-08-12

if exists("current_compiler")
  finish
endif
let current_compiler = "hbncomp"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
"set cpo&vim

"Okay, but use the :Scons command instead, uses better completion and stuff.
CompilerSet makeprg=scons\ -u

command! -narg=1 UnitTest QuickFix cd\ build\\apps\\<args>\\unittest_debug_arch_pc32_c_mingw\ &&\ <args>_ut.exe<CR>

"Reset to defaults.
CompilerSet errorformat&vim

CompilerSet errorformat^=
    \%+GDBG:\ %f:%l:\ %m,
    \%+EFAIL%\\s%#:%\\s%#%[%^:]%#:\ %f:%l:\ %m,
    \%-GPASS\ %#:\ %#%.%#,
    \%-GSUCCESS\ opening\ catsrunner.out\ file,
    \%+GTests\ passed:\ %.%#,
    \%+ETests\ failed:\ %.%#,
    \%-G%\\s%#Reading\ [%.%#,
    \%-G%\\s%#Exiting\ [%.%#,
    \%-G-%#,
    \%-Gscons:\ Reading\ SConscript\ files\ ...,
    \%-Gscons:\ done\ reading\ SConscript\ files.,
    \%-Gscons:\ Building\ targets\ ...,
    \%-Gscons:\ done\ building\ targets.\,
    \%+Gscons:\ `%[%^']%#'\ is\ up\ to\ date.,
    \%+GCompiling\ %.%#,
    \%+GGenerating:\ %.%#,
    \%+GLinking\ %.%#,
    \%-G%\\s%#%$


function! GetCleanPath()
    
python << EOF

import vim

def keep(path):
    return not (path.startswith('source') or path.startswith('apps') or path.startswith('imported'))

vim.command("return '" + ','.join(filter(keep, vim.eval('&path').split(','))) + "'")

EOF

endfunction

function! FindPath()
python << EOF

import os, os.path

dirs = ['source']
for path in os.listdir('apps'):
    path = os.path.join('apps', path)
    if os.path.isdir(path):
        dirs.append(os.path.join(path, 'app_src'))

toscan = dirs + ['imported']
while toscan:
    root = toscan.pop()
    for path in os.listdir(root):
        path = os.path.join(root, path)
        if os.path.isdir(path):
            dirs.append(path)
            toscan.append(path)

path = ",".join(dirs)

vim.command("return '" + path + "'")

EOF

endfunction

CompilerSet path&vim
let &path=&path . ',' . FindPath()

let &cpo = s:cpo_save
unlet s:cpo_save
