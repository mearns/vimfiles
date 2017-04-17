" Filetype plugin for SConstruct files

runtime! ftplugin/_common.vim

if DidFtPlugin("pstricks")
  finish
endif

call NewFileTemplate("pstricks")

