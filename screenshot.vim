if 2 != exists('DoMatchParen')
	unlet loaded_matchparen
	runtime plugin/matchparen.vim
endif
let &runtimepath = '.,' . &runtimepath
colorscheme skammer
set guifont=Anonymous\ Pro:h12
set columns=81 lines=26
e screenshot.css
$
set ts=2 nolist
