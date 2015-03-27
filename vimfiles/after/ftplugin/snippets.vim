" Filetype plugin for SCons files

runtime! ftplugin/_common.vim

if DidFtPlugin("snippets")
  finish
endif

"Read in the tex template when creating new tex files.
call NewFileTemplate("snippets")


