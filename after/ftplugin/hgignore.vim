" Filetype plugin for hgignore files for mercurial.

runtime! ftplugin/_common.vim

if DidFtPlugin("hgignore")
  finish
endif

" Inherit from scons
call FtExtend("hg")

call NewFileTemplate("hgignore")

