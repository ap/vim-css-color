" Language:     Colorful CSS Color Preview
" Author:       Greg Werbin <ourobourbon@gmail.com>

" ft=coffee includes javascript, but mostly sets up own syntax groups
" so until it has specific support there's no point in loading anyway
" and for some reason the W3C syntax color keywords break its highlighting
" (this refers to the https://github.com/kchmck/vim-coffee-script plugin)
if &filetype == 'coffee' | finish | endif

call css_color#init('hex', 'extended', 'javaScriptComment,javaScriptLineComment,javaScriptStringS,javaScriptStringD')
