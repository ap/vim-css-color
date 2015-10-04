" Language:     Colorful CSS Color Preview
" Author:       Greg Werbin <ourobourbon@gmail.com>

if !( has('gui_running') || &t_Co==256 ) | finish | endif

call css_color#init('hex', 'extended', 'javaScriptComment,javaScriptLineComment,javaScriptStringS,javaScriptStringD')
