" Filetype plugin for SCons files

runtime! ftplugin/_common.vim

if DidFtPlugin("xml")
  finish
endif

"Read in the tex template when creating new tex files.
call NewFileTemplate("xml")

let b:surround_{char2nr("b")}="<strong>\r</strong>"
let b:surround_{char2nr("i")}="<em>\r</em>"
let b:surround_{char2nr("`")}="<code>\r</code>"

