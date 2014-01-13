" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>

if !( has('gui_running') || &t_Co==256 ) | finish | endif

" default html syntax should already be including the css syntax
syn cluster colorableGroup add=htmlString,htmlCommentPart
