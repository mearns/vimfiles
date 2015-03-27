" Experimental file-type plugin to implement a command-line thingy in Vim
" Brian Mearns

runtime! ftplugin/_common.vim

if DidFtPlugin("vimcons")
  finish
endif


let b:did_ftplugin = 1

let s:re_cmd = '^>\s*'

let s:output_leader = '    '
let s:re_output = '^    '

" Finds the command line under or above the cursor, but only if
" the cursor is on the command line or output of that command line.
function! FindCommandLine()
    "Work backward until we find the command line.
    let l:lineno = line('.')
    let l:cmdlineno = l:lineno
    while l:cmdlineno > 0
        let l:line = getline(l:cmdlineno)
        if match(l:line, s:re_cmd) == 0
            "Found the command line
            return l:cmdlineno
        endif
        if match(l:line, s:re_output) < 0
            "Found a non-output line, so we can't find a command line.
            return 0
        endif
        let l:cmdlineno -= 1
    endwhile
    return 0
endfunction

" Clear the command output following the current line.
function! ClearOutputAtCurrentLine()

    let l:cmdlineno = FindCommandLine()
    if l:cmdlineno == 0
        echoerr "Cannot find command line."
        return
    endif

    "Delete all the output from this command.
    call cursor(l:cmdlineno+1, 1)

    "Make sure folds are expanded.
    normal zO
    while 1
        let l:lineno = line('.')
        if l:lineno == l:cmdlineno
            break
        endif

        let l:line = getline(l:lineno)
        if match(l:line, s:re_output) != 0
            break
        endif
        normal "_dd
    endwhile

    call cursor(l:cmdlineno, 1)

endfunction
 
" Execute the line under the cursor, if it's a command.
function! ExeCurrentLine()
    let l:lineno = FindCommandLine()
    if l:lineno == 0
        echoerr "Cannot find command line."
        return
    endif

    let l:line = getline(l:lineno)
    let l:command = substitute(l:line, s:re_cmd, '', '')

    call ClearOutputAtCurrentLine()

    let l:output = system(l:command)
    let l:olines = split(l:output, '\n', 1)
    for l:line in l:olines
        call append(l:lineno, s:output_leader . l:line)
        let l:lineno += 1
    endfor

endfunction

nnoremap <silent> <buffer> <C-CR> :call ExeCurrentLine()<CR><C-l>

nnoremap <silent> <buffer> <C-Del> :call ClearOutputAtCurrentLine()<CR><C-l>

