set nocompatible

"====[ Plugins ]====
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-repeat'

" Filetypes
Plugin 'chrisbra/csv.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'dougireton/vim-chef'
Plugin 'google/vim-jsonnet'
Plugin 'markcornick/vim-vagrant'
Plugin 'hashivim/vim-terraform'

" Languages
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'adimit/prolog.vim'
Plugin 'let-def/ocp-indent-vim'
Plugin 'willpragnell/vim-reprocessed'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}

"  Navigations
Plugin 'easymotion/vim-easymotion'
Plugin 'kien/ctrlp.vim'
nmap <leader>; :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|ipynb)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

Plugin 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<space>

Plugin 'ervandew/supertab'
 "let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "<c-n>"
"set omnifunc=syntaxcomplete#Complete
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabCrMapping = 1
"let g:SuperTabLongestEnhanced = 1
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']
"let g:SuperTabContextDiscoverDiscovery =  ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
"autocmd FileType *
      "\if &omnifunc != '' |
      "\call SuperTabChain(&omnifunc, "<c-p>") |
""      \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      "\endif

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeDirArrows=0
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '\.git$']

Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'

" Colors
Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'chriskempson/base16-vim'
Plugin 'lilydjwg/colorizer'
Plugin 'luochen1990/rainbow'
Plugin 'atelierbram/vim-colors_atelier-schemes'
Plugin 'nathanaelkane/vim-indent-guides' " <Leader>ig
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=1

" Utils
Plugin 'myusuf3/numbers.vim'

Plugin 'airblade/vim-gitgutter'
nnoremap <leader>gg :GitGutterToggle<CR>
Plugin 'majutsushi/tagbar'
nnoremap <leader>tt :TagbarToggle<CR>

" Syntax
Plugin 'w0rp/ale'
let g:ale_linters = {
            \ 'jsx': ['stylelint', 'eslint'],
            \ 'python': ['pylint'],
            \ 'go': ['golint']
            \}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed=0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '≈'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <leader>h :ALELint<CR>

" Plugin 'scrooloose/syntastic'
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1

Plugin 'Chiel92/vim-autoformat'
nmap <F3> :Autoformat<CR>

" Plugin 'davidhalter/jedi-vim'
Plugin 'vim-python/python-syntax'
Plugin 'mindriot101/vim-yapf'
" Plugin 'python-mode/python-mode'
" let g:syntastic_python_checkers = ['pylint']

let g:python_highlight_all = 1
let g:python_highlight_class_vars=1
let g:python_highlight_builtins=1
let g:python_highlight_builtin_objs=1
let g:python_highlight_builtin_funcs=1
let g:python_highlight_class_vars=1
"let g:pymode_syntax_highlight_self = 1
"let g:jedi#goto_command = "<leader> D"
" let g:pymode_python = '/usr/local/bin/python3'
" let g:pymode_folding = 0
" let g:pymode_options_max_line_length = 120
let g:pymode_rope=0
" let g:pymode_syntax=0
" let g:pymode_syntax_all=0
" let g:pymode_lint_checkers = ['pyflakes_']

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
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'errcheck',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'gosimple',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]
let g:go_metalinter_enabled = ['vet', 'errcheck']
let g:go_metalinter_excludes = ['golint', 'gotype']
let g:go_gometalinter_options='--vendor --tests --exclude=mock --exclude=gotype --exclude=golint --disable-all --enable=vet --enable=vetshadow --enable=ineffassign --enable=goconst  --enable=deadcode --enable=errcheck --enable=goimports'

" Others
Plugin 'kyuhi/vim-emoji-complete'
"Plugin 'ludovicchabant/vim-gutentags'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

call vundle#end()

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_ocaml_checkers = ['merlin']

"====[ Basic Config ]====
filetype plugin indent on
syntax on

set nofoldenable    " disable folding
set noerrorbells    " don't beep
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

set synmaxcol=200

set guioptions=gtrLm
if has("gui_running")
    if has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    endif
endif

" search first in current directory then file directory for tag file
set tags=tags,./tags

"===[ In test ]================================


nmap <Leader>nn :so %<CR>

set completeopt=menuone,menu,longest
set runtimepath^=~/.vim/bundle/ag


"====[ Easy moves between tabs ]===============
nmap <silent> <Leader>e :tabn<CR>
nmap <silent> <Leader>q :tabp<CR>

"================= Remaps ============================
nnoremap <Space> <PageDown>

" Indent/outdent current block...
nmap %% $>i}``
nmap $$ $<i}``

nmap :Wq :wq
nmap :wQ :wq
nmap :Wq :wq
nmap :WQ :wq
nmap :Q  :q
nmap :W  :w

nmap :te :tabe
nmap :Te :tabe
nmap :Vsp :vsp
nmap :Sp :sp
nmap :yanks :Yanks

nmap :amke :make
nmap :amek :make

nmap :ag :Ag

inoremap jj <esc>
inoremap jk <esc>

nnoremap j gj
nnoremap k gk

" Invert Paragraph moves to match J/K
nnoremap { }
nnoremap } {

nnoremap Q J
nnoremap J }
nnoremap K {

" Paragraph moves on left hand
"nnoremap <c-q> }
"nnoremap <c-e> {

nnoremap R "_d
nnoremap gV `[v`] " Highlight last inserted block of text

nmap :mcf :MultipleCursorsFind
nmap :gf :GoFmt<CR>
nmap :mto :MerlinTypeOf<CR>
"====[ Spelling ]============
autocmd BufRead,BufNewFile *.md setlocal spell

"=====[ Go ]==================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

"=====[ R ]==================
let vimrplugin_assign = 2

"====[ Window splits ]========
nmap <silent> <Leader>w :wincmd k<CR>
nmap <silent> <Leader>s :wincmd j<CR>
nmap <silent> <Leader>a :wincmd h<CR>
nmap <silent> <Leader>d :wincmd l<CR>

"====[ Misc ]=================
"let g:syntastic_check_on_open=0
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
runtime plugin/autodoc.vim
runtime plugin/documap.vim
let g:rainbow_active = 1


"====[ Set background hint ]=============
if $VIMBACKGROUND != ""
    exec 'set background=' . $VIMBACKGROUND
else
    set background=light
endif

" ================[ Theme ]=======================
set background=light
colorscheme solarized

" ================[ Mouse ]=======================
if has('mouse')
  set mouse=a
endif

"====[ Use persistent undo ]=================
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

"====[ Goto last location in non-empty files ]=======
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

"====[ Toggle visibility of naughty characters ]============
" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           set nolist
    autocmd BufEnter  *       endif
augroup END

"====[ Set up smarter search behaviour ]=======================
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "unless uppercase letters used
set hlsearch        "Highlight all matches

" I keep that option but for now on, I don't need swap files
set nobackup
set noswapfile

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


"=====[ Misc]==================================
set smartindent
set autoindent
set nowrap
set modelines=0

set title
set titleold=
set nomore

set autowrite       "Save buffer automatically when changing files
set autoread        "Always reload buffer when external changes detected

set viminfo=h,'50,<10000,s1000,/1000,:1000

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings

set updatecount=10                  "Save buffer every 10 chars typed

set scrolloff=4                     "Scroll when 2 lines from top/bottom

set ruler "show the cursor position all the time

set showcmd "display incomplete commands
set cursorline
set number

set incsearch   " do incremental searching

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

" ================ Completion =======================
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=bin/**
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*DS_Store*
set wildignore+=.git,.gitkeep
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**

"=====[ Cut and paste from MacOSX clipboard ]====================
set clipboard=unnamed
if has("gui_macvim")
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

"=====[ Tab handling ]======================================
set tabstop=4      "Tab indentation levels every four columns
set shiftwidth=4   "Indent/outdent by four columns
set expandtab      "Convert all tabs that are typed into spaces
set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else

"=====[ Project specific Tab handling ]===================================
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.py setlocal et ts=4 sw=4 sts=4
au BufNewFile,BufRead *.sh setlocal noet ts=2 sw=2
au BufNewFile,BufRead *.R  setlocal et ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal et ts=2 sw=2
au BufNewFile,BufRead *.ml setlocal et ts=2 sw=2
au BufNewFile,BufRead *.rb setlocal et ts=2 sw=2
au BufNewFile,BufRead *.css setlocal et ts=2 sw=2

"=====[ Completion Scheme ]===================================
highlight  Pmenu        ctermbg=white   ctermfg=black
highlight  PmenuSel     ctermbg=blue    ctermfg=white   cterm=bold
highlight  PmenuSbar    ctermbg=grey    ctermfg=grey
highlight  PmenuThumb   ctermbg=blue    ctermfg=blue

"=====[ Highlight cursor (plus row and column on request) ]===================

" Inverse highlighting for cursor...
highlight CursorInverse   term=inverse ctermfg=black ctermbg=white
call matchadd('CursorInverse', '\%#', 100)

" Need an invisible cursor column to make it update on every cursor move...
highlight clear CursorColumn
highlight CursorColumn term=none cterm=none
set cursorcolumn

" Implement cursor toggle...
let g:cursorcolumn_visible = 0
function! Toggle_CursorColumn (requested_state)
    if a:requested_state == 'off' || g:cursorcolumn_visible && a:requested_state == 'flip'
        let g:cursorcolumn_visible = 0
        highlight clear CursorColumn
        highlight CursorColumn term=none cterm=none
    else
        let g:cursorcolumn_visible = 1
        highlight CursorColumn term=bold ctermfg=black ctermbg=cyan cterm=bold
    endif
endfunction


"====[ Make the 81st column stand out ]====================
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Make Visual modes work better ]==================
"Square up visual selections...
set virtualedit=block

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" When shifting, retain selection over multiple shifts...
vmap <expr> > KeepVisualSelection(">")
vmap <expr> < KeepVisualSelection("<")

function! KeepVisualSelection(cmd)
    set nosmartindent
    if mode() ==# "V"
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction

