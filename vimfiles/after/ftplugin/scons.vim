" Filetype plugin for SCons files

runtime! ftplugin/_common.vim

if DidFtPlugin("scons")
  finish
endif

" Inherit from python
call FtExtend("python")

