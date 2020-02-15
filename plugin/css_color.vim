if exists('g:loaded_css_color')
	finish
endif
let g:loaded_css_color = 1

let s:save_cpo = &cpo
set cpo&vim

command! -bar -bang CssColorEnable    call css_color#enable(<bang>0)
command! -bar -bang CssColorDisable   call css_color#disable(<bang>0)
command! -bar -bang CssColorToggle    call css_color#toggle(<bang>0)

if !exists('g:css_color_global')
	let g:css_color_global = 1
endif

function! css_color#init(type, keywords, groups)
	if g:css_color_global
		call css_color#_init(a:type, a:keywords, a:groups)
	endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: noet sw=2 ts=2 sts=2
