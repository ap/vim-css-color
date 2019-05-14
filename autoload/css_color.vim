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

function! s:rgb2color(r,g,b)
	" Convert 80% -> 204, 100% -> 255, etc.
	let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
	return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:hsl2color(h,s,l)
	" Convert 80% -> 0.8, 100% -> 1.0, etc.
	let [s,l] = map( [a:s, a:l], 'v:val =~ "%$" ? v:val / 100.0 : v:val + 0.0' )
	" algorithm transcoded to vim from http://www.w3.org/TR/css3-color/#hsl-color
	let hh = ( a:h % 360 ) / 360.0
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
		if v > 1.0 | return '' | endif
		let rgb += [ float2nr( 255 * v ) ]
	endfor
	return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

let s:hex={}
for i in range(0, 255)
	let s:hex[ printf( '%02x', i ) ] = i
endfor

if has('gui_running')
	function! s:create_highlight(color, is_bright)
		exe 'hi BG'.a:color 'guibg=#'.a:color 'guifg=#'.( a:is_bright ? '000000' : 'ffffff' )
	endfunction
else
	" preset 16 vt100 colors
	let s:xtermcolor = [
		\ [ 0x00, 0x00, 0x00,  0 ],
		\ [ 0xCD, 0x00, 0x00,  1 ],
		\ [ 0x00, 0xCD, 0x00,  2 ],
		\ [ 0xCD, 0xCD, 0x00,  3 ],
		\ [ 0x00, 0x00, 0xEE,  4 ],
		\ [ 0xCD, 0x00, 0xCD,  5 ],
		\ [ 0x00, 0xCD, 0xCD,  6 ],
		\ [ 0xE5, 0xE5, 0xE5,  7 ],
		\ [ 0x7F, 0x7F, 0x7F,  8 ],
		\ [ 0xFF, 0x00, 0x00,  9 ],
		\ [ 0x00, 0xFF, 0x00, 10 ],
		\ [ 0xFF, 0xFF, 0x00, 11 ],
		\ [ 0x5C, 0x5C, 0xFF, 12 ],
		\ [ 0xFF, 0x00, 0xFF, 13 ],
		\ [ 0x00, 0xFF, 0xFF, 14 ],
		\ [ 0xFF, 0xFF, 0xFF, 15 ]]
	" grayscale ramp
	let s:xtermcolor += map(range(24),'repeat([10*v:val+8],3) + [v:val+232]')

	" the 6 values used in the xterm color cube
	"                    0    95   135   175   215   255
	let s:cubergb = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]

	" 0..255 mapped to 0..5 based on the color cube values
	let s:xvquant = repeat([0],48)
				\ + repeat([1],68)
				\ + repeat([2],40)
				\ + repeat([3],40)
				\ + repeat([4],40)
				\ + repeat([5],20)
	" tweak the mapping for the exact matches (0 and 1 already correct)
	let s:xvquant[s:cubergb[2]] = 2
	let s:xvquant[s:cubergb[3]] = 3
	let s:xvquant[s:cubergb[4]] = 4
	let s:xvquant[s:cubergb[5]] = 5

	" selects the nearest xterm color for a rgb value like #FF0000
	function! s:rgb2xterm(color)
		let best_match=0
		let smallest_distance = 10000000000
		let color = tolower(a:color)
		let r = s:hex[color[0:1]]
		let g = s:hex[color[2:3]]
		let b = s:hex[color[4:5]]

		let vr = s:xvquant[r]
		let vg = s:xvquant[g]
		let vb = s:xvquant[b]
		let cidx = vr * 36 + vg * 6 + vb + 16
		let ccol = [ s:cubergb[vr], s:cubergb[vg], s:cubergb[vb], cidx ]

		for [tr,tg,tb,idx] in [ ccol ] + s:xtermcolor
			let dr = tr - r
			let dg = tg - g
			let db = tb - b
			let distance = dr*dr + dg*dg + db*db
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
		exe 'hi BG'.a:color 'ctermbg='.color_idx 'ctermfg='.( a:is_bright ? 0 : 15 )
		\                    'guibg=#'.a:color    'guifg=#'.( a:is_bright ? '000000' : 'ffffff' )
	endfunction
endif

let s:pattern_color = {}
let s:color_bright  = {}
function! s:create_syn_match()

	let pattern = submatch(0)

	if has_key( b:css_color_syn, pattern ) | return | endif
	let b:css_color_syn[pattern] = 1

	let rgb_color = get( s:pattern_color, pattern, '' )

	if ! strlen( rgb_color )
		let hexcolor = submatch(1)
		let funcname = submatch(2)

		if funcname == 'rgb'
			let rgb_color = s:rgb2color(submatch(3),submatch(4),submatch(5))
		elseif funcname == 'hsl'
			let rgb_color = s:hsl2color(submatch(3),submatch(4),submatch(5))
		elseif strlen(hexcolor) == 6
			let rgb_color = tolower(hexcolor)
		elseif strlen(hexcolor) == 3
			let rgb_color = substitute(tolower(hexcolor), '\(.\)', '\1\1', 'g')
		else
			throw 'css_color: create_syn_match invoked on bad match data'
		endif

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
	exe 'syn match BG'.rgb_color.' /'.escape(pattern, '/').'/ contained containedin=@colorableGroup'

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

let s:_hexcolor   = '#\(\x\{3}\|\x\{6}\)\>' " submatch 1
let s:_funcname   = '\(rgb\|hsl\)a\?' " submatch 2
let s:_ws_        = '\s*'
let s:_numval     = s:_ws_ . '\(\d\{1,3}%\?\)' " submatch 3,4,5
let s:_listsep    = s:_ws_ . ','
let s:_otherargs_ = '\%(,[^)]*\)\?'
let s:_funcexpr   = s:_funcname . '[(]' . s:_numval . s:_listsep . s:_numval . s:_listsep . s:_numval . s:_ws_ . s:_otherargs_ . '[)]'
let s:_csscolor   = s:_hexcolor . '\|' . s:_funcexpr
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
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! css_color#reinit()
	call filter( keys( b:css_color_hi ), 's:create_highlight( v:val, s:color_bright[v:val] )' )
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

let s:type         = [ 'none', 'hex', 'css', 'none' ] " with wraparound for index() == -1
let s:pat_for_type = [ '^$', s:_hexcolor, s:_csscolor, '^$' ]

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
