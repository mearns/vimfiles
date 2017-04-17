" Experimental file-type plugin to implement a command-line thingy in Vim
" Brian Mearns

runtime! ftplugin/_common.vim

if DidFtPlugin("vimcons")
  finish
endif

let b:did_ftplugin = 1

nnoremap <buffer> <C-CR> :call vcf#exe()<CR><C-l>
nnoremap <buffer> <C-Del> :call vcf#clearOutput()<CR><C-l>

