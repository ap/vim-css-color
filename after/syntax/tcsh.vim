syn match tcshCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=tcshComment
call css_color#init( 'hex', 'none'
	\, 'tcshSQuote,tcshDQuote,tcshHereDoc,'
	\. 'tcshCommentColor' )
