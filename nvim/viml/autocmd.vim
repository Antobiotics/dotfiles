autocmd BufWrite * :Neoformat
" autocmd BufWritePost *.py Neoformat black

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell

" autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({scope="line"})

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
