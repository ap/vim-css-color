" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>

if !( has('gui_running') || has('nvim') || &t_Co==256 ) | finish | endif

call css_color#init('css', 'none', 'jsonString')
