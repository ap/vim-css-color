" default html syntax should already be including the css syntax
" but tag style attributes don't properly apply CSS syntax (as of vim 9.0.1378).
" Correct the bug by replacing htmlCssDefinition with a new htmlCssContent: {{{
syn keyword	htmlCssArg	contained containedin=htmlTag nextgroup=htmlCssEq style
syn match	htmlCssEq	contained +=+ nextgroup=htmlCssQuote
syn match	htmlCssQuote	contained +["']+ nextgroup=htmlCssContent
syn region	htmlCssContent	contained start=+\%("\)\@<=.+ end=+"+ keepend contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssFunction,cssUnicodeEscape,cssVendor,cssHacks,cssNoise
syn region	htmlCssContent	contained start=+\%('\)\@<=.+ end=+'+ keepend contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssFunction,cssUnicodeEscape,cssVendor,cssHacks,cssNoise

hi def link htmlCssArg		htmlArg
hi def link htmlCssEq		htmlTag
hi def link htmlCssQuote	htmlString
" end bugfix }}}

call css_color#init('css', 'extended', 'htmlCssContent,htmlCommentPart')

" SVG in HTML
"syn keyword	htmlTagName	contained svg text textPath tspan
syn include	@htmlSvgColors	after/syntax/svg.vim
syn region	htmlSvg		start=+<\s*svg\>+  end=+<\s*/svg\s*>+ keepend contains=@htmlXml,htmlTagName,@htmlSvgColors

" Legacy HTML 3-style color declarations (depcecated) {{{
" Search https://www.w3.org/TR/html4/index/attributes.html for `%Color;`
syn region	htmlTag		start=+<\s*body\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlTagBodyColors
syn keyword htmlTagBodyColors	contained nextgroup=htmlLegacyColor text bgcolor link alink vlink
syn region	htmlTag		start=+<\s*\%(table\|t[rdh]\)\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlBgColors
syn keyword htmlBgColors	contained nextgroup=htmlLegacyColor bgcolor
syn region	htmlTag		start=+<\s*\%(base\)\?font\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlFgColors
syn keyword	htmlFgColors	contained nextgroup=htmlLegacyColor color
" The spec only supports named colors & hash-prefixed RGB hex with 3 or 6 chars.
" (Both FF & Chrome use IE's crazy "flex hex" formula to convert anything else to hex:
" https://scrappy-do.blogspot.com/2004/08/little-rant-about-microsoft-internet.html -- we're NOT doing that.)
" BUG: I should have been able to specify this as  +="[^"]\+"+  and  +="[^"]\+"+  and set what
" matches with the args to css_color#init(), but that doesn't seem to work (overridden?)
syn match htmlLegacyColor	contained +=\(['"]\)\%(#\x\{3\}\%(\x\{3\}\)\?\|[A-Za-z]\+\)\1+ contains=cssColor

hi def link htmlTagBodyColors	htmlArg
hi def link htmlBgColors	htmlArg
hi def link htmlFgColors	htmlArg

call css_color#init('hex', 'extended', 'htmlLegacyColor')
" end legacy HTML-3 color attributes }}}