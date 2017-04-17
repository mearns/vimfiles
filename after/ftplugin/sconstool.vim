" Filetype plugin for SConstruct site-tools

runtime! ftplugin/_common.vim

if DidFtPlugin("sconstool")
  finish
endif

" Inherit from scons
call FtExtend("sconscript")

call NewFileTemplate("scons_site_tool")

