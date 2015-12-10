" Filetype plugin for turtle (RDF) files.

runtime! ftplugin/_common.vim

if DidFtPlugin("turtle")
  finish
endif

call FtExtend("n3")

call FileTypeTemplate("turtle", "turtle")

