" Filetype plugin for Yacc files

runtime! ftplugin/_common.vim

if DidFtPlugin("yacc")
  finish
endif

setlocal foldmethod=syntax
setlocal foldlevel=9999

let b:undo_ftplugin = "setlocal "
    \ . " foldmethod<"

call FileTypeTemplate("yacc", "yacc")


