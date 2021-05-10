
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists *  let v:swapchoice = 'o'
    autocmd SwapExists *  echohl ErrorMsg
    autocmd SwapExists *  echo 'Duplicate edit session (readonly)'
    autocmd SwapExists *  echohl None
    autocmd SwapExists *  call Make_session_finder( expand('<afile>') )
    autocmd SwapExists *  sleep 1
augroup END

function! Make_session_finder (filename)
    exec 'nnoremap ss :!terminal_promote_vim_session ' . a:filename . '<CR>:q!<CR>'
endfunction

