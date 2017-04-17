" Filetype plugin for C header files

runtime! ftplugin/_common.vim

if DidFtPlugin("cheader")
  finish
endif

call FtExtend("c")

call FileTypeTemplate("cheader", "cheader")


