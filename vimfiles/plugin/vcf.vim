" vcf.vim - Vim Command File
" Author:       Tim Pope <http://tpo.pe/>
" Version:      2.0
" GetLatestVimScripts: 1697 1 :AutoInstall: surround.vim

if exists("g:loaded_vcf") || v:version < 700 || &cp || !has('python')
  echoerr "Failed to load."
  finish
endif
"let g:loaded_vcf = 1
 
""" Reload our python module.
python <<EOF
import vcf
vcf = reload(vcf)
EOF

function! vcf#clearOutput()
python <<EOF
print vcf.clearOutput()
EOF
endfunc

function! vcf#exe()
python <<EOF
vcf.exeCommandLine()
EOF
endfunc

