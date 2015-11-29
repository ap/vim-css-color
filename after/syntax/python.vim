" Language:     Colorful CSS Color Preview
" Author:       DanCardin <ddcardin@gmail.com>

if !( has('gui_running') || &t_Co==256 ) | finish | endif

call css_color#init('css', 'extended', 'pythonComment,pythonString')
