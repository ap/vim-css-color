" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>
" Last Change:  2014-01-11
" Licence:      No Warranties. WTFPL. But please tell me!
" Version:      0.9
"
" KNOWN PROBLEMS: compatibility with `cursorline` -- https://github.com/ap/vim-css-color/issues/24

if v:version < 700
	echoerr printf('Vim 7 is required for css-color (this is only %d.%d)',v:version/100,v:version%100)
	finish
endif

if !( has('gui_running') || &t_Co==256 ) | finish | endif

function! s:rgb2color(r,g,b)
	" Convert 80% -> 204, 100% -> 255, etc.
	let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
	return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:hsl2color(h,s,l)
	" Convert 80% -> 0.8, 100% -> 1.0, etc.
	let [s,l] = map( [a:s, a:l], 'v:val =~ "%$" ? v:val / 100.0 : str2float(v:val)' )
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

if ! has('gui_running')

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
	" (value is 8+10*lum for lum in 0..23)
	let s:xtermcolor += [
		\ [ 0x08, 0x08, 0x08, 232 ],
		\ [ 0x12, 0x12, 0x12, 233 ],
		\ [ 0x1C, 0x1C, 0x1C, 234 ],
		\ [ 0x26, 0x26, 0x26, 235 ],
		\ [ 0x30, 0x30, 0x30, 236 ],
		\ [ 0x3A, 0x3A, 0x3A, 237 ],
		\ [ 0x44, 0x44, 0x44, 238 ],
		\ [ 0x4E, 0x4E, 0x4E, 239 ],
		\ [ 0x58, 0x58, 0x58, 240 ],
		\ [ 0x62, 0x62, 0x62, 241 ],
		\ [ 0x6C, 0x6C, 0x6C, 242 ],
		\ [ 0x76, 0x76, 0x76, 243 ],
		\ [ 0x80, 0x80, 0x80, 244 ],
		\ [ 0x8A, 0x8A, 0x8A, 245 ],
		\ [ 0x94, 0x94, 0x94, 246 ],
		\ [ 0x9E, 0x9E, 0x9E, 247 ],
		\ [ 0xA8, 0xA8, 0xA8, 248 ],
		\ [ 0xB2, 0xB2, 0xB2, 249 ],
		\ [ 0xBC, 0xBC, 0xBC, 250 ],
		\ [ 0xC6, 0xC6, 0xC6, 251 ],
		\ [ 0xD0, 0xD0, 0xD0, 252 ],
		\ [ 0xDA, 0xDA, 0xDA, 253 ],
		\ [ 0xE4, 0xE4, 0xE4, 254 ],
		\ [ 0xEE, 0xEE, 0xEE, 255 ]]

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
	function! s:XTermColorForRGB(color)
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
endif

let [s:black, s:white] = has('gui_running') ? ['#000000', '#ffffff'] : [0, 15]
function! s:fg_for_bg(color)
	" pick suitable text color given a background color
	let color = tolower(a:color)
	let r = s:hex[color[0:1]]
	let g = s:hex[color[2:3]]
	let b = s:hex[color[4:5]]
	return r*30 + g*59 + b*11 > 12000 ? s:black : s:white
endfunction

let s:pattern_color  = {}
let s:color_prefix   = has('gui_running') ? 'gui' : 'cterm'
let s:syn_color_calc = has('gui_running') ? '"#" . toupper(rgb_color)' : 's:XTermColorForRGB(rgb_color)'
function! s:create_syn_match()

	let pattern = submatch(0)

	if has_key( b:has_color_syn_match, pattern ) | return | endif
	let b:has_color_syn_match[pattern] = 1

	if has_key( s:pattern_color, pattern )
		let rgb_color = s:pattern_color[pattern]
	else
		let funcname = submatch(1)
		let hexcolor = submatch(5)

		if funcname == 'rgb'
			let rgb_color = s:rgb2color(submatch(2),submatch(3),submatch(4))
		elseif funcname == 'hsl'
			let rgb_color = s:hsl2color(submatch(2),submatch(3),submatch(4))
		elseif strlen(hexcolor) == 6
			let rgb_color = hexcolor
		elseif strlen(hexcolor) == 3
			let rgb_color = substitute(hexcolor, '\(.\)', '\1\1', 'g')
		else
			throw 'css_color: create_syn_match invoked on bad match data'
		endif

		let s:pattern_color[pattern] = rgb_color
	endif

	" iff pattern ends on word character, require word break to match
	if pattern =~ '\>$' | let pattern .= '\>' | endif

	let group = 'cssColor' . tolower(rgb_color)
	exe 'syn match' group '/'.escape(pattern, '/').'/ contained containedin=@cssColorableGroup'
	exe 'let syn_color =' s:syn_color_calc
	exe 'hi' group s:color_prefix.'bg='.syn_color s:color_prefix.'fg='.s:fg_for_bg(rgb_color)
	return ''
endfunction

let s:_funcname   = '\(rgb\|hsl\)a\?' " submatch 1
let s:_numval     = '\(\d\{1,3}%\?\)' " submatch 2,3,4
let s:_ws_        = '\s*'
let s:_listsep    = s:_ws_ . ',' . s:_ws_
let s:_otherargs_ = '\%(,[^)]*\)\?'
let s:_funcexpr   = s:_funcname . '[(]' . s:_numval . s:_listsep . s:_numval . s:_listsep . s:_numval . s:_ws_ . s:_otherargs_ . '[)]'
let s:_hexcolor   = '#\(\x\{3}\|\x\{6}\)\>' " submatch 5
let s:_grammar    = s:_funcexpr . '\|' . s:_hexcolor
function! css_color#parse_screen()
	" N.B. this substitute() call is here just for the side effect
	"      of invoking s:create_syn_match during substitution -- because
	"      match() and friends do not allow finding all matches in a single
	"      scan without examining the start of the string over and over
	call substitute( join( getline('w0','w$'), "\n" ), s:_grammar, '\=s:create_syn_match()', 'g' )

	let lnr = line('.')
	let group = ''
	let groupstart = 0
	let endcol = col('$')
	call filter(b:color_match_id, 'matchdelete(v:val)')
	for col in range( 1, endcol )
		let nextgroup = col < endcol ? synIDattr( synID( lnr, col, 1 ), 'name' ) : ''
		if group == nextgroup | continue | endif
		if group =~ '^cssColor\x\{6}$'
			let regex = '\%'.lnr.'l\%'.groupstart.'c'.repeat( '.', col - groupstart )
			let match = matchadd( group, regex, -1 )
			let b:color_match_id += [ match ]
		endif
		let group = nextgroup
		let groupstart = col
	endfor
endfunction
