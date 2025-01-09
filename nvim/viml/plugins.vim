let maplocalleader="\<space>"

let R_assign = 2 " double _ for <-
let R_rmdchunk = 0
let R_objbr_auto_start = 0
let R_nvim_wd = 1

" for radian
let R_app = 'radian'
" let R_app = 'op run --no-masking -- radian'
let R_cmd = 'R'
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 0

let R_listmethods = 1
let R_csv_app = ':tabnew term://vd'
" let R_csv_app = ':vsplit'
" let R_external_term = 0

set spelllang=en
set spellsuggest=best,9
nnoremap <silent> <F10> :set spell!<cr>
inoremap <silent> <F10> <C-O>:set spell!<cr>
