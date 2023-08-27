syn region	xmlTag		start=+<\s*\%(circle\|ellipse\|line\|path\|poly\%(gon\|line\)\|rect\|text\%(path\)\?\|tref\|tspan\)\s+   end=+>+ fold contains=xmlTagName,xmlAttrib,xmlEqual,xmlString,@xmlStartTagHook,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,svgAttrib
syn keyword	svgAttrib	contained containedin=xmlTag nextgroup=svgColor fill color stroke sop-color flood-color lighting-color
syn match	svgColor	contained +="[^"]\+"+
syn match	svgColor	contained +='[^']\+'+

hi def link svgAttrib	Type
hi def link svgColor	String

call css_color#init('css', 'extended', 'svgColor')
