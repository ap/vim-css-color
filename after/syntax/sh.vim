syn match shCommentColor contained '\(#[^#]*\)\@<=\zs#\x\{3}\%(\x\{3}\)\?\>' containedin=shQuickComment,shBQComment,shComment
call css_color#init( 'hex', 'none'
	\, 'shSingleQuote,shDoubleQuote,shHereDoc,'
	\. 'shTestSingleQuote,shTestDoubleQuote,'
	\. 'shEchoQuote,shEmbeddedEcho,shEcho,'
	\. 'shCommentColor' )
