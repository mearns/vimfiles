" Filetype plugin for editing Spice circuit files.

"Load common functionality for ftplugins
runtime! ftplugin/_common.vim

if DidFtPlugin("spice")
    finish
endif

setlocal comments=:* commentstring=*\ %s formatoptions-=t formatoptions+=croqlj

"To undo the ftplugin, revert these options to their global values.
let b:undo_ftplugin = "setlocal comments< commentstring< formatoptions<"

"Commands to execute for new files.
call NewFileTemplate('spice')

