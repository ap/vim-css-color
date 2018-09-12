" jsx syntax should already be including the javascript and xml syntaxes
" but those only use `hex` parsing; JSX needs `css` for inline CSS styles
call css_color#init('css', 'none', '')
