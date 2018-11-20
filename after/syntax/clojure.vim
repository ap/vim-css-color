let type = 'hex'
let keywords = 'none'

let isCljs = expand('%:e') == 'cljs'
if isCljs
    " clojurescript
    let type = 'css'
    let keywords = 'extended'
endif

call css_color#init(type, keywords, 'clojureComment,clojureString')
