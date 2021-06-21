filetype off

call plug#begin('~/.vim/plugged')

Plug 'xolox/vim-misc'
Plug 'tpope/vim-repeat'
Plug 'skywind3000/asyncrun.vim'

Plug 'justinmk/vim-sneak'
let g:sneak#label = 1

"=================[ Filetypes ]
Plug 'chrisbra/csv.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'dougireton/vim-chef'
Plug 'google/vim-jsonnet'
Plug 'markcornick/vim-vagrant'
Plug 'hashivim/vim-terraform'
Plug 'towolf/vim-helm'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'
Plug 'lepture/vim-jinja'

"=================[ Languages ]
Plug 'sheerun/vim-polyglot'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
let R_assign = 2

Plug 'slashmili/alchemist.vim'
Plug 'adimit/prolog.vim'
Plug 'willpragnell/vim-reprocessed'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

autocmd BufWritePost *.js AsyncRun -post=checktime eslint --fix %

"Plug 'google/vim-maktaba'
"Plug 'bazelbuild/vim-bazel'

"=================[ DBT ]
"au BufNewFile,BufRead */macros/*.sql set ft=jinja
"au BufNewFile,BufRead */models/*.sql set ft=jinja
"au BufNewFile,BufRead */sources/*.sql set ft=jinja

"=================[ Navigation ]
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"if executable('rg')
    "let g:ackprg = "rg --vimgrep --smart-case --hidden --follow --glob='!.lock'"
"endif
cnoreabbrev Ack Ack!


Plug 'mg979/vim-visual-multi'
let g:VM_leader = ";"
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>' " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>' " replace visual C-n

Plug 'scrooloose/nerdtree'
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$', '\.git$', '__pycache__$']
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'preservim/nerdcommenter'
Plug 'terryma/vim-expand-region' " _/+

"=================[ Colors ]
Plug 'altercation/vim-colors-solarized'
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'

Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'nathanaelkane/vim-indent-guides' " <Leader>ig
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=1

"=================[ Syntax ]
" Plug 'python/black'
Plug 'psf/black', { 'tag': '19.10b0' }
let g:black_linelength = 80
let g:black_skip_string_normalization = 0

Plug 'Chiel92/vim-autoformat'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
autocmd FileType cfg,dockerfile,dosini,yaml,yml,bzl,md let b:autoformat_autoindent=0
autocmd FileType cfg,dockerfile,dosini,yaml,yml,bzl,md let b:autoformat_retab=0

let g:formatdef_sqlformat = '"sqlformat -k upper -i lower --indent_width 4 -s --wrap_after 80"'
let g:formatters_sql = ['sqlformat']

"let g:formatters_markdown = ['prettier', 'stylelint']
let g:formatters_markdown = []

au BufWrite * :Autoformat

"=================[ Python ]
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}


"=================[ Go ]
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"
" let g:go_metalinter_excludes = ['golint', 'gotype']
" let g:go_gometalinter_options='--vendor --tests --exclude=mock --exclude=gotype --exclude=golint --disable-all --enable=vet --enable=vetshadow --enable=ineffassign --enable=goconst  --enable=deadcode --enable=errcheck --enable=goimports'
let g:go_metalinter_enabled = [
            \ 'deadcode', 'errcheck', 'gas', 'goconst', 'golint', 'gosimple',
            \ 'gotype', 'ineffassign', 'interfacer', 'staticcheck', 'structcheck',
            \ 'unconvert', 'varcheck', 'vet', 'vetshadow',
            \ ]

let g:go_metalinter_disabled = ['gotype']

" =================[ Others ]
Plug 'myusuf3/numbers.vim'
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'idanarye/vim-merginal'

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"source $HOME/.config/nvim/deoplete.vim
source $HOME/.config/nvim/coc_comp.vim

call plug#end()

" set completeopt=menuone,menu,longest
set runtimepath^=~/.nvim/bundle/ag
filetype on
