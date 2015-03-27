" Vim color file
" Modified by:	Brian Mearns <bmearns@ieee.org>
" Modified from:desert
" Original:
" Maintainer:	Hans Fugal <hans@fugal.net>
" Last Change:	$Date: 2008/06/25 01:09:16 $
" Last Change:	$Date: 2008/06/25 01:09:16 $
" URL:		http://hans.fugal.net/vim/colors/desert.vim
" Version:	$Id: mearns_desert.vim,v 1.1 2008/06/25 01:09:16 mearns Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="mearns_desert"

hi Normal	guifg=#D0D0D0 guibg=#262636

"Set color column to 79, to highlight where you should stop typing.
set colorcolumn=79
hi ColorColumn guibg=#462828

"For Vimoutliner. Replace that hideous green that I can barely see.
hi BT1	guifg=#D0D0D0 guibg=#262636
hi BT2	guifg=#D0D0D0 guibg=#262636
hi BT3	guifg=#D0D0D0 guibg=#262636
hi BT4	guifg=#D0D0D0 guibg=#262636
hi BT5	guifg=#D0D0D0 guibg=#262636
hi BT6	guifg=#D0D0D0 guibg=#262636
hi BT7	guifg=#D0D0D0 guibg=#262636
hi BT8	guifg=#D0D0D0 guibg=#262636
hi BT9	guifg=#D0D0D0 guibg=#262636

hi OL4 guifg=violet ctermfg=magenta

" highlight groups
hi Cursor	guibg=khaki guifg=slategrey gui=bold
hi CursorLine term=none guibg=Gray25
hi CursorColumn term=none guibg=Gray25
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=grey60 guifg=grey20 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
hi LineNr	guifg=grey
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guibg=grey60 guifg=darkblue gui=none
hi StatusLineNC	guibg=grey60 guifg=grey20 gui=none
hi Title	guifg=indianred
hi Visual	gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment	guifg=SkyBlue
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=palegreen
hi Statement	guifg=#d0c055
hi PreProc	guifg=indianred
hi Type		guifg=darkkhaki
hi Special	guifg=navajowhite
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		gui=bold guifg=#C05000 guibg=#DDDD66

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=3
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=darkcyan
hi Constant	ctermfg=brown
hi Special	ctermfg=5
hi Identifier	ctermfg=6
hi Statement	ctermfg=3
hi PreProc	ctermfg=5
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1

hi diffRemoved	cterm=NONE ctermfg=1* guibg=#663333
hi diffAdded	cterm=NONE ctermfg=2* guibg=#336633

hi diffFile	    cterm=NONE ctermfg=6* guibg=#CCCCAA guifg=#666600 gui=italic
hi diffOldFile	cterm=NONE ctermfg=6* guibg=#CCCCAA guifg=#990000 gui=italic
hi diffNewFile	cterm=NONE ctermfg=6* guibg=#CCCCAA guifg=#009900 gui=italic
hi diffHeader	    cterm=NONE ctermfg=6* guifg=#AAAA99 guibg=#CCCCAA gui=italic
hi diffLine	    cterm=NONE ctermfg=6* guifg=white guibg=#999900 gui=italic
hi diffSubnameLeft  guifg=#990000 guibg=#999900 gui=italic
hi diffSubnameRight  guifg=#009900 guibg=#999900 gui=italic



"vim: sw=4
