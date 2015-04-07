" Autocommands for setting filetype by filename.
"
" See
"   :help new-filetype
"
" This is option B in the help-doc. This script will be sourced before
" $VIMRUNTIME/filetype.vim, so the rules here take precedence, but those will
" still be used.
"
if exists("did_load_filetypes")
  finish
endif

if !exists('g:skip_ft_template')
    let g:skip_ft_template = ['ft-test2']
endif

runtime! ftplugin/_common.vim

function! LoadFallbackTemplate()
    if !FileTypeTemplateLoaded()
        for l:ft in split(&ft, '\.')
            if index(g:skip_ft_template, l:ft) == -1
                if FallbackOnTemplate(l:ft)
                    break
                endif
            endif
        endfor
    endif
endfunction

augroup filetypedetect

    au! BufNewFile,BufRead *.vimcons,*.vcl setf vimcons

    au! BufNewFile,BufRead *.jelly setf xml.jelly
    
    au! BufNewFile,BufRead *.csv setf csv

    au! BufNewFile,BufRead *.tex setf tex.latex
    au! BufNewFile,BufRead *.latex setf tex.latex

    au! BufNewFile,BufRead *.tags   setf tags


    " scons files
    au! BufNewFile,BufRead SConstruct setf python.sconstruct
    au! BufNewFile,BufRead sconscript setf python.sconscript
    au! BufNewFile,BufRead sconscript_* setf python.sconscript
    au! BufNewFile,BufRead */site_scons/site_tools/*.py setf python.sconstool

    " hg stuff
    au BufRead,BufNewFile hg-editor-*.txt setf hg.hgcommit
    au BufRead,BufNewFile .hgignore setf hg.hgignore
    au BufRead,BufNewFile .hgtags setf hg.hgtags
    au BufRead,BufNewFile hgrc setf cfg.hg.hgrc

    " Additional extensions for spice (defaults are .sp and .spice).
    au BufRead,BufNewFile *.cir setf spice
    
    " pstricks
    autocmd BufRead,BufNewFile *.pstricks set filetype=pstricks.tex

    " Scratch pads
    autocmd BufRead,BufNewFile scratch-pad*.otl setf scratchpad.otl
    autocmd BufRead,BufNewFile scratchpad*.otl setf scratchpad.otl
    autocmd BufRead,BufNewFile scratch-pad*.txt setf scratchpad.text
    autocmd BufRead,BufNewFile scratchpad*.txt setf scratchpad.text
    
    "templ
    autocmd BufRead,BufNewFile *.templ setf templ
    autocmd BufRead,BufNewFile *.tmpl setf templ
    autocmd BufRead,BufNewFile *.itempl setf templ
    autocmd BufRead,BufNewFile *.itmpl setf templ

    "C
    autocmd BufRead,BufNewFile *.h setf cheader.c

    "N3 / RDF
    autocmd BufRead,BufNewFile *.n3 setf n3

    "Turtle / RDF
    autocmd BufRead,BufNewFile *.ttl setf turtle.n3
    autocmd BufRead,BufNewFile *.turtle setf turtle.n3
    func! s:TurtleDetect()
            for i in range(10)
                if getline(i) =~? '\v\s*\@prefix\s+[\-\_a-zA-Z0-9]+:\s+\<[^\>]+\>\s*\.'
                    setf turtle.n3
                    break
                endif
            endfor
    endfunc
    autocmd BufRead * call s:TurtleDetect()

    "GnuPlot
    au! BufNewFile,BufRead *.plt,*.gnuplot setf gnuplot

    autocmd BufRead,BufNewFile *.ft-test setf ft-test1.ft-test2.ft-test3.ft-test4

    """ If a file-type template has not yet been loaded, try to load one
    " for the first filetype that has a template.
    autocmd BufRead,BufNewFile * call LoadFallbackTemplate()
    

augroup END

