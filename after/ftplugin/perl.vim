" Filetype plugin for perl files

runtime! ftplugin/_common.vim

if DidFtPlugin("perl")
  finish
endif

setlocal foldmethod=syntax
setlocal foldlevel=9999

let b:undo_ftplugin = "setlocal "
    \ . " foldmethod<"

call FileTypeTemplate("perl", "perl")

