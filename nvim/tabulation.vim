set tabstop=4      "Tab indentation levels every four columns
set shiftwidth=4   "Indent/outdent by four columns
set expandtab      "Convert all tabs that are typed into spaces
set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.py setlocal et ts=4 sw=4 sts=4
au BufNewFile,BufRead *.sh setlocal noet ts=2 sw=2
au BufNewFile,BufRead *.R  setlocal et ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal et ts=2 sw=2
au BufNewFile,BufRead *.ml setlocal et ts=2 sw=2
au BufNewFile,BufRead *.rb setlocal et ts=2 sw=2
au BufNewFile,BufRead *.css setlocal et ts=2 sw=2
au BufNewFile,BufRead *.js setlocal et ts=2 sw=2
au BufNewFile,BufRead *.jsx setlocal et ts=2 sw=2
au BufNewFile,BufRead *.yaml setlocal et ts=2 sw=2
au BufNewFile,BufRead *.yml setlocal et ts=2 sw=2
