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
function! ClearOutputAfterCurrentLine()

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

    call ClearOutputAfterCurrentLine()

    let l:output = system(l:command)
    let l:olines = split(l:output, '\n', 1)
    for l:line in l:olines
        call append(l:lineno, s:output_leader . l:line)
        let l:lineno += 1
    endfor

endfunction

nnoremap <silent> <buffer> <C-CR> :call ExeCurrentLine()<CR><C-l>

"
"command! -buffer -nargs=1 SC execute s:SearchColumn('<args>')|normal! n

" 
"nnoremap <silent> <buffer> H :call <SID>HighlightPrevColumn()<CR>
"nnoremap <silent> <buffer> L :call <SID>HighlightNextColumn()<CR>
"nnoremap <silent> <buffer> J <Down>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> K <Up>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> <C-f> <PageDown>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> <C-b> <PageUp>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> <C-d> <C-d>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> <C-u> <C-u>:call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> 0 :let b:csv_column=1<CR>:call <SID>Highlight(b:csv_column)<CR>
"nnoremap <silent> <buffer> $ :let b:csv_column=b:csv_max_col<CR>:call <SID>Highlight(b:csv_column)<CR>
"nnoremap <silent> <buffer> gm :call <SID>Focus_Column(b:csv_column)<CR>
"nnoremap <silent> <buffer> <LocalLeader>J J
"nnoremap <silent> <buffer> <LocalLeader>K K
" 
"" The column highlighting is window-local, not buffer-local, so it can persist
"" even when the filetype is undone or the buffer changed.
"execute 'augroup csv' . bufnr('')
"  autocmd!
"  " These events only highlight in the current window.
"  " Note: Highlighting gets slightly confused if the same buffer is present in
"  " two split windows next to each other, because then the events aren't fired.
"  autocmd BufLeave <buffer> silent call s:Highlight(0)
"  autocmd BufEnter <buffer> silent call s:Highlight(b:csv_column)
"augroup END
"
