" Filetype plugin for SConstruct files

runtime! ftplugin/_common.vim

if DidFtPlugin("sconscript")
  finish
endif

" Inherit from scons
call FtExtend("scons")

