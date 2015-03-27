" Filetype plugin for lex/flex files

runtime! ftplugin/_common.vim

if DidFtPlugin("lex")
  finish
endif

setlocal foldmethod=syntax
setlocal foldlevel=9999

let b:undo_ftplugin = "setlocal "
    \ . " foldmethod<"

call FileTypeTemplate("lex", "lex")


