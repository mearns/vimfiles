" Filetype plugin for python files.

runtime! ftplugin/_common.vim

if DidFtPlugin("rst")
  finish
endif

setlocal commentstring=..\ #\ %s

call FileTypeTemplate("rst", "rst")

let b:surround_{char2nr("b")}="**\r**"
let b:surround_{char2nr("i")}="*\r*"
let b:surround_{char2nr("c")}="``\r``"

