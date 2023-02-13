" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1

" black
let g:black_linelength = 100
let g:black_skip_string_normalization = 1

" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'separately': {
    \       'nerdtree': 0,
    \   }
    \}
let g:rainbow_conf.ctermfgs = ['darkyellow', 'darkred', 'darkblue']

" Neoformat
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" python
let g:neoformat_enabled_python = ['black', 'isort']

" yaml
" We disable it since we usually use .pre-commit to handle yaml fixes
let g:neoformat_enabled_yaml = []

" SQL
" We disable it since we would rather use sqlfluff
let g:neoformat_enabled_sql = []
