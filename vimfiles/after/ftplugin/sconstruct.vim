" Filetype plugin for SConstruct files

runtime! ftplugin/_common.vim

if DidFtPlugin("sconstruct")
  finish
endif

" Inherit from scons
call FtExtend("scons")

