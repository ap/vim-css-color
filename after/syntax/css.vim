" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>
" Last Change:  2014-01-11
" Licence:      No Warranties. WTFPL. But please tell me!
" Version:      0.8
" vim:et:ts=2 sw=2 sts=2
"
" KNOWN PROBLEMS: compatibility with `cursorline` -- https://github.com/ap/vim-css-color/issues/24

if v:version < 700
	echoerr printf('Vim 7 is required for vim-css-color (this is only %d.%d)',v:version/100,v:version%100)
	finish
endif

if !( has('gui_running') || &t_Co==256 ) | finish | endif

hi cssColor000000 guibg=#000000 guifg=#FFFFFF ctermbg=16  ctermfg=231
hi cssColor000080 guibg=#000080 guifg=#FFFFFF ctermbg=235 ctermfg=231
hi cssColor00008b guibg=#00008B guifg=#FFFFFF ctermbg=4   ctermfg=231
hi cssColor0000cd guibg=#0000CD guifg=#FFFFFF ctermbg=4   ctermfg=231
hi cssColor0000ff guibg=#0000FF guifg=#FFFFFF ctermbg=4   ctermfg=231
hi cssColor006400 guibg=#006400 guifg=#FFFFFF ctermbg=235 ctermfg=231
hi cssColor008000 guibg=#008000 guifg=#FFFFFF ctermbg=2   ctermfg=231
hi cssColor008080 guibg=#008080 guifg=#FFFFFF ctermbg=30  ctermfg=231
hi cssColor008b8b guibg=#008B8B guifg=#FFFFFF ctermbg=30  ctermfg=231
hi cssColor00bfff guibg=#00BFFF guifg=#000000 ctermbg=6   ctermfg=16
hi cssColor00ced1 guibg=#00CED1 guifg=#000000 ctermbg=6   ctermfg=16
hi cssColor00fa9a guibg=#00FA9A guifg=#000000 ctermbg=6   ctermfg=16
hi cssColor00ff00 guibg=#00FF00 guifg=#000000 ctermbg=10  ctermfg=16
hi cssColor00ff7f guibg=#00FF7F guifg=#000000 ctermbg=6   ctermfg=16
hi cssColor00ffff guibg=#00FFFF guifg=#000000 ctermbg=51  ctermfg=16
hi cssColor191970 guibg=#191970 guifg=#FFFFFF ctermbg=237 ctermfg=231
hi cssColor1e90ff guibg=#1E90FF guifg=#000000 ctermbg=12  ctermfg=16
hi cssColor20b2aa guibg=#20B2AA guifg=#000000 ctermbg=37  ctermfg=16
hi cssColor228b22 guibg=#228B22 guifg=#FFFFFF ctermbg=2   ctermfg=231
hi cssColor2e8b57 guibg=#2E8B57 guifg=#FFFFFF ctermbg=240 ctermfg=231
hi cssColor2f4f4f guibg=#2F4F4F guifg=#FFFFFF ctermbg=238 ctermfg=231
hi cssColor32cd32 guibg=#32CD32 guifg=#000000 ctermbg=2   ctermfg=16
hi cssColor3cb371 guibg=#3CB371 guifg=#000000 ctermbg=71  ctermfg=16
hi cssColor40e0d0 guibg=#40E0D0 guifg=#000000 ctermbg=80  ctermfg=16
hi cssColor4169e1 guibg=#4169E1 guifg=#FFFFFF ctermbg=12  ctermfg=231
hi cssColor4682b4 guibg=#4682B4 guifg=#FFFFFF ctermbg=67  ctermfg=231
hi cssColor483d8b guibg=#483D8B guifg=#FFFFFF ctermbg=240 ctermfg=231
hi cssColor48d1cc guibg=#48D1CC guifg=#000000 ctermbg=80  ctermfg=16
hi cssColor4b0082 guibg=#4B0082 guifg=#FFFFFF ctermbg=238 ctermfg=231
hi cssColor556b2f guibg=#556B2F guifg=#FFFFFF ctermbg=239 ctermfg=231
hi cssColor5f9ea0 guibg=#5F9EA0 guifg=#000000 ctermbg=73  ctermfg=16
hi cssColor6495ed guibg=#6495ED guifg=#000000 ctermbg=12  ctermfg=16
hi cssColor66cdaa guibg=#66CDAA guifg=#000000 ctermbg=79  ctermfg=16
hi cssColor696969 guibg=#696969 guifg=#FFFFFF ctermbg=242 ctermfg=231
hi cssColor6a5acd guibg=#6A5ACD guifg=#FFFFFF ctermbg=12  ctermfg=231
hi cssColor6b8e23 guibg=#6B8E23 guifg=#FFFFFF ctermbg=241 ctermfg=231
hi cssColor708090 guibg=#708090 guifg=#000000 ctermbg=66  ctermfg=16
hi cssColor778899 guibg=#778899 guifg=#000000 ctermbg=102 ctermfg=16
hi cssColor7b68ee guibg=#7B68EE guifg=#000000 ctermbg=12  ctermfg=16
hi cssColor7cfc00 guibg=#7CFC00 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColor7fff00 guibg=#7FFF00 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColor7fffd4 guibg=#7FFFD4 guifg=#000000 ctermbg=122 ctermfg=16
hi cssColor800000 guibg=#800000 guifg=#FFFFFF ctermbg=88  ctermfg=231
hi cssColor800080 guibg=#800080 guifg=#FFFFFF ctermbg=240 ctermfg=231
hi cssColor808000 guibg=#808000 guifg=#FFFFFF ctermbg=240 ctermfg=231
hi cssColor808080 guibg=#808080 guifg=#000000 ctermbg=244 ctermfg=16
hi cssColor87ceeb guibg=#87CEEB guifg=#000000 ctermbg=117 ctermfg=16
hi cssColor87cefa guibg=#87CEFA guifg=#000000 ctermbg=117 ctermfg=16
hi cssColor8a2be2 guibg=#8A2BE2 guifg=#FFFFFF ctermbg=12  ctermfg=231
hi cssColor8b0000 guibg=#8B0000 guifg=#FFFFFF ctermbg=88  ctermfg=231
hi cssColor8b008b guibg=#8B008B guifg=#FFFFFF ctermbg=5   ctermfg=231
hi cssColor8b4513 guibg=#8B4513 guifg=#FFFFFF ctermbg=94  ctermfg=231
hi cssColor8fbc8f guibg=#8FBC8F guifg=#000000 ctermbg=108 ctermfg=16
hi cssColor90ee90 guibg=#90EE90 guifg=#000000 ctermbg=249 ctermfg=16
hi cssColor9370d8 guibg=#9370D8 guifg=#000000 ctermbg=12  ctermfg=16
hi cssColor9400d3 guibg=#9400D3 guifg=#FFFFFF ctermbg=5   ctermfg=231
hi cssColor98fb98 guibg=#98FB98 guifg=#000000 ctermbg=250 ctermfg=16
hi cssColor9932cc guibg=#9932CC guifg=#FFFFFF ctermbg=5   ctermfg=231
hi cssColor9acd32 guibg=#9ACD32 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColora0522d guibg=#A0522D guifg=#FFFFFF ctermbg=130 ctermfg=231
hi cssColora52a2a guibg=#A52A2A guifg=#FFFFFF ctermbg=124 ctermfg=231
hi cssColora9a9a9 guibg=#A9A9A9 guifg=#000000 ctermbg=248 ctermfg=16
hi cssColoradd8e6 guibg=#ADD8E6 guifg=#000000 ctermbg=152 ctermfg=16
hi cssColoradff2f guibg=#ADFF2F guifg=#000000 ctermbg=3   ctermfg=16
hi cssColorafeeee guibg=#AFEEEE guifg=#000000 ctermbg=159 ctermfg=16
hi cssColorb0c4de guibg=#B0C4DE guifg=#000000 ctermbg=152 ctermfg=16
hi cssColorb0e0e6 guibg=#B0E0E6 guifg=#000000 ctermbg=152 ctermfg=16
hi cssColorb22222 guibg=#B22222 guifg=#FFFFFF ctermbg=124 ctermfg=231
hi cssColorb8860b guibg=#B8860B guifg=#000000 ctermbg=3   ctermfg=16
hi cssColorba55d3 guibg=#BA55D3 guifg=#000000 ctermbg=5   ctermfg=16
hi cssColorbc8f8f guibg=#BC8F8F guifg=#000000 ctermbg=138 ctermfg=16
hi cssColorbdb76b guibg=#BDB76B guifg=#000000 ctermbg=247 ctermfg=16
hi cssColorc0c0c0 guibg=#C0C0C0 guifg=#000000 ctermbg=250 ctermfg=16
hi cssColorc71585 guibg=#C71585 guifg=#FFFFFF ctermbg=5   ctermfg=231
hi cssColorcd5c5c guibg=#CD5C5C guifg=#000000 ctermbg=167 ctermfg=16
hi cssColorcd853f guibg=#CD853F guifg=#000000 ctermbg=173 ctermfg=16
hi cssColord2691e guibg=#D2691E guifg=#000000 ctermbg=166 ctermfg=16
hi cssColord2b48c guibg=#D2B48C guifg=#000000 ctermbg=180 ctermfg=16
hi cssColord3d3d3 guibg=#D3D3D3 guifg=#000000 ctermbg=252 ctermfg=16
hi cssColord87093 guibg=#D87093 guifg=#000000 ctermbg=168 ctermfg=16
hi cssColord8bfd8 guibg=#D8BFD8 guifg=#000000 ctermbg=252 ctermfg=16
hi cssColorda70d6 guibg=#DA70D6 guifg=#000000 ctermbg=249 ctermfg=16
hi cssColordaa520 guibg=#DAA520 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColordc143c guibg=#DC143C guifg=#FFFFFF ctermbg=161 ctermfg=231
hi cssColordcdcdc guibg=#DCDCDC guifg=#000000 ctermbg=253 ctermfg=16
hi cssColordda0dd guibg=#DDA0DD guifg=#000000 ctermbg=182 ctermfg=16
hi cssColordeb887 guibg=#DEB887 guifg=#000000 ctermbg=180 ctermfg=16
hi cssColore0ffff guibg=#E0FFFF guifg=#000000 ctermbg=195 ctermfg=16
hi cssColore6e6fa guibg=#E6E6FA guifg=#000000 ctermbg=255 ctermfg=16
hi cssColore9967a guibg=#E9967A guifg=#000000 ctermbg=174 ctermfg=16
hi cssColoree82ee guibg=#EE82EE guifg=#000000 ctermbg=251 ctermfg=16
hi cssColoreee8aa guibg=#EEE8AA guifg=#000000 ctermbg=223 ctermfg=16
hi cssColorf08080 guibg=#F08080 guifg=#000000 ctermbg=210 ctermfg=16
hi cssColorf0e68c guibg=#F0E68C guifg=#000000 ctermbg=222 ctermfg=16
hi cssColorf0f8ff guibg=#F0F8FF guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorf0fff0 guibg=#F0FFF0 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorf0ffff guibg=#F0FFFF guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorf4a460 guibg=#F4A460 guifg=#000000 ctermbg=215 ctermfg=16
hi cssColorf5deb3 guibg=#F5DEB3 guifg=#000000 ctermbg=223 ctermfg=16
hi cssColorf5f5dc guibg=#F5F5DC guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorf5f5f5 guibg=#F5F5F5 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorf5fffa guibg=#F5FFFA guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorf8f8ff guibg=#F8F8FF guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorfa8072 guibg=#FA8072 guifg=#000000 ctermbg=209 ctermfg=16
hi cssColorfaebd7 guibg=#FAEBD7 guifg=#000000 ctermbg=7   ctermfg=16
hi cssColorfaf0e6 guibg=#FAF0E6 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfafad2 guibg=#FAFAD2 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfdf5e6 guibg=#FDF5E6 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorff0000 guibg=#FF0000 guifg=#FFFFFF ctermbg=196 ctermfg=231
hi cssColorff00ff guibg=#FF00FF guifg=#FFFFFF ctermbg=13  ctermfg=231
hi cssColorff1493 guibg=#FF1493 guifg=#FFFFFF ctermbg=5   ctermfg=231
hi cssColorff4500 guibg=#FF4500 guifg=#FFFFFF ctermbg=9   ctermfg=231
hi cssColorff6347 guibg=#FF6347 guifg=#000000 ctermbg=203 ctermfg=16
hi cssColorff69b4 guibg=#FF69B4 guifg=#000000 ctermbg=205 ctermfg=16
hi cssColorff7f50 guibg=#FF7F50 guifg=#000000 ctermbg=209 ctermfg=16
hi cssColorff8c00 guibg=#FF8C00 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColorffa07a guibg=#FFA07A guifg=#000000 ctermbg=216 ctermfg=16
hi cssColorffa500 guibg=#FFA500 guifg=#000000 ctermbg=3   ctermfg=16
hi cssColorffb6c1 guibg=#FFB6C1 guifg=#000000 ctermbg=217 ctermfg=16
hi cssColorffc0cb guibg=#FFC0CB guifg=#000000 ctermbg=218 ctermfg=16
hi cssColorffd700 guibg=#FFD700 guifg=#000000 ctermbg=11  ctermfg=16
hi cssColorffdab9 guibg=#FFDAB9 guifg=#000000 ctermbg=223 ctermfg=16
hi cssColorffdead guibg=#FFDEAD guifg=#000000 ctermbg=223 ctermfg=16
hi cssColorffe4b5 guibg=#FFE4B5 guifg=#000000 ctermbg=223 ctermfg=16
hi cssColorffe4c4 guibg=#FFE4C4 guifg=#000000 ctermbg=224 ctermfg=16
hi cssColorffe4e1 guibg=#FFE4E1 guifg=#000000 ctermbg=224 ctermfg=16
hi cssColorffebcd guibg=#FFEBCD guifg=#000000 ctermbg=7   ctermfg=16
hi cssColorffefd5 guibg=#FFEFD5 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfff0f5 guibg=#FFF0F5 guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorfff5ee guibg=#FFF5EE guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfff8dc guibg=#FFF8DC guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfffacd guibg=#FFFACD guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfffaf0 guibg=#FFFAF0 guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorfffafa guibg=#FFFAFA guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorffff00 guibg=#FFFF00 guifg=#000000 ctermbg=11  ctermfg=16
hi cssColorffffe0 guibg=#FFFFE0 guifg=#000000 ctermbg=255 ctermfg=16
hi cssColorfffff0 guibg=#FFFFF0 guifg=#000000 ctermbg=15  ctermfg=16
hi cssColorffffff guibg=#FFFFFF guifg=#000000 ctermbg=231 ctermfg=16

syn cluster cssColorableGroup contains=cssMediaBlock,cssFunction,cssDefinition,cssAttrRegion

" W3C Colors
syn keyword cssColor000000 black   contained containedin=@cssColorableGroup
syn keyword cssColorc0c0c0 silver  contained containedin=@cssColorableGroup
syn keyword cssColor808080 gray    contained containedin=@cssColorableGroup
syn match cssColorffffff "\<white\(-\)\@!\>" contained containedin=@cssColorableGroup
syn keyword cssColor800000 maroon  contained containedin=@cssColorableGroup
syn keyword cssColorff0000 red     contained containedin=@cssColorableGroup
syn keyword cssColor800080 purple  contained containedin=@cssColorableGroup
syn keyword cssColorff00ff fuchsia contained containedin=@cssColorableGroup
syn keyword cssColor008000 green   contained containedin=@cssColorableGroup
syn keyword cssColor00ff00 lime    contained containedin=@cssColorableGroup
syn keyword cssColor808000 olive   contained containedin=@cssColorableGroup
syn keyword cssColorffff00 yellow  contained containedin=@cssColorableGroup
syn keyword cssColor000080 navy    contained containedin=@cssColorableGroup
syn keyword cssColor0000ff blue    contained containedin=@cssColorableGroup
syn keyword cssColor008080 teal    contained containedin=@cssColorableGroup
syn keyword cssColor00ffff aqua    contained containedin=@cssColorableGroup

" extra colors
syn keyword cssColorf0f8ff AliceBlue            contained containedin=@cssColorableGroup
syn keyword cssColorfaebd7 AntiqueWhite         contained containedin=@cssColorableGroup
syn keyword cssColor7fffd4 Aquamarine           contained containedin=@cssColorableGroup
syn keyword cssColorf0ffff Azure                contained containedin=@cssColorableGroup
syn keyword cssColorf5f5dc Beige                contained containedin=@cssColorableGroup
syn keyword cssColorffe4c4 Bisque               contained containedin=@cssColorableGroup
syn keyword cssColorffebcd BlanchedAlmond       contained containedin=@cssColorableGroup
syn keyword cssColor8a2be2 BlueViolet           contained containedin=@cssColorableGroup
syn keyword cssColora52a2a Brown                contained containedin=@cssColorableGroup
syn keyword cssColordeb887 BurlyWood            contained containedin=@cssColorableGroup
syn keyword cssColor5f9ea0 CadetBlue            contained containedin=@cssColorableGroup
syn keyword cssColor7fff00 Chartreuse           contained containedin=@cssColorableGroup
syn keyword cssColord2691e Chocolate            contained containedin=@cssColorableGroup
syn keyword cssColorff7f50 Coral                contained containedin=@cssColorableGroup
syn keyword cssColor6495ed CornflowerBlue       contained containedin=@cssColorableGroup
syn keyword cssColorfff8dc Cornsilk             contained containedin=@cssColorableGroup
syn keyword cssColordc143c Crimson              contained containedin=@cssColorableGroup
syn keyword cssColor00ffff Cyan                 contained containedin=@cssColorableGroup
syn keyword cssColor00008b DarkBlue             contained containedin=@cssColorableGroup
syn keyword cssColor008b8b DarkCyan             contained containedin=@cssColorableGroup
syn keyword cssColorb8860b DarkGoldenRod        contained containedin=@cssColorableGroup
syn keyword cssColora9a9a9 DarkGray             contained containedin=@cssColorableGroup
syn keyword cssColor006400 DarkGreen            contained containedin=@cssColorableGroup
syn keyword cssColora9a9a9 DarkGrey             contained containedin=@cssColorableGroup
syn keyword cssColorbdb76b DarkKhaki            contained containedin=@cssColorableGroup
syn keyword cssColor8b008b DarkMagenta          contained containedin=@cssColorableGroup
syn keyword cssColor556b2f DarkOliveGreen       contained containedin=@cssColorableGroup
syn keyword cssColor9932cc DarkOrchid           contained containedin=@cssColorableGroup
syn keyword cssColor8b0000 DarkRed              contained containedin=@cssColorableGroup
syn keyword cssColore9967a DarkSalmon           contained containedin=@cssColorableGroup
syn keyword cssColor8fbc8f DarkSeaGreen         contained containedin=@cssColorableGroup
syn keyword cssColor483d8b DarkSlateBlue        contained containedin=@cssColorableGroup
syn keyword cssColor2f4f4f DarkSlateGray        contained containedin=@cssColorableGroup
syn keyword cssColor2f4f4f DarkSlateGrey        contained containedin=@cssColorableGroup
syn keyword cssColor00ced1 DarkTurquoise        contained containedin=@cssColorableGroup
syn keyword cssColor9400d3 DarkViolet           contained containedin=@cssColorableGroup
syn keyword cssColorff8c00 Darkorange           contained containedin=@cssColorableGroup
syn keyword cssColorff1493 DeepPink             contained containedin=@cssColorableGroup
syn keyword cssColor00bfff DeepSkyBlue          contained containedin=@cssColorableGroup
syn keyword cssColor696969 DimGray              contained containedin=@cssColorableGroup
syn keyword cssColor696969 DimGrey              contained containedin=@cssColorableGroup
syn keyword cssColor1e90ff DodgerBlue           contained containedin=@cssColorableGroup
syn keyword cssColorb22222 FireBrick            contained containedin=@cssColorableGroup
syn keyword cssColorfffaf0 FloralWhite          contained containedin=@cssColorableGroup
syn keyword cssColor228b22 ForestGreen          contained containedin=@cssColorableGroup
syn keyword cssColordcdcdc Gainsboro            contained containedin=@cssColorableGroup
syn keyword cssColorf8f8ff GhostWhite           contained containedin=@cssColorableGroup
syn keyword cssColorffd700 Gold                 contained containedin=@cssColorableGroup
syn keyword cssColordaa520 GoldenRod            contained containedin=@cssColorableGroup
syn keyword cssColoradff2f GreenYellow          contained containedin=@cssColorableGroup
syn keyword cssColor808080 Grey                 contained containedin=@cssColorableGroup
syn keyword cssColorf0fff0 HoneyDew             contained containedin=@cssColorableGroup
syn keyword cssColorff69b4 HotPink              contained containedin=@cssColorableGroup
syn keyword cssColorcd5c5c IndianRed            contained containedin=@cssColorableGroup
syn keyword cssColor4b0082 Indigo               contained containedin=@cssColorableGroup
syn keyword cssColorfffff0 Ivory                contained containedin=@cssColorableGroup
syn keyword cssColorf0e68c Khaki                contained containedin=@cssColorableGroup
syn keyword cssColore6e6fa Lavender             contained containedin=@cssColorableGroup
syn keyword cssColorfff0f5 LavenderBlush        contained containedin=@cssColorableGroup
syn keyword cssColor7cfc00 LawnGreen            contained containedin=@cssColorableGroup
syn keyword cssColorfffacd LemonChiffon         contained containedin=@cssColorableGroup
syn keyword cssColoradd8e6 LightBlue            contained containedin=@cssColorableGroup
syn keyword cssColorf08080 LightCoral           contained containedin=@cssColorableGroup
syn keyword cssColore0ffff LightCyan            contained containedin=@cssColorableGroup
syn keyword cssColorfafad2 LightGoldenRodYellow contained containedin=@cssColorableGroup
syn keyword cssColord3d3d3 LightGray            contained containedin=@cssColorableGroup
syn keyword cssColor90ee90 LightGreen           contained containedin=@cssColorableGroup
syn keyword cssColord3d3d3 LightGrey            contained containedin=@cssColorableGroup
syn keyword cssColorffb6c1 LightPink            contained containedin=@cssColorableGroup
syn keyword cssColorffa07a LightSalmon          contained containedin=@cssColorableGroup
syn keyword cssColor20b2aa LightSeaGreen        contained containedin=@cssColorableGroup
syn keyword cssColor87cefa LightSkyBlue         contained containedin=@cssColorableGroup
syn keyword cssColor778899 LightSlateGray       contained containedin=@cssColorableGroup
syn keyword cssColor778899 LightSlateGrey       contained containedin=@cssColorableGroup
syn keyword cssColorb0c4de LightSteelBlue       contained containedin=@cssColorableGroup
syn keyword cssColorffffe0 LightYellow          contained containedin=@cssColorableGroup
syn keyword cssColor32cd32 LimeGreen            contained containedin=@cssColorableGroup
syn keyword cssColorfaf0e6 Linen                contained containedin=@cssColorableGroup
syn keyword cssColorff00ff Magenta              contained containedin=@cssColorableGroup
syn keyword cssColor66cdaa MediumAquaMarine     contained containedin=@cssColorableGroup
syn keyword cssColor0000cd MediumBlue           contained containedin=@cssColorableGroup
syn keyword cssColorba55d3 MediumOrchid         contained containedin=@cssColorableGroup
syn keyword cssColor9370d8 MediumPurple         contained containedin=@cssColorableGroup
syn keyword cssColor3cb371 MediumSeaGreen       contained containedin=@cssColorableGroup
syn keyword cssColor7b68ee MediumSlateBlue      contained containedin=@cssColorableGroup
syn keyword cssColor00fa9a MediumSpringGreen    contained containedin=@cssColorableGroup
syn keyword cssColor48d1cc MediumTurquoise      contained containedin=@cssColorableGroup
syn keyword cssColorc71585 MediumVioletRed      contained containedin=@cssColorableGroup
syn keyword cssColor191970 MidnightBlue         contained containedin=@cssColorableGroup
syn keyword cssColorf5fffa MintCream            contained containedin=@cssColorableGroup
syn keyword cssColorffe4e1 MistyRose            contained containedin=@cssColorableGroup
syn keyword cssColorffe4b5 Moccasin             contained containedin=@cssColorableGroup
syn keyword cssColorffdead NavajoWhite          contained containedin=@cssColorableGroup
syn keyword cssColorfdf5e6 OldLace              contained containedin=@cssColorableGroup
syn keyword cssColor6b8e23 OliveDrab            contained containedin=@cssColorableGroup
syn keyword cssColorffa500 Orange               contained containedin=@cssColorableGroup
syn keyword cssColorff4500 OrangeRed            contained containedin=@cssColorableGroup
syn keyword cssColorda70d6 Orchid               contained containedin=@cssColorableGroup
syn keyword cssColoreee8aa PaleGoldenRod        contained containedin=@cssColorableGroup
syn keyword cssColor98fb98 PaleGreen            contained containedin=@cssColorableGroup
syn keyword cssColorafeeee PaleTurquoise        contained containedin=@cssColorableGroup
syn keyword cssColord87093 PaleVioletRed        contained containedin=@cssColorableGroup
syn keyword cssColorffefd5 PapayaWhip           contained containedin=@cssColorableGroup
syn keyword cssColorffdab9 PeachPuff            contained containedin=@cssColorableGroup
syn keyword cssColorcd853f Peru                 contained containedin=@cssColorableGroup
syn keyword cssColorffc0cb Pink                 contained containedin=@cssColorableGroup
syn keyword cssColordda0dd Plum                 contained containedin=@cssColorableGroup
syn keyword cssColorb0e0e6 PowderBlue           contained containedin=@cssColorableGroup
syn keyword cssColorbc8f8f RosyBrown            contained containedin=@cssColorableGroup
syn keyword cssColor4169e1 RoyalBlue            contained containedin=@cssColorableGroup
syn keyword cssColor8b4513 SaddleBrown          contained containedin=@cssColorableGroup
syn keyword cssColorfa8072 Salmon               contained containedin=@cssColorableGroup
syn keyword cssColorf4a460 SandyBrown           contained containedin=@cssColorableGroup
syn keyword cssColor2e8b57 SeaGreen             contained containedin=@cssColorableGroup
syn keyword cssColorfff5ee SeaShell             contained containedin=@cssColorableGroup
syn keyword cssColora0522d Sienna               contained containedin=@cssColorableGroup
syn keyword cssColor87ceeb SkyBlue              contained containedin=@cssColorableGroup
syn keyword cssColor6a5acd SlateBlue            contained containedin=@cssColorableGroup
syn keyword cssColor708090 SlateGray            contained containedin=@cssColorableGroup
syn keyword cssColor708090 SlateGrey            contained containedin=@cssColorableGroup
syn keyword cssColorfffafa Snow                 contained containedin=@cssColorableGroup
syn keyword cssColor00ff7f SpringGreen          contained containedin=@cssColorableGroup
syn keyword cssColor4682b4 SteelBlue            contained containedin=@cssColorableGroup
syn keyword cssColord2b48c Tan                  contained containedin=@cssColorableGroup
syn keyword cssColord8bfd8 Thistle              contained containedin=@cssColorableGroup
syn keyword cssColorff6347 Tomato               contained containedin=@cssColorableGroup
syn keyword cssColor40e0d0 Turquoise            contained containedin=@cssColorableGroup
syn keyword cssColoree82ee Violet               contained containedin=@cssColorableGroup
syn keyword cssColorf5deb3 Wheat                contained containedin=@cssColorableGroup
syn keyword cssColorf5f5f5 WhiteSmoke           contained containedin=@cssColorableGroup
syn keyword cssColor9acd32 YellowGreen          contained containedin=@cssColorableGroup

function! s:RGB2Color(r,g,b)
  " Convert 80% -> 204, 100% -> 255, etc.
  let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
  return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:HSL2Color(h,s,l)
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
      \         + repeat([1],68)
      \         + repeat([2],40)
      \         + repeat([3],40)
      \         + repeat([4],40)
      \         + repeat([5],20)
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
function! s:FGForBG(color)
  " pick suitable text color given a background color
  let color = tolower(a:color)
  let r = s:hex[color[0:1]]
  let g = s:hex[color[2:3]]
  let b = s:hex[color[4:5]]
  return r*30 + g*59 + b*11 > 12000 ? s:black : s:white
endfunction

let b:color_pattern  = {}
let s:color_prefix   = has('gui_running') ? 'gui' : 'cterm'
let s:syn_color_calc = has('gui_running') ? '"#" . toupper(rgb_color)' : 's:XTermColorForRGB(rgb_color)'
function! s:CreateSynMatch(color, pattern)

  if strlen(a:color) == 6
    let rgb_color = a:color
  elseif strlen(a:color) == 3
    let rgb_color = substitute(a:color, '\(.\)', '\1\1', 'g')
  else
    return
  endif

  if has_key( b:color_pattern, a:pattern ) | return | endif
  let b:color_pattern[a:pattern] = 1

  let pattern = a:pattern
  " iff pattern ends on word character, require word break to match
  if pattern =~ '\>$' | let pattern .= '\>' | endif

  let group = 'cssColor' . tolower(rgb_color)
  exe 'syn match' group '/'.escape(pattern, '/').'/ contained containedin=@cssColorableGroup'
  exe 'let syn_color =' s:syn_color_calc
  exe 'hi' group s:color_prefix.'bg='.syn_color s:color_prefix.'fg='.s:FGForBG(rgb_color)
  return ''
endfunction

function! s:ParseScreen()
  " N.B. these substitute() calls are here just for the side effect
  "      of invoking s:CreateSynMatch during substitution -- because
  "      match() and friends do not allow finding all matches in a single
  "      scan without examining the start of the string over and over
  call substitute( substitute( substitute( join( getline('w0','w$'), "\n" ),
    \ '#\(\x\{3}\|\x\{6}\)\>', '\=s:CreateSynMatch(submatch(1), submatch(0))', 'g' ),
    \ 'rgba\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)', '\=s:CreateSynMatch(s:RGB2Color(submatch(1),submatch(2),submatch(3)),submatch(0))', 'g' ),
    \ 'hsla\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)', '\=s:CreateSynMatch(s:HSL2Color(submatch(1),submatch(2),submatch(3)),submatch(0))', 'g' )
endfunction

call s:ParseScreen()
autocmd CursorMoved  <buffer> silent call s:ParseScreen()
autocmd CursorMovedI <buffer> silent call s:ParseScreen()
