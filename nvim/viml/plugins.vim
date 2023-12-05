let g:ripple_winpos = "vertical"
let g:ripple_repls = {
            \ "python": ["ptpython", "\<c-u>\<esc>[200~", "\<esc>[201~", 1],
            \ "apl": "apl",
            \ "alda": "alda repl",
            \ "bc": "bc",
            \ "bqn": "bqn",
            \ "coconut" : "coconut",
            \ "haskell" : "ghci",
            \ "k": "k",
            \ "julia": "julia",
            \ "java": "jshell",
            \ "lisp": "clisp",
            \ "lua": "lua",
            \ "ocaml": ["utop", "", ";;", 1],
            \ "prolog": "gprolog",
            \ "r": "R",
            \ "ruby": "irb",
            \ "scheme": "guile",
            \ "sql": "psql postgres",
            \ "shell": "zsh"}


let maplocalleader="\<space>"

let R_assign = 2 " double _ for <-
let R_rmdchunk = 0
let R_objbr_auto_start = 0
let R_nvim_wd = 1

" for radian
let R_app = 'radian'
let R_cmd = 'R'
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

let R_listmethods = 1
let R_csv_app = ':tabnew term://vd'
" let R_csv_app = ':vsplit'
" let R_external_term = 0

set spelllang=en
set spellsuggest=best,9
nnoremap <silent> <F10> :set spell!<cr>
inoremap <silent> <F10> <C-O>:set spell!<cr>
