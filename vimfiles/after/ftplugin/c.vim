" Filetype plugin for C files

runtime! ftplugin/_common.vim

if DidFtPlugin("c")
  finish
endif

setlocal foldmethod=syntax
setlocal foldlevel=9999

let b:undo_ftplugin = "setlocal "
    \ . " foldmethod<"

set commentstring=//%s

call FileTypeTemplate("c", "c")

