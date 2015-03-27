
"Ask the user for a recipient list, and return it as a list.
" Recipients are separated by arbitrary whitespace and commans. They will
" automatically (and dumbly) be wrapped in double quotes when invoking the
" gpg command.
fun! GpgRetrieveRecipients()
    return split(input("Recipients: "), "\\s*,\\s*")
endfunction

"Set the buffer's default list of recipients according to the argument to the
" command, which is just a long string with each recipient separated by commas.
" Each recipient will eventually be wrapped in double quotes (no other
" escaping is done) and passed as a -r option to the gpg command for
" encryption. The command finished with a ShowRecipients command.
command! -nargs=* SetRecipients let b:GpgRecipients = split(<q-args>, "\\s*,\\s*") | ShowRecipients

"Add more recipients to the buffer's default list based on the argument to the
" command. See SetRecipients.
command! -nargs=* AddRecipients let b:GpgRecipients += split(<q-args>, "\\s*,\\s*") | ShowRecipients

"Asks the user for a new list of recipients, typed into the Vim console as a
"comma-separated list. See SetRecipients
command! EnterRecipients let b:GpgRecipients = GpgRetrieveRecipients() | ShowRecipients

"Like EnterRecipients, but appends to the list, like AddRecipients
command! EnterMoreRecipients let b:GpgRecipients += GpgRetrieveRecipients() | ShowRecipients

"Removes all the recipients in the buffer's current list. See SetRecipients
"for details.
command! ClearRecipients unlet b:GpgRecipients | ShowRecipients



"Displays the currently stored list of recipients for this buffer.
" See SetRecipients for details on recipients. If banged = !, 
" a more terse message is given: if no recipients, then an empty
" string is printed, otherwise, just the recipients and separating command are
" printed (with no additional whitespace or message)
fun! GpgDisplayRecipients(banged, ...)
    let l:banged = a:banged == "!"
    if !exists("b:GpgRecipients") || len(b:GpgRecipients) == 0
        if !l:banged
            echo "No recipients."
        else
            echo ""
        endif
    else
        if l:banged
            echo join(b:GpgRecipients, ",")
        else
            echo "Current recipients: " . join(b:GpgRecipients, ", ")
        endif
    endif
endfunction
command! -bang ShowRecipients call GpgDisplayRecipients(<f-bang>)


"Encrypts the given range. If !'d, it asks for new recipients and only
" uses them this one time. Otherwise, it uses the recipients stored in the
" buffer. If there are none stored in the buffer, it asks for them, and then
" stores them in the buffer (unless of course it's !'d). ... are additional
" args to pass to the gpg command.
fun! GpgEncrypt(banged, ...) range

    let l:banged = a:banged == "!"

    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    if !exists("b:GpgRecipients") || len(b:GpgRecipients) == 0 || l:banged
        let l:recipients = GpgRetrieveRecipients()
        if !l:banged
            let b:GpgRecipients = l:recipients
        endif
    else
        let l:recipients = b:GpgRecipients
    endif

    if len(l:recipients) == 0
        echoerr "Recipients are required for encryption."
        return
    endif

    execute(a:firstline . "," . a:lastline . "!gpg --encrypt --quiet -r \"" . join(l:recipients, "\" -r \"") . "\"" . l:args)
endfunction
command! -range=% -bang -nargs=? Encrypt <line1>,<line2>call GpgEncrypt(<f-bang>, <f-args>)



"Performs a signature and an encryption. See GpgSign and GpgEncrypt.
fun! GpgSignAndEncrypt(banged, ...) range

    let l:banged = a:banged == "!"

    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    if !exists("b:GpgRecipients") || len(b:GpgRecipients) == 0 || l:banged
        let l:recipients = GpgRetrieveRecipients()
        if !l:banged
            let b:GpgRecipients = l:recipients
        endif
    else
        let l:recipients = b:GpgRecipients
    endif

    if len(l:recipients) == 0
        echoerr "Recipients are required for encryption."
        return
    endif

    let l:pphrase = inputsecret("Passphrase: ")
    execute(a:firstline . "," . a:lastline . "!gpg --encrypt --sign --quiet --passphrase=" . l:pphrase . " -r \"" . join(l:recipients, "\" -r \"") . "\"" . l:args)
    unlet l:pphrase
endfunction
command! -range=% -bang -nargs=? SignAndEncrypt <line1>,<line2>call GpgSignAndEncrypt(<f-bang>, <f-args>)



"Signs the given range, replacing it with the signed text.
" Note that the default is binary signature, which is probably
" going to be wrong unless you've 'set binary'.
" You can make it ascii gaurded by passing -a as an argument.
fun! GpgSign(...) range
    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    let l:pphrase = inputsecret("Passphrase: ")
    execute(a:firstline . "," . a:lastline . "!gpg --sign --quiet --passphrase=" . l:pphrase . l:args)
    unlet l:pphrase
endfunction
command! -range=% -nargs=? Sign <line1>,<line2>call GpgSign(<f-args>)


"Clear signs the given range, replacing it with the clear signed text.
" Asks for passphrase.
fun! GpgClearSign(...) range
    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    let l:pphrase = inputsecret("Passphrase: ")
    execute(a:firstline . "," . a:lastline . "!gpg --clearsign --quiet --passphrase=" . l:pphrase . l:args)
    unlet l:pphrase
endfunction
command! -range=% -nargs=? ClearSign <line1>,<line2>call GpgClearSign(<f-args>)

"Doesn't seem to work with binary signatures.
fun! GpgVerify(...) range

    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    "Yank the text to be checked, paste into new bufer
    execute(a:firstline . "," . a:lastline . "y")
    new
    set binary
    normal p

    "Verify in the new buffer
    execute("0,$!gpg --verify"  . l:args)

    "Retrieve the messages from GPG
    let resp = []
    let line = getline("$")
    while match(line, "^gpg: .*$") == 0
        let resp = [line] + resp
        execute("$d")
        let line = getline("$")
    endwhile

    "Close the new buffer
    q!

    "Echo the message, if there are any.
    let l:i = 0
    while l:i < len(resp)
        echo resp[l:i]
        let l:i += 1
    endwhile

endfunction
command! -range=% -nargs=? Verify <line1>,<line2>call GpgVerify(<f-args>)


"Decrypts the given range, replacing it with the decrypted text.
" If gpg says anything (like GOOD SIG, or BAD SIG), this is echoed
" to the Vim console.
" If you're just decrypting a signature, don't need to enter a password,
" just hit enter.
fun! GpgDecrypt(...) range
    let l:args = ""
    if a:0 > 0
        let l:args = " " . a:1
    endif

    execute(a:firstline . "," . a:lastline . "y")
    new
    normal p

    let l:pphrase = inputsecret("Passphrase: ")
    if len(l:pphrase) > 0
        let l:ppstr = " --passphrase=" . l:pphrase
    else
        let l:ppstr = ""
    endif
    execute("0,$!gpg --decrypt --quiet" . l:ppstr . l:args)
    unlet l:pphrase

    "Clean up the messages from GPG
    let resp = []
    let line = getline("$")
    while match(line, "^gpg: .*$") == 0
        let resp = [line] + resp
        execute("$d")
        let line = getline("$")
    endwhile

    "Cut the text out of the new buffer.
    execute("0,$d")
    q!

    "Check to see if this was the whole file, which leads to an extra empty
    " line at the end.
    let l:wholeRange = 0
    if a:firstline == 1 && a:lastline == line("$")
        let l:wholeRange = 1
    endif

    "Delete the encrypted text into the blackhole, then paste in the new
    execute(a:firstline . "," . a:lastline . "d _")
    normal P
    if l:wholeRange == 1
        normal Gdd
    endif


    "Echo the message, if there are any.
    let l:i = 0
    while l:i < len(resp)
        echo resp[l:i]
        let l:i += 1
    endwhile

endfunction
command! -range=% -nargs=? Decrypt <line1>,<line2>call GpgDecrypt(<f-args>)
