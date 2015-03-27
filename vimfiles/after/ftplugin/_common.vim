" Common functions and things for ftplugins.
" you can use it like:
" runtime! ftplugin/_common.vim

" If we have recursive ftplugins to load, and they each source this, we don't
" want to try to redefine stuff (and may not be able to, for instance if
" FtExtend is being used.
if exists('g:ftplugin_common_loaded')
    finish
endif
let g:ftplugin_common_loaded = 1

if !exists('b:ft_template_loaded')
    let b:ft_template_loaded = 0
endif

function! DidFtPlugin(name)
    if exists('b:did_ftplugin')
        if b:did_ftplugin == a:name
            return 1
        endif
    endif
    let b:did_ftplugin = a:name
    return 0
endfunction

" Load the specified template if the file is new (doesn't exist
" on the filesystem).
function! NewFileTemplate(name)
    if empty(glob(expand('%:p')))
        exec "Template " a:name
        let b:ft_template_loaded = 1
    endif
endfunction

function! FileTypeTemplateLoaded()
    if !exists('b:ft_template_loaded')
        let b:ft_template_loaded = 0
    endif
    return b:ft_template_loaded
endfunction

function FallbackOnTemplate(name)
    if !exists('b:ft_template_loaded')
        let b:ft_template_loaded = 0
    endif
    if !b:ft_template_loaded
        if TemplateExists(a:name)
            call NewFileTemplate(a:name)
            return 1
        endif
    endif
    return 0
endfunction

" Calls NewFileTemplate only if ft is the first filetype.
function! FileTypeTemplate(name, ft)
    if split(&ft, '\.')[0] == a:ft
        call NewFileTemplate(a:name)
    endif
endfunction

function! FtExtend(parenttype)
    let did_ftplugin_exists = exists('b:did_ftplugin')
    if did_ftplugin_exists
        let old_did_ftplugin = b:did_ftplugin
        unlet b:did_ftplugin
    endif

    exec "runtime! ftplugin/" . a:parenttype . ".vim ftplugin/" . a:parenttype . "_*.vim ftplugin/" . a:parenttype . "/*.vim"

    if did_ftplugin_exists
        let b:did_ftplugin = old_did_ftplugin
    endif
endfunction


