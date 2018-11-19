let [type, keywords] = expand('%:e') ==? 'cljs' ? ['css', 'extended'] : ['hex', 'none']
call css_color#init(type, keywords, 'clojureComment,clojureString')
