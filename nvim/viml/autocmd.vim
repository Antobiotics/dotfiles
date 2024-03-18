autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * lua vim.lsp.buf.format {async = true}

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
