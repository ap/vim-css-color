syn match zshCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=zshComment
call css_color#init('hex', 'none',
	\ 'zshCommentColor,' .
	\ 'zshString,zshPOSIXString,zshHereDoc')
