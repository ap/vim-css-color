syn match shCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=shQuickComment,shBQComment,shComment
call css_color#init('hex', 'none',
	\ 'shCommentColor,' .
	\ 'shEchoQuote,shEmbeddedEcho,shEcho,' .
	\ 'shTestSingleQuote,shTestDoubleQuote,' .
	\ 'shSingleQuote,shDoubleQuote,shHereDoc')
