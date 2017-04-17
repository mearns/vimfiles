fun! Quote(banged, ...) range

    let l:banged = 0
    if strlen(a:banged) > 0
        let l:banged = 1
    endif

    let l:attribute = 0
    let l:author = ""
    if a:0 > 0
        let l:attribute = 1
        let l:author = a:1
    endif

    "Quote the stuff
    execute(a:firstline . "," . a:lastline . "s/^\([^>]\|$\)/ \1/e | " . a:firstline . "," . a:lastline . "s/^/> /e | nohl")

    "Attribute and/or date
    let l:text = ""
    if l:attribute == 1
        let l:text = l:author . " wrote:"
        if l:banged
            let l:text = "Sometime prior to " . strftime("%H:%M %d %b %Y") . ", " . l:text
        endif
    "Banged, but no attribution
    elseif l:banged
        let l:text = "Original message:"
    endif

    if strlen(l:text) > 0
        execute(":" . a:firstline)
        execute("normal O^\"_D")
        execute setline(a:firstline, l:text)
    endif

endfunction
"Email quotes the given range, or whole file if range not given. 
command! -range=% -bang -bar -nargs=? Quote <line1>,<line2>call Quote(<f-bang>, <f-args>)

"Reduces the quote level by 1 for the given range, or entire buffer if no range
"fiven
command! -range=% -bar Unquote <line1>,<line2>s/^>\%( \|$\|\(>\)\)/\1/e | nohl

"Removes all email-quote leaders, like '> ' and '>>> '.
command! -range=% -bar Noquotes <line1>,<line2>s/^>\+ //e | nohl

"Implements the Clip command, see below.
fun! Clip(banged, ...) range

    let l:banged = 0
    if strlen(a:banged) > 0
        let l:banged = 1
    endif

    let l:hasAuthor = 0
    let l:author = ""
    if a:0 > 0
        let l:hasAuthor = 1
        let l:author = a:1
    endif

    let l:clipText = ""
    if l:banged
        let l:clipText = "[clipped"
    else
        let l:clipText = "[clipped " . strftime("%c")
    endif

    if l:hasAuthor && strlen(l:author) > 0
        let l:clipText .= " by " . l:author . "]"
    else
        let l:clipText .= "]"
    endif

    execute(a:firstline . "," . a:lastline . "d")
    execute(":" . a:firstline)
    execute("normal O^\"_Di" . l:clipText . "")

endfunction

"Deletes the given range into the unnamed register, replaces it with text
"saying [clipped <date>], substituting the date as appropriate. If an argument
"is given, then " by <arg>" is appended after the date. If the bang is given
"(Clip!), the date is not given.
command! -range -bar -bang -nargs=? Clip <line1>,<line2>call Clip(<f-bang>, <f-args>)

