" https://github.com/dag/vim-fish (and presumably its various forks)
syn match fishCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=fishComment
call css_color#init( 'hex', 'none', 'fishCommentColor,fishString' )
