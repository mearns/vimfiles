" Filetype plugin for C files

runtime! ftplugin/_common.vim

if DidFtPlugin("dosbatch")
  finish
endif

set commentstring=::\ %s

call FileTypeTemplate("dosbatch", "dosbatch")

