" Language:     Colored CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>
" Last Change:  2010 Jul 3
" Licence:      No Warranties. WTFPL. But please tell me!
" Version:      0.7.1
" vim:et:ts=2 sw=2 sts=2

let s:hex={}
for i in range(0, 255)
  let s:hex[ printf( '%02x', i ) ] = i
endfor

function! s:FGForBG(color)
  " pick suitable text color given a background color
  let color = tolower(a:color)
  let r = s:hex[color[0:1]]
  let g = s:hex[color[2:3]]
  let b = s:hex[color[4:5]]
  return r*30 + g*59 + b*11 > 12000 ? '000000' : 'ffffff'
endfunction

function! s:MatchColorValue(color, pattern)
  if ! len(a:color) | return | endif
  let group = 'cssColor' . tolower(a:color)
  let pattern = a:pattern
  if pattern =~ '\>$' | let pattern .= '\>' | endif
  redir => currentmatch
  silent! exe 'syn list' group
  redir END
  if stridx( currentmatch, 'match /'.pattern.'/' ) >= 0 | return '' | endif
  exe 'syn match' group '/'.pattern.'/ contained'
  exe 'syn cluster cssColors add='.group
  exe 'hi' group 'guibg=#'.(a:color) 'guifg=#'.(s:FGForBG(a:color)) | "extra parens = easier to patch
  return ''
endfunction

function! s:MatchColorName(color, name)
  let group = 'cssColor' . tolower(a:color)
  exe 'syn keyword' group a:name 'contained'
  exe 'syn cluster cssColors add='.group
  exe 'hi' group 'guibg=#'.(a:color) 'guifg=#'.(s:FGForBG(a:color)) | "extra parens = easier to patch
endfunction

function! s:HexForRGBValue(r,g,b)
  " Convert 80% -> 204, 100% -> 255, etc.
  let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
  return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:HexForHSLValue(h,s,l)
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

function! s:PreviewCSSColorInLine()
  " TODO use cssColor matchdata
  "
  " N.B. these substitute() calls are here just for the side effect
  "      of invoking s:MatchColorValue during substitution -- because
  "      match() and friends do not allow finding all matches in a single
  "      scan without examining the start of the string over and over
  call substitute( substitute( substitute( substitute( getline('.'),
    \ '#\(\x\)\(\x\)\(\x\)\>', '\=s:MatchColorValue(submatch(1).submatch(1).submatch(2).submatch(2).submatch(3).submatch(3), submatch(0))', 'g' ),
    \ '#\(\x\{6}\)\>', '\=s:MatchColorValue(submatch(1), submatch(0))', 'g' ),
    \ 'rgba\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)', '\=s:MatchColorValue(s:HexForRGBValue(submatch(1),submatch(2),submatch(3)),submatch(0))', 'g' ),
    \ 'hsla\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)', '\=s:MatchColorValue(s:HexForHSLValue(submatch(1),submatch(2),submatch(3)),submatch(0))', 'g' )
endfunction

function! s:PreviewCSSColorInBuffer()
  let view = winsaveview()
  %call s:PreviewCSSColorInLine()
  call winrestview(view)
endfunction

if has("gui_running") || &t_Co==256
  " HACK modify cssDefinition to add @cssColors to its contains
  redir => cssdef
  silent! syn list cssDefinition
  redir END
  if len( cssdef )
    for out in split( cssdef, "\n" )
      if out !~ '^cssDefinition ' | continue | endif
      let out = substitute( out, ' \+xxx \+', ' ', '' )
      let out = substitute( out, ' contains=\zs', '@cssColors,', '' )
      exe 'syn region' out
    endfor
  endif

  if ! has('gui_running')

    " preset 16 vt100 colors
    let s:xtermcolor=[
      \ [ 0x00, 0x00, 0x00 ],
      \ [ 0xCD, 0x00, 0x00 ],
      \ [ 0x00, 0xCD, 0x00 ],
      \ [ 0xCD, 0xCD, 0x00 ],
      \ [ 0x00, 0x00, 0xEE ],
      \ [ 0xCD, 0x00, 0xCD ],
      \ [ 0x00, 0xCD, 0xCD ],
      \ [ 0xE5, 0xE5, 0xE5 ],
      \ [ 0x7F, 0x7F, 0x7F ],
      \ [ 0xFF, 0x00, 0x00 ],
      \ [ 0x00, 0xFF, 0x00 ],
      \ [ 0xFF, 0xFF, 0x00 ],
      \ [ 0x5C, 0x5C, 0xFF ],
      \ [ 0xFF, 0x00, 0xFF ],
      \ [ 0x00, 0xFF, 0xFF ],
      \ [ 0xFF, 0xFF, 0xFF ]]

    for c in range(0, len(s:xtermcolor) - 1)
      let s:xtermcolor[c] += [c]
    endfor

    " grayscale ramp
    for c in range(0, 23)
      let value = 8 + c * 0x0A
      let s:xtermcolor += [[value, value, value, 232 + c]]
    endfor

    " the 6 values used in the xterm color cube
    let s:cubergb = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]

    let i = 0
    let s:xvquant = []
    for c in range(0, 255)
      let value = s:cubergb[i]
      if c == value | let s:xvquant += [i] | continue | endif
      let nextvalue = s:cubergb[i+1]
      let s:xvquant += [ c - value < nextvalue - c ? i : i+1 ]
      if c >= nextvalue | let i += 1 | endif
    endfor

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
      let ccol = [ s:cubergb[vr], s:cubergb[vg], s:cubergb[vg], cidx ]

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

    " recompile main functions after patching GUI code into console code
    " this avoids having any conditionals on a critical execution path
    redir => source
    silent! function s:MatchColorValue
    silent! function s:MatchColorName
    redir END
    let source = substitute( source, '\n[0-9]\+', "\n", 'g' )
    let source = substitute( source, ' \zsfunction\ze ', 'function!', 'g' )
    let source = substitute( source, 'gui\([bf]g\)=#''.(', 'cterm\1=''.s:XTermColorForRGB(', 'g' )
    exe source

  endif

  " w3c Colors
  call s:MatchColorName('800000', 'maroon')
  call s:MatchColorName('ff0000', 'red')
  call s:MatchColorName('ffA500', 'orange')
  call s:MatchColorName('ffff00', 'yellow')
  call s:MatchColorName('808000', 'olive')
  call s:MatchColorName('800080', 'purple')
  call s:MatchColorName('ff00ff', 'fuchsia')
  call s:MatchColorName('ffffff', 'white')
  call s:MatchColorName('00ff00', 'lime')
  call s:MatchColorName('008000', 'green')
  call s:MatchColorName('000080', 'navy')
  call s:MatchColorName('0000ff', 'blue')
  call s:MatchColorName('00ffff', 'aqua')
  call s:MatchColorName('008080', 'teal')
  call s:MatchColorName('000000', 'black')
  call s:MatchColorName('c0c0c0', 'silver')
  call s:MatchColorName('808080', 'gray')

  " extra colors
  call s:MatchColorName('F0F8FF', 'AliceBlue')
  call s:MatchColorName('FAEBD7', 'AntiqueWhite')
  call s:MatchColorName('7FFFD4', 'Aquamarine')
  call s:MatchColorName('F0FFFF', 'Azure')
  call s:MatchColorName('F5F5DC', 'Beige')
  call s:MatchColorName('FFE4C4', 'Bisque')
  call s:MatchColorName('FFEBCD', 'BlanchedAlmond')
  call s:MatchColorName('8A2BE2', 'BlueViolet')
  call s:MatchColorName('A52A2A', 'Brown')
  call s:MatchColorName('DEB887', 'BurlyWood')
  call s:MatchColorName('5F9EA0', 'CadetBlue')
  call s:MatchColorName('7FFF00', 'Chartreuse')
  call s:MatchColorName('D2691E', 'Chocolate')
  call s:MatchColorName('FF7F50', 'Coral')
  call s:MatchColorName('6495ED', 'CornflowerBlue')
  call s:MatchColorName('FFF8DC', 'Cornsilk')
  call s:MatchColorName('DC143C', 'Crimson')
  call s:MatchColorName('00FFFF', 'Cyan')
  call s:MatchColorName('00008B', 'DarkBlue')
  call s:MatchColorName('008B8B', 'DarkCyan')
  call s:MatchColorName('B8860B', 'DarkGoldenRod')
  call s:MatchColorName('A9A9A9', 'DarkGray')
  call s:MatchColorName('A9A9A9', 'DarkGrey')
  call s:MatchColorName('006400', 'DarkGreen')
  call s:MatchColorName('BDB76B', 'DarkKhaki')
  call s:MatchColorName('8B008B', 'DarkMagenta')
  call s:MatchColorName('556B2F', 'DarkOliveGreen')
  call s:MatchColorName('FF8C00', 'Darkorange')
  call s:MatchColorName('9932CC', 'DarkOrchid')
  call s:MatchColorName('8B0000', 'DarkRed')
  call s:MatchColorName('E9967A', 'DarkSalmon')
  call s:MatchColorName('8FBC8F', 'DarkSeaGreen')
  call s:MatchColorName('483D8B', 'DarkSlateBlue')
  call s:MatchColorName('2F4F4F', 'DarkSlateGray')
  call s:MatchColorName('2F4F4F', 'DarkSlateGrey')
  call s:MatchColorName('00CED1', 'DarkTurquoise')
  call s:MatchColorName('9400D3', 'DarkViolet')
  call s:MatchColorName('FF1493', 'DeepPink')
  call s:MatchColorName('00BFFF', 'DeepSkyBlue')
  call s:MatchColorName('696969', 'DimGray')
  call s:MatchColorName('696969', 'DimGrey')
  call s:MatchColorName('1E90FF', 'DodgerBlue')
  call s:MatchColorName('B22222', 'FireBrick')
  call s:MatchColorName('FFFAF0', 'FloralWhite')
  call s:MatchColorName('228B22', 'ForestGreen')
  call s:MatchColorName('DCDCDC', 'Gainsboro')
  call s:MatchColorName('F8F8FF', 'GhostWhite')
  call s:MatchColorName('FFD700', 'Gold')
  call s:MatchColorName('DAA520', 'GoldenRod')
  call s:MatchColorName('808080', 'Grey')
  call s:MatchColorName('ADFF2F', 'GreenYellow')
  call s:MatchColorName('F0FFF0', 'HoneyDew')
  call s:MatchColorName('FF69B4', 'HotPink')
  call s:MatchColorName('CD5C5C', 'IndianRed')
  call s:MatchColorName('4B0082', 'Indigo')
  call s:MatchColorName('FFFFF0', 'Ivory')
  call s:MatchColorName('F0E68C', 'Khaki')
  call s:MatchColorName('E6E6FA', 'Lavender')
  call s:MatchColorName('FFF0F5', 'LavenderBlush')
  call s:MatchColorName('7CFC00', 'LawnGreen')
  call s:MatchColorName('FFFACD', 'LemonChiffon')
  call s:MatchColorName('ADD8E6', 'LightBlue')
  call s:MatchColorName('F08080', 'LightCoral')
  call s:MatchColorName('E0FFFF', 'LightCyan')
  call s:MatchColorName('FAFAD2', 'LightGoldenRodYellow')
  call s:MatchColorName('D3D3D3', 'LightGray')
  call s:MatchColorName('D3D3D3', 'LightGrey')
  call s:MatchColorName('90EE90', 'LightGreen')
  call s:MatchColorName('FFB6C1', 'LightPink')
  call s:MatchColorName('FFA07A', 'LightSalmon')
  call s:MatchColorName('20B2AA', 'LightSeaGreen')
  call s:MatchColorName('87CEFA', 'LightSkyBlue')
  call s:MatchColorName('778899', 'LightSlateGray')
  call s:MatchColorName('778899', 'LightSlateGrey')
  call s:MatchColorName('B0C4DE', 'LightSteelBlue')
  call s:MatchColorName('FFFFE0', 'LightYellow')
  call s:MatchColorName('32CD32', 'LimeGreen')
  call s:MatchColorName('FAF0E6', 'Linen')
  call s:MatchColorName('FF00FF', 'Magenta')
  call s:MatchColorName('66CDAA', 'MediumAquaMarine')
  call s:MatchColorName('0000CD', 'MediumBlue')
  call s:MatchColorName('BA55D3', 'MediumOrchid')
  call s:MatchColorName('9370D8', 'MediumPurple')
  call s:MatchColorName('3CB371', 'MediumSeaGreen')
  call s:MatchColorName('7B68EE', 'MediumSlateBlue')
  call s:MatchColorName('00FA9A', 'MediumSpringGreen')
  call s:MatchColorName('48D1CC', 'MediumTurquoise')
  call s:MatchColorName('C71585', 'MediumVioletRed')
  call s:MatchColorName('191970', 'MidnightBlue')
  call s:MatchColorName('F5FFFA', 'MintCream')
  call s:MatchColorName('FFE4E1', 'MistyRose')
  call s:MatchColorName('FFE4B5', 'Moccasin')
  call s:MatchColorName('FFDEAD', 'NavajoWhite')
  call s:MatchColorName('FDF5E6', 'OldLace')
  call s:MatchColorName('6B8E23', 'OliveDrab')
  call s:MatchColorName('FF4500', 'OrangeRed')
  call s:MatchColorName('DA70D6', 'Orchid')
  call s:MatchColorName('EEE8AA', 'PaleGoldenRod')
  call s:MatchColorName('98FB98', 'PaleGreen')
  call s:MatchColorName('AFEEEE', 'PaleTurquoise')
  call s:MatchColorName('D87093', 'PaleVioletRed')
  call s:MatchColorName('FFEFD5', 'PapayaWhip')
  call s:MatchColorName('FFDAB9', 'PeachPuff')
  call s:MatchColorName('CD853F', 'Peru')
  call s:MatchColorName('FFC0CB', 'Pink')
  call s:MatchColorName('DDA0DD', 'Plum')
  call s:MatchColorName('B0E0E6', 'PowderBlue')
  call s:MatchColorName('BC8F8F', 'RosyBrown')
  call s:MatchColorName('4169E1', 'RoyalBlue')
  call s:MatchColorName('8B4513', 'SaddleBrown')
  call s:MatchColorName('FA8072', 'Salmon')
  call s:MatchColorName('F4A460', 'SandyBrown')
  call s:MatchColorName('2E8B57', 'SeaGreen')
  call s:MatchColorName('FFF5EE', 'SeaShell')
  call s:MatchColorName('A0522D', 'Sienna')
  call s:MatchColorName('87CEEB', 'SkyBlue')
  call s:MatchColorName('6A5ACD', 'SlateBlue')
  call s:MatchColorName('708090', 'SlateGray')
  call s:MatchColorName('708090', 'SlateGrey')
  call s:MatchColorName('FFFAFA', 'Snow')
  call s:MatchColorName('00FF7F', 'SpringGreen')
  call s:MatchColorName('4682B4', 'SteelBlue')
  call s:MatchColorName('D2B48C', 'Tan')
  call s:MatchColorName('D8BFD8', 'Thistle')
  call s:MatchColorName('FF6347', 'Tomato')
  call s:MatchColorName('40E0D0', 'Turquoise')
  call s:MatchColorName('EE82EE', 'Violet')
  call s:MatchColorName('F5DEB3', 'Wheat')
  call s:MatchColorName('F5F5F5', 'WhiteSmoke')
  call s:MatchColorName('9ACD32', 'YellowGreen')

  " fix highlighting of "white" in `white-space` etc
  " this really belongs in Vim's own syntax/css.vim ...
  setlocal iskeyword+=-

  autocmd BufEnter     * silent call s:PreviewCSSColorInBuffer()
  autocmd CursorMoved  * silent call s:PreviewCSSColorInLine()
  autocmd CursorMovedI * silent call s:PreviewCSSColorInLine()
endif
