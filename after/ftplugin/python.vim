" Filetype plugin for python files.

runtime! ftplugin/_common.vim

if DidFtPlugin("python")
  finish
endif


call FileTypeTemplate("python", "python")

setlocal foldmethod=indent
setlocal omnifunc=pythoncomplete#Complete
setlocal fileencoding=utf-8
setlocal encoding=utf-8

"TODO: Handle single-line and two-line doc strings.
function! FindDocString()
    let currline=line('.')
    let dq_pattern='^\s*"""\s*$'
    let sq_pattern="^\s*'''\s*$"
    let dq_start=search(dq_pattern, 'bcnW')
    let sq_start=search(sq_pattern, 'bcnW')
    if sq_start == 0 || dq_start < sq_start
        if dq_start == 0
            return 0
        endif
        let pat=dq_pattern
        let start=dq_start
    else
        let pat=sq_pattern
        let start=sq_start
    endif
    let end=search(pat, 'cnW')

    return [start, end]
endfunction

function! VisualSelectDocString()
    let lines=FindDocString()
    echom string(lines)
    if type(lines) != 3
        "If it's not a list, it means it couldn't find a match.
        return
    endif
    call setpos("'<", [0, lines[0], 1, 0])
    call setpos("'>", [0, lines[1], 1, 0])
    normal! gv$
endfunction

"TODO: Start selection at same indent as quotes
function! VisualSelectInnerDocString()
    let lines=FindDocString()
    echom string(lines)
    if type(lines) != 3
        "If it's not a list, it means it couldn't find a match.
        return
    endif
    call setpos("'<", [0, lines[0]+1, 1, 0])
    call setpos("'>", [0, lines[1]-1, 1, 0])
    normal! gv$
endfunction

vnoremap <buffer> ad :call VisualSelectDocString()<CR>
vnoremap <buffer> id :call VisualSelectInnerDocString()<CR>
omap ad :normal vad<CR>
omap id :normal vid<CR>


let b:undo_ftplugin = "setlocal"
    \ . " foldmethod<"
    \ . " omnifunc<"
    \ . " fileencoding<"
    \ . " encoding<"

let b:surround_{char2nr("b")}="**\r**"
let b:surround_{char2nr("i")}="*\r*"
let b:surround_{char2nr("c")}="``\r``"



