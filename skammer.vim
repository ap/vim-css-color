" Maintainer: Max Vasiliev (skammer312@gmail.com)

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "skammer"


" Vim >= 7.0 specific colors
"if version >= 700
  "hi CursorLine   guibg=#2d2d2d
  "hi CursorColumn guibg=#2d2d2d
  "hi MatchParen   guifg=#f6f3e8 guibg=#857b6f gui=bold
  "hi Pmenu        guifg=#f6f3e8 guibg=#444444
  "hi PmenuSel     guifg=#000000 guibg=#cae682
"endif

if version >= 700
  "hi CursorLine   guibg=#262626
  "hi CursorColumn guibg=#262626
  hi  CursorLine   guibg=#2d2d2d
  hi  CursorColumn guibg=#2d2d2d

  "hi MatchParen guifg=white guibg=#80a090 gui=bold
  hi MatchParen guifg=white guibg=#5c5c5c gui=bold

  "Tabpages
  "hi TabLine     guifg=black   guibg=#b0b8c0 gui=none
  "hi TabLineFill guifg=#9098a0
  hi  TabLineFill guifg=#444444
  hi  TabLineSel  guifg=black   guibg=#f0f0f0 gui=bold

  hi TabLine guifg=#f6f3e8 guibg=#444444 gui=none
  "hi TabLineFill

  "P-Menu (auto-completion)
  "PmenuThumb
  hi Pmenu    guifg=#f6f3e8 guibg=#444444
  hi PmenuSel guifg=#000000 guibg=#cae682
  hi  PmenuThumb     guifg=#8F9D6A
endif


"  General       colors
"   hi            Cursor        guifg=NONE    guibg=#656565 gui=none
hi  Cursor        guifg=#000000 guibg=#ffffff gui=none
"   guibg=#242424
"hi Normal        guifg=#f6f3e8 guibg=#1f1f1f gui=none
hi  Normal        guifg=#f6f3e8 guibg=#272727 gui=none
"hi Normal        guifg=#e6e1dc guibg=#323232 gui=none
"hi NonText       guifg=#808080 guibg=#303030 gui=none
"hi  NonText       guifg=#808080 guibg=#292929 gui=none
hi  NonText       guifg=#333333
hi  LineNr        guifg=#857b6f guibg=#000000 gui=none
hi  StatusLine    guifg=#f6f3e8 guibg=#555555 gui=none
hi  StatusLineNC  guifg=#857b6f guibg=#444444 gui=none
hi  VertSplit     guifg=#444444 guibg=#444444 gui=none
"hi Folded        guibg=#384048 guifg=#a0a8b0 gui=none
hi  Folded        guibg=#384048 guifg=#ececec gui=none
hi  Title         guifg=#f6f3e8 guibg=NONE    gui=bold
"hi Visual        guifg=#f6f3e8 guibg=#444444 gui=none
hi  Visual        guibg=#444444 gui=none
"hi  SpecialKey    guifg=#808080 guibg=#343434 gui=none
hi  SpecialKey    guifg=#666666 guibg=#333333

"hi Folded guibg=#384048 guifg=#a0a8b0 gui=italic
hi FoldColumn guibg=#444444 guifg=#a0a8b0
hi SignColumn guibg=#444444 guifg=#a0a8b0

"hi Normal       guifg=#F8F8F8 guibg=#141414
"hi Cursor       guifg=#F8F8F8 guibg=#A7A7A7
"hi CursorIM     guifg=#F8F8F8 guibg=#5F5A60
hi  Directory    guifg=#8F9D6A guibg=#141414
hi  ErrorMsg     guifg=#CF6A4C guibg=#420E09
"hi VertSplit    guifg=#AC885B guibg=#FFFFFF
"hi Folded       guifg=#F9EE98 guibg=#494949
hi  IncSearch    guifg=#000000 guibg=#CF6A4C
"hi LineNr       guifg=#7587A6 guibg=#000000
"hi ModeMsg      guifg=#CF7D34 guibg=#E9C062
"hi MoreMsg      guifg=#CF7D34 guibg=#E9C062
"hi NonText      guifg=#D2A8A1 guibg=#141414
hi  Question     guifg=#7587A6 guibg=#0E2231
hi  Search       guifg=#420E09 guibg=#CF6A4C
"hi  SpecialKey   guifg=#CF7D34 guibg=#141414
"hi StatusLine   guifg=#0E2231 guibg=#8693A5
"hi StatusLineNC guifg=#7587A6 guibg=#F8F8F8
"hi Title        guifg=#8B98AB guibg=#0E2231
"hi Visual       guifg=#0E2231 guibg=#AFC4DB
hi  WarningMsg   guifg=#CF6A4C guibg=#420E09
hi  WildMenu     guifg=#AFC4DB guibg=#0E2231

"   Syntax     highlighting
hi  Comment    guifg=#99968b gui=none
hi  Todo       guifg=#414141 guibg=#FAF77C gui=none
hi  Constant   guifg=#e5786d gui=none
"hi String     guifg=#95e454 gui=none
hi  Identifier guifg=#cae682 gui=none
"hi Function   guifg=#cae682 gui=none
hi  Function   guifg=#E9C062 gui=none
"hi Type       guifg=#cae682 gui=none
"hi Statement  guifg=#8ac6f2 gui=none
"hi Statement  guifg=#82BAE3 gui=none
"hi Keyword    guifg=#8ac6f2 gui=none
hi  Keyword    guifg=#82BAE3 gui=none
hi  PreProc    guifg=#e5786d gui=none
hi  Number     guifg=#e5786d gui=none
"hi Special    guifg=#e7f6da gui=none
hi  Error      guibg=#9B2B2B

"hi Comment        guifg=#8F9D6A
"hi Constant       guifg=#CF6A4C
"hi String         guifg=#ddf2a4
hi  String         guifg=#C1EE81
hi  Character      guifg=#E9C062
"hi Number         guifg=#9B859D
"hi Boolean        guifg=#CF6A4C
"hi Float          guifg=#562D56
"hi Identifier     fg=#7587a6
"hi Function       guifg=#8B98AB
hi  Statement      guifg=#CF7D34       gui=none
"hi Conditional    guifg=#D2A8A1
"hi Repeat         guifg=khaki
hi  Label          guifg=#E9C062
hi  Operator       guifg=#CF6A4C
hi  Keyword        guifg=#426B89
"hi Exception      guifg=khaki
"hi PreProc        guifg=khaki4
"hi Include        guifg=khaki4
"hi Define         guifg=khaki1
hi  Macro          guifg=#9B703F
"hi PreCondit      guifg=khaki3
hi  Type           guifg=#87A65A       gui=none
hi  StorageClass   guifg=tan
"hi Structure      guifg=DarkGoldenrod
"hi Typedef        guifg=khaki3
"hi Special        guifg=IndianRed
"hi SpecialChar    guifg=DarkGoldenrod
hi  Tag            guifg=DarkKhaki
"hi Delimiter      guifg=Goldenrod
"hi Delimiter      guifg=#8DC145
"hi SpecialComment guifg=cornsilk
hi  Debug          guifg=brown
"hi Underlined     guifg=#Cf6A4C
hi  Underlined     guifg=#C16347
hi  Ignore         guifg=#565656
"hi Error          guifg=#CF6A4C       guibg=#420E09
"hi Todo           guifg=#7587A6       guibg=#0E2231
"hi Pmenu          guifg=#141414       guibg=#CDA869
"hi PmenuSel       guifg=#F8F8F8       guibg=#9B703F
"hi PmenuSbar      guibg=#DAEFA3
hi  Special        guifg=#9389D6

hi DiffText gui=bold guibg=Red guifg=fg
hi DiffAdd guibg=#004203
hi DiffChange guibg=#680068
hi DiffDelete guibg=#901A15 gui=NONE guifg=fg

hi IncSearch gui=reverse

hi rubySymbol guifg=#6CA3D8 gui=NONE

hi ColorColumn guibg=#252525 gui=NONE


