if exists('g:loaded_css_color')
  finish
endif
let g:loaded_css_color = 1

let s:save_cpo = &cpo
set cpo&vim

command! -bar -bang CssColorEnable    call css_color#enable(<bang>0)
command! -bar -bang CssColorDisable   call css_color#disable(<bang>0)
command! -bar -bang CssColorToggle    call css_color#toggle(<bang>0)

function! css_color#init(type, keywords, groups)
	if css_color#is_disabled() | return | endif
  call css_color#_init(a:type, a:keywords, a:groups)
endfunction

function! css_color#is_disabled()
	return get( b:, 'css_color_off',
				\get( g:, 'css_color_disabled',
				\get( g:, 'css_color_disabled_at_start', 0 ) ) )
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
