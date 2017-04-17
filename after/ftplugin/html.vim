" Filetype plugin for SCons files

runtime! ftplugin/_common.vim

if DidFtPlugin("html")
  finish
endif

"Read in the tex template when creating new tex files.
call NewFileTemplate("html")

let b:surround_{char2nr("b")}="<strong>\r</strong>"
let b:surround_{char2nr("i")}="<em>\r</em>"
let b:surround_{char2nr("`")}="<code>\r</code>"

