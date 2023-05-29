" default html syntax should already be including the css syntax
" but tag style attributes don't properly apply CSS syntax (as of vim 9.0.1378).
" Correct the bug by replacing htmlCssDefinition with a new htmlCssContent: {{{
syn keyword htmlCssArg		contained containedin=htmlTag nextgroup=htmlCssEq style
syn match htmlCssEq		contained +=+ nextgroup=htmlCssQuote
syn match htmlCssQuote		contained +["']+ nextgroup=htmlCssContent
syn region htmlCssContent	contained start=+\%("\)\@<=.+ end=+"+ keepend contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssFunction,cssUnicodeEscape,cssVendor,cssHacks,cssNoise
syn region htmlCssContent	contained start=+\%('\)\@<=.+ end=+'+ keepend contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssFunction,cssUnicodeEscape,cssVendor,cssHacks,cssNoise

hi def link htmlCssArg		htmlArg
hi def link htmlCssEq		htmlTag
hi def link htmlCssQuote	htmlString
" end bugfix }}}

" Legacy HTML 3-style color declarations (depcecated) {{{
" Search https://www.w3.org/TR/html4/index/attributes.html for `%Color;`
" Technically, these must be named or #RRGGBB, but both FF and Chrome simply
" map it to CSS, supporting #RGB, #RGBA, and #RRGGBBAA (though alpha is ignored)
syn region  htmlTag		start=+<\s*body\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlTagBodyColors
syn keyword htmlTagBodyColors	contained nextgroup=htmlLegacyColor text bgcolor link alink vlink
syn region  htmlTag		start=+<\s*\%(table\|t[rdh]\)\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlBgColors
syn keyword htmlBgColors	contained nextgroup=htmlLegacyColor bgcolor
syn region  htmlTag		start=+<\s*\%(base\)\?font\s+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,htmlFgColors
syn keyword htmlFgColors	contained nextgroup=htmlLegacyColor color
syn region htmlLegacyColor	contained start=+="+ end=+"+ contains=cssColor
syn region htmlLegacyColor	contained start=+='+ end=+'+ contains=cssColor

hi def link htmlTagBody		htmlTagName
hi def link htmlTagBodyColors	htmlArg
hi def link htmlBgColors	htmlArg
hi def link htmlFgColors	htmlArg
" end legacy HTML-3 color attributes }}}

" apply colors within HTML style attributes, legacy HTML-3 attributes, and comments
call css_color#init('none', 'none', 'htmlCssContent,htmlLegacyColor,htmlCommentPart')
