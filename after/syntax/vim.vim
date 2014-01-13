" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>

if !( has('gui_running') || &t_Co==256 ) | finish | endif

syn cluster colorableGroup contains=vimHiGuiRgb,vimComment,vimLineComment

let b:has_color_hi    = {}
let b:has_pattern_syn = {}
let b:color_match_id  = []
autocmd CursorMoved,CursorMovedI <buffer> call css_color#parse_any_screen()
