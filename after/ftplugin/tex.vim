" Filetype plugin for SCons files

runtime! ftplugin/_common.vim

if DidFtPlugin("tex")
  finish
endif

"Read in the tex template when creating new tex files.
call NewFileTemplate("tex")

"Built-in ftplugin for tex fails to escape the first % for printf use.
set commentstring=%%%s

let b:surround_{char2nr("b")}="\\textbf{\r}"
let b:surround_{char2nr("i")}="{\\em \r}"
let b:surround_{char2nr("$")}="$ \r $"

let b:undo_ftplugin = "setlocal " .
    \ "commentstring< "

