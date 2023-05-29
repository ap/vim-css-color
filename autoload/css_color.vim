" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>
" Commit:       $Format:%H$
" Licence:      The MIT License (MIT)

if ! ( v:version >= 700 && has('syntax') && ( has('gui_running') || has('nvim') || &t_Co == 256 ) )
	function! css_color#init(type, keywords, groups)
	endfunction
	function! css_color#extend(groups)
	endfunction
	finish
endif

let s:_invalid = -9999 " used after bounding/wrapping, so this is safe

" Add open-parens as a keyword char to avoid coloring function names like tan().
" This is ... not advised; it's unclear what it might break
"syn iskeyword @,40,48-57,_,192-255,-

function! s:bound(n, min, max)
	let n = a:n
	if     n < a:min | let n = a:min
	elseif n > a:max | let n = a:max | endif
	return str2nr( string(n + 0.5) )
endfunction

function! s:rgb2hex(r, g, b)
	let [r,g,b] = map( [a:r,a:g,a:b], 's:bound(v:val, 0, 255)' )
	return printf( '%02x%02x%02x', r, g, b )
endfunction

function! s:rgb2color(r,g,b)
	" Convert 35.6% -> 90.78, 80% -> 204, 100% -> 255, etc.
	let [r,g,b] = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? str2float(v:val) * 2.55 : str2float(v:val)' )
	return s:rgb2hex(r, g, b)
endfunction

" Vimscript modulo can't handle decimals. Fix that.
function! s:modulo(a, b)
	let num = str2nr( string(a:a) )
	let extra = a:a - num
	return str2nr(a:a - extra) % a:b + extra
endfunction

function! s:angle2deg(angle, units)
	let deg = str2float(a:angle)
	" angles: https://developer.mozilla.org/en-US/docs/Web/CSS/angle
	if a:units == "rad"
		let deg = deg * 57.29577951308232  " deg = rad * 180 / pi, 360deg == 6.2832rad
	elseif a:units == "grad"
		let deg = deg * 0.9                " 360deg = 400grad
	elseif a:units == "turn"
		let deg = deg * 360.0              " 360deg = 1turn
	elseif a:units != "" && a:units != "deg"
		return s:_invalid                  " percent is invalid here
	endif
	let deg = s:modulo(deg, 360)
	if deg < 0 | let deg = deg + 360 | endif
	return deg
endfunction

function! s:hsl2rgb(h,u,s,l)
	let [s,l] = map( [a:s, a:l], 'str2nr(v:val) >= 1 ? 1.0 : str2float(v:val)' )
	" algorithm transcoded to vim from http://www.w3.org/TR/css3-color/#hsl-color
	let hh = s:angle2deg(a:h, a:u)
	if hh == s:_invalid | return [hh,hh,hh] | endif
	let hh = hh / 360.0
	let m2 = l <= 0.5 ? l * ( s + 1 ) : l + s - l * s
	let m1 = l * 2 - m2
	let rgb = []
	for h in [ hh + (1/3.0), hh, hh - (1/3.0) ]
		let h = h < 0 ? h + 1 : h > 1 ? h - 1 : h
		let v =
			\ h * 6 < 1 ? m1 + ( m2 - m1 ) * h * 6 :
			\ h * 2 < 1 ? m2 :
			\ h * 3 < 2 ? m1 + ( m2 - m1 ) * ( 2/3.0 - h ) * 6 :
			\ m1
		if v > 1.0 | return [s:_invalid, s:_invalid, s:_invalid] | endif
		let rgb += [ float2nr( 255 * v ) ]
	endfor
	return rgb
endfunction

function! s:pctvet(h,s,l)
	" for hsl & hwb, hue cannot be a percent, the others must be percents.
	if a:h =~ "%$" || a:s !~ "%$" || a:l !~ "%$"
		return [s:_invalid, s:_invalid, s:_invalid]
	endif
	let [s,l] = map( [a:s, a:l], 'v:val >= 100 ? 1.0 : v:val / 100.0' )
	return [a:h, s, l]
endfunction

function! s:hsl2color(h,u,s,l)
	let [h,s,l] = s:pctvet(a:h, a:s, a:l) " convert saturation & luminance % -> num
	if h == s:_invalid | return '' | endif
	let [r,g,b] = s:hsl2rgb(h, a:u, s, l)
	if r == s:_invalid | return '' | endif
	return s:rgb2hex(r, g, b)
endfunction

function! s:hwb2color(h,u,w,b)
	let [h,w,b] = s:pctvet(a:h, a:w, a:b) " convert whiteness & blackness % -> num
	if h == s:_invalid | return '' | endif
	" algorithm transcoded to vim from https://drafts.csswg.org/css-color/#hwb-to-rgb
	if w + b >= 1
		let gray = w / (w + b)
		let [r,g,b] = [gray,gray,gray]
	else
		let [r,g,b] = map( s:hsl2rgb(a:h, a:u, 1.0, 0.5), 'v:val * (1 - w - b) + w' )
	endif
	return s:rgb2hex(r, g, b)
endfunction

" TODO (probably not): new "device-independent colors":
" lch(), oklch(), lab(), oklab(), and color().
" These look hard and I don't see reference algorithms to convert to sRGB.
" https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
" https://drafts.csswg.org/css-color/#lab-colors

let s:_1_3 = 1.0/3
let s:_16_116 = 16.0/116.0
let s:cos16 = cos(16*(180/atan2(0,-1)))
let s:sin16 = sin(16*(180/atan2(0,-1)))

function s:rgb2din99(rgb)
	let [r,g,b] = map( copy(a:rgb), 'v:val > 0.04045 ? pow((v:val + 0.055) / 1.055, 2.4) : v:val / 12.92' )

	let x = r * 0.4124 + g * 0.3576 + b * 0.1805
	let y = r * 0.2126 + g * 0.7152 + b * 0.0722
	let z = r * 0.0193 + g * 0.1192 + b * 0.9505

	" Observer 2°, Illuminant D65
	let x = ( x * 100 ) /  95.0489
	let z = ( z * 100 ) / 108.8840

	let [x,y,z] = map( [x,y,z], 'v:val > 0.008856 ? pow(v:val, s:_1_3) : 7.787 * v:val + s:_16_116' )

	let [L,a,b] = [ (116 * y) - 16, 500 * (x - y), 200 * (y - z) ]

	let L99 = 105.51 * log(1 + 0.0158 * L)

	let e =        a * s:cos16 + b * s:sin16
	let f = 0.7 * (b * s:cos16 - a * s:sin16)

	let g = 0.045 * sqrt(e*e + f*f)
	if g == 0
		let [a99, b99] = [0.0, 0.0]
	else
		let k = log(1 + g) / g
		let a99 = k * e
		let b99 = k * f
	endif

	return [L99, a99, b99]
endfunction

let s:hex={}
for i in range(0, 255)
	let s:hex[ printf( '%02x', i ) ] = i
endfor

let s:exe=[]
function! s:flush_exe()
	if len(s:exe) | exe join( remove( s:exe, 0, -1 ), ' | ' ) | endif
endfunction

if has('gui_running')
	function! s:create_highlight(color, is_bright)
		call add( s:exe, 'hi BG'.a:color.' guibg=#'.a:color.' guifg=#'.( a:is_bright ? '000000' : 'ffffff' ) )
	endfunction
else
	" the 16 vt100 colors are not defined consistently
	let s:xtermcolor = repeat( [''], 16 )

	" the 6 values used in the xterm color cube
	"                    0    95   135   175   215   255
	let s:cubergb = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]
	for s:rrr in s:cubergb
		for s:ggg in s:cubergb
			for s:bbb in s:cubergb
				call add( s:xtermcolor, [ s:rrr, s:ggg, s:bbb ] )
			endfor
		endfor
	endfor

	" grayscale ramp
	let s:xtermcolor += map( range(24), 'repeat( [10 * v:val + 8], 3 )' )

	for idx in range( 16, len(s:xtermcolor) - 1 )
		let s:xtermcolor[idx] = s:rgb2din99( map(s:xtermcolor[idx], 'v:val / 255.0') )
	endfor

	" selects the nearest xterm color for a rgb value like #FF0000
	function! s:rgb2xterm(color)
		let best_match=0
		let smallest_distance = 10000000000
		let color = tolower(a:color)
		let r = s:hex[color[0:1]]
		let g = s:hex[color[2:3]]
		let b = s:hex[color[4:5]]

		let [L1,a1,b1] = s:rgb2din99([ r/255.0, g/255.0, b/255.0 ])

		for idx in range( 16, len(s:xtermcolor) - 1 )
			let [L2,a2,b2] = s:xtermcolor[idx]
			let dL = L1 - L2
			let da = a1 - a2
			let db = b1 - b2
			let distance = dL*dL + da*da + db*db
			if distance == 0 | return idx | endif
			if distance > smallest_distance | continue | endif
			let smallest_distance = distance
			let best_match = idx
		endfor
		return best_match
	endfunction

	let s:color_idx = {}
	function! s:create_highlight(color, is_bright)
		let color_idx = get( s:color_idx, a:color, -1 )
		if color_idx == -1
			let color_idx = s:rgb2xterm(a:color)
			let s:color_idx[a:color] = color_idx
		endif
		call add( s:exe,
			\   'hi BG'.a:color
			\ . ' guibg=#' .a:color  .' guifg=#' .( a:is_bright ? '000000' : 'ffffff' )
			\ . ' ctermbg='.color_idx.' ctermfg='.( a:is_bright ? 0 : 15 )
			\ )
	endfunction
endif

function! s:recreate_highlights()
	call filter( copy( b:css_color_hi ), 's:create_highlight( v:key, v:val )' )
endfunction

let s:pattern_color = {}
let s:color_bright  = {}
function! s:create_syn_match()

	let pattern = submatch(0)

	if has_key( b:css_color_syn, pattern ) | return | endif
	let b:css_color_syn[pattern] = 1

	let rgb_color = get( s:pattern_color, pattern, '' )

	if ! strlen( rgb_color )
		let hex = submatch(1)
		let funcname = submatch(2)

		if funcname =~ 'rgb' && submatch(4) != '' | return '' | endif " rgb() doesn't support units

		let rgb_color
			\ = funcname =~ '^rgb' ? s:rgb2color(submatch(3),submatch(5),submatch(6))
			\ : funcname =~ '^hsl' ? s:hsl2color(submatch(3),submatch(4),submatch(5),submatch(6))
			\ : funcname == 'hwb' ? s:hwb2color(submatch(3),submatch(4),submatch(5),submatch(6))
			\ : strlen(hex) >= 6  ? tolower(hex[0:5])
			\ : strlen(hex) >= 3  ? tolower(hex[0].hex[0].hex[1].hex[1].hex[2].hex[2])
			\ : ''

		if rgb_color == '' | return '' | endif
		let s:pattern_color[pattern] = rgb_color
	endif

	if ! has_key( b:css_color_hi, rgb_color )
		let is_bright = get( s:color_bright, rgb_color, -1 )
		if is_bright == -1
			let r = s:hex[rgb_color[0:1]]
			let g = s:hex[rgb_color[2:3]]
			let b = s:hex[rgb_color[4:5]]
			let is_bright = r*30 + g*59 + b*11 > 12000
			let s:color_bright[rgb_color] = is_bright
		endif

		call s:create_highlight( rgb_color, is_bright )
		let b:css_color_hi[rgb_color] = is_bright
	endif

	" iff pattern ends on word character, require word break to match
	if pattern =~ '\>$' | let pattern .= '\>' | endif
	call add( s:exe, 'syn match BG'.rgb_color.' /'.escape(pattern, '/').'/ contained containedin=@colorableGroup' )

	return ''
endfunction

function! s:clear_matches()
	call map(get(w:, 'css_color_match_id', []), 'matchdelete(v:val)')
	let w:css_color_match_id = []
endfunction

function! s:create_matches()
	call s:clear_matches()
	if ! &l:cursorline | return | endif
	" adds matches based that duplicate the highlighted colors on the current line
	let lnr = line('.')
	let group = ''
	let groupstart = 0
	let endcol = &l:synmaxcol ? &l:synmaxcol : col('$')
	for col in range( 1, endcol )
		let nextgroup = col < endcol ? synIDattr( synID( lnr, col, 1 ), 'name' ) : ''
		if group == nextgroup | continue | endif
		if group =~ '^BG\x\{6}$'
			let regex = '\%'.lnr.'l\%'.groupstart.'c'.repeat( '.', col - groupstart )
			let w:css_color_match_id += [ matchadd( group, regex, -1 ) ]
		endif
		let group = nextgroup
		let groupstart = col
	endfor
endfunction

let s:_hexcolor   = '#\(\x\{3}\%(\>\|\x\{3}\>\)\)' " submatch 1
let s:_rgbacolor  = '#\(\x\{3}\%(\>\|\x\%(\>\|\x\{2}\%(\>\|\x\{2}\>\)\)\)\)' " submatch 1
let s:_funcname   = '\(rgb\a\?\|hsla\?\|hwb\)' " submatch 2
let s:_consistent = '\%(\%(\s\+[0-9.%]\+\)\{2}\s*\%(\/\s*[-0-9.%]\+\)\?[)]\|\%(\s*,\s*[-0-9.%]\+\)\{2,3}[)]\)\@=' " lookahead: 1 2 3 or 1 2 3/4 or 1,2,3 or 1,2,3,4 after 1
let s:_ws_        = '\s*'
let s:_numval     = '\(-\?\d\{1,3}\%(\.\d*\)\?%\?\)' " submatch 3,5,6
let s:_units      = '\(deg\|g\?rad\|turn\)\?' " submatch 4
let s:_listsep    = s:_ws_ . '[,[:space:]]\+'
let s:_otherargs_ = s:_ws_ . '\%([,\/][^)]*\)\?' " ignore alpha
let s:_funcexpr   = s:_funcname . '[(]' . s:_ws_ . s:_numval . s:_units . s:_consistent . s:_listsep . s:_numval . s:_listsep . s:_numval . s:_otherargs_ . '[)]'
let s:_csscolor   = s:_rgbacolor . '\|' . s:_funcexpr
" N.B. sloppy heuristic constants for performance reasons:
"      a) start somewhere left of screen in case of partially visible colorref
"      b) take some multiple of &columns to handle multibyte chars etc
" N.B. these substitute() calls are here just for the side effect
"      of invoking s:create_syn_match during substitution -- because
"      match() and friends do not allow finding all matches in a single
"      scan without examining the start of the string over and over
function! s:parse_screen()
	let leftcol = winsaveview().leftcol
	let left = max([ leftcol - 15, 0 ])
	let width = &columns * 4
	call filter( range( line('w0'), line('w$') ), 'substitute( strpart( getline(v:val), col([v:val, left]), width ), b:css_color_pat, ''\=s:create_syn_match()'', ''g'' )' )
	call s:flush_exe()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! css_color#reinit()
	call s:recreate_highlights()
	call s:flush_exe()
endfunction

function! css_color#enable()
	if ! b:css_color_off | return | endif
	if len( b:css_color_grp ) | exe 'syn cluster colorableGroup add=' . join( b:css_color_grp, ',' ) | endif
	augroup CSSColor
		autocmd! * <buffer>
		if has('nvim-0.3.1')
			autocmd CursorMoved,CursorMovedI <buffer> call s:parse_screen()
		else
			autocmd CursorMoved,CursorMovedI <buffer> call s:parse_screen() | call s:create_matches()
			autocmd BufWinEnter <buffer> call s:create_matches()
			autocmd BufWinLeave <buffer> call s:clear_matches()
		endif
		autocmd ColorScheme <buffer> call css_color#reinit()
	augroup END
	let b:css_color_off = 0
	doautocmd CSSColor CursorMoved
endfunction

function! css_color#disable()
	if b:css_color_off | return | endif
	if len( b:css_color_grp ) | exe 'syn cluster colorableGroup remove=' . join( b:css_color_grp, ',' ) | endif
	autocmd! CSSColor * <buffer>
	let b:css_color_off = 1
endfunction

function! css_color#toggle()
	if b:css_color_off | call css_color#enable()
	else               | call css_color#disable()
	endif
endfunction

let s:type         = [ 'none', 'hex', 'rgba', 'css', 'none' ] " with wraparound for index() == -1
let s:pat_for_type = [ '^$', s:_hexcolor, s:_rgbacolor, s:_csscolor, '^$' ]

function! css_color#init(type, keywords, groups)
	let new_type = index( s:type, a:type )
	let old_type = index( s:pat_for_type, get( b:, 'css_color_pat', '$^' ) )

	let b:css_color_pat = s:pat_for_type[ max( [ old_type, new_type ] ) ]
	let b:css_color_grp = extend( get( b:, 'css_color_grp', [] ), split( a:groups, ',' ), 0 )
	let b:css_color_hi  = {}
	let b:css_color_syn = {}
	let b:css_color_off = 1

	call css_color#enable()

	if a:keywords != 'none'
		exe 'syntax include syntax/colornames/'.a:keywords.'.vim'
		call extend( s:color_bright, b:css_color_hi )
	endif
endfunction

" utility function for development use
function! css_color#dump_highlights()
	call s:recreate_highlights()
	let cmd = join( sort( remove( s:exe, 0, -1 ) ),  "\n" )
	let cmd = substitute( cmd, '#......', '\U&', 'g' )
	let cmd = substitute( cmd, 'ctermbg=\zs\d\+', '\=printf("%-3d",submatch(0))', 'g' )
	return cmd
endfunction
