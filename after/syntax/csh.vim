syn match cshCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=cshComment
call css_color#init('hex', 'none',
	\ 'cshCommentColor,' .
	\ 'cshDblQuote,cshSnglQuote,cshHereDoc')
