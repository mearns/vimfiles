" Vim global plugin for storing and loading views from local files
" Last Change:	2008 July 9
" Maintainer:	Brian Mearns (brianpmearns.com)
" License:	Don't Be a Jerk Open License (see bmearns.net/wwk/view/DBAJ)
"
" Description:
" Vim-views are essentially just vim scripts that re-establish the current
" view of a file, including (among other things), the scroll position, the
" folds, current directory, and mappings. Vim has built in functionality to
" save and restore up to ten different views for each file using the |:mkview|
" and |:loadview| commands. However, these files are generally stored in an
" installation dependent location. The purpose of this plugin is to make it
" easy (and automatic) to save these views in the same directory as the file
" itself, thereby making them much more easily portable. 
"

"Local variable: this is the minimum value that the verbose setting must be at
"for this plug in to report what it's doing. Set to -1 to never report.
let s:VerboseThreshold = 2

fun! ResetLocalViewVerboseThreshold()
	call SetLocalViewVerboseThreshold(2)
endfunction

fun! DisableLocalViewVerbosity()
	call SetLocalViewVerboseThreshold(-1)
endfunction

fun! SetLocalViewVerboseThreshold(val)
	let s:VerboseThreshold = a:val
endfunction

fun! GetLocalViewVerboseThreshold()
	return s:VerboseThreshold
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Property handling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"Function to generate the default name for local view files for the current
"buffer.
fun! GetDefaultLocalViewFile()
	return ".".expand("%:t").".lv.vim"
endfunction

"Returns an alternative path for a local-view file, one which is not hidden.
fun! GetAlternateLocalViewFile()
	return expand("%:t").".lv.vim"
endfunction

"Returns true iff the current buffer has a local view file property stored.
" Does not mean anything about whether or not a local view file exists.
fun! HasLocalViewFile()
	return exists("b:LocalViewFile")
endfunction

"Queries the current value of the local view file property. If the property is
"not yet defined, it initializes to the default.
fun! GetLocalViewFile()
	if (!HasLocalViewFile())
		call SetLocalViewFile(GetDefaultLocalViewFile())
	endif
	return b:LocalViewFile
endfunction

fun! SetLocalViewFile(file)
	let b:LocalViewFile = a:file
endfunction


fun! IsLocalViewEnabled()
	return exists("b:LocalViewEnabled") && b:LocalViewEnabled
endfunction

fun! SetLocalViewEnabled(enabledP)
	let b:LocalViewEnabled = a:enabledP
endfunction

fun! EnableLocalView()
	call SetLocalViewEnabled(1)
endfunction

fun! DisableLocalView()
	call SetLocalViewEnabled(0)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Returns true iff the current value of the local view file property
" (or the default one if it isn't already set) is readable.
fun! DoesLocalViewFileExist()
	return filereadable(GetLocalViewFile())
endfunction

fun! DeleteLocalViewFile()
	if DoesLocalViewFileExist()
		let failed = delete(GetLocalViewFile())
		if (&verbose >= s:VerboseThreshold && s:VerboseThreshold != -1)
			if(failed)
				echo "Failed to delete local view file " . GetLocalViewFile() . ": " . failed
			else
				echo "Ok. Deleted local view file " . GetLocalViewFile()
			endif
		endif
	elseif (&verbose >= s:VerboseThreshold && s:VerboseThreshold != -1)
		echo "Ok. Local view file does not exist: " . GetLocalViewFile()
	endif
endfunction

"Stores the current view into the file specified by GetLocalViewFile.
" This is done regardless of whether local views are enabled or not.
fun! ForceMakeLocalView()
	execute "mkview! " . GetLocalViewFile()
	if(&verbose >= s:VerboseThreshold && s:VerboseThreshold != -1)
		echo "Ok. Created local view in file " . GetLocalViewFile()
	endif
endfunction

"Loads the view from the file specified by GetLocalViewFile
" This is done regardless of whether local views are enabled or not,
" however, not if the file doesn't exist (or can't be read).
fun! ForceLoadLocalView()
	if(DoesLocalViewFileExist())
		execute "so " . GetLocalViewFile()
		if(&verbose >= s:VerboseThreshold && s:VerboseThreshold != -1)
			echo "Ok. Loaded local view from file " . GetLocalViewFile()
		endif
	elseif(&verbose >= s:VerboseThreshold && s:VerboseThreshold != -1)
		echo "Ok. local view file does not exist: " . GetLocalViewFile()
	endif
endfunction

"If local views are enabled (as returned by IsLocalViewEnabled), then this
"function delegates to ForceMakeLocalView to save the current view to the
"file.
fun! TryMakeLocalView()
	if(IsLocalViewEnabled())
		call ForceMakeLocalView()
	endif
endfunction

"If local views are enabled, load the view from it with ForceLoadLocalView.
fun! TryLoadLocalView()
	if(IsLocalViewEnabled())
		call ForceLoadLocalView()
	endif
endfunction

"Ensures that local views are enabled, and then makes one with
"ForceMakeLocalView
fun! MakeLocalView()
	call EnableLocalView()
	call ForceMakeLocalView()
endfunction

"Ensures that local views are enabled, then makes loads it with
"ForceLoadLocalView
fun! LoadLocalView()
	call EnableLocalView()
	call ForceLoadLocalView()
endfunction

"To be called, for instance, when a buffer is first read: it checks to see if
"the local view file exists (which will likely be the default one if it's just
"being read), and if so, calls LoadLocalView() to enable local views, and load
"the file.
fun! InitLocalView()
	if(DoesLocalViewFileExist())
		call LoadLocalView()
	else
		"Try it without the leading dot
		let file=GetAlternateLocalViewFile()
		if(filereadable(file))
			"Use this as the file
			call SetLocalViewFile(file)
			"Load it and enable views.
			call LoadLocalView()
		endif
	endif
endfunction

"Sets the value of the local view file property to the alternate file (i.e.,
"one that will not be hidden). Does not load or make, or enable.
fun! UseAlternateLocalViewFile()
	call SetLocalViewFile(GetAlternateLocalViewFile())
endfunction

"Prints the status of the local view for this buffer
fun! LocalView()
	echo "Local view filing is " . (IsLocalViewEnabled()?"enabled":"disabled")
	echo "Local view file is " . GetLocalViewFile()
endfunction

"Resets the stored local view file to the default value
fun! ResetLocalView()
	call SetLocalViewFile(GetDefaultLocalViewFile())
endfunction


if !exists(":Enablelocalview")
	command Enablelocalview	call EnableLocalView()
endif
if !exists(":Enlocalview")
	command Enlocalview	Enablelocalview
endif
if !exists(":Enlocview")
	command Enlocview	Enablelocalview
endif
if !exists(":Enlv")
	command Enlv	Enablelocalview
endif

if !exists(":Disablelocalview")
	command Disablelocalview	call DisableLocalView()
endif
if !exists(":Dislocalview")
	command Dislocalview	Disablelocalview
endif
if !exists(":Dislocview")
	command Dislocview	Disablelocalview
endif
if !exists(":Dislv")
	command Dislv	Disablelocalview
endif

if !exists(":Mklocalview")
	command Mklocalview	call MakeLocalView()
endif
if !exists(":Mklv")
	command Mklv	Mklocalview
endif
if !exists(":Mklocview")
	command Mklocview	Mklocalview
endif

if !exists(":Loadlocalview")
	command Loadlocalview	call LoadLocalView()
endif
if !exists(":Ldlocalview")
	command Ldlocalview	Loadlocalview
endif
if !exists(":Loadlv")
	command Loadlv	Loadlocalview
endif
if !exists(":Ldlv")
	command Ldlv	Loadlocalview
endif
if !exists(":Loadlocview")
	command Loadlocview	Loadlocalview
endif
if !exists(":Ldlocview")
	command Ldlocview	Loadlocalview
endif

if !exists(":Setlocalview")
	command -nargs=1	Setlocalview	call SetLocalViewFile(<args>)
endif

if !exists(":Uselocalviewalt")
	command Uselocalviewalt	call UseAlternateLocalViewFile()
endif
if !exists(":Uselvalt")
	command Uselvalt	call UseAlternateLocalViewFile()
endif

if !exists(":LocalView")
	command LocalView	call LocalView()
endif

augroup localview

	autocmd! BufWritePost * call TryMakeLocalView()
	autocmd! BufReadPost * call InitLocalView()

augroup end


