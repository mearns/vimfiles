" Filetype plugin for n3 (RDF) files.

runtime! ftplugin/_common.vim

if DidFtPlugin("n3")
  finish
endif

call FileTypeTemplate("n3", "n3")

setlocal foldmethod=syntax

let b:undo_ftplugin = "setlocal"
    \ . " foldmethod<"

