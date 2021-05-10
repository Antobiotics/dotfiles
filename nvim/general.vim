filetype plugin indent on
syntax on
set encoding=utf-8

" TODO: no automatic comment
" complete on TAB

"=================[ Annoying Defaults ]
set nofoldenable    " disable folding
set noerrorbells    " don't beep
set novisualbell

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
set backspace=indent,eol,start
set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings
set updatecount=10                  "Save buffer every 10 chars typed
set scrolloff=4                     "Scroll when 2 lines from top/bottom
set ruler
set showcmd "display incomplete commands
set cursorline
set number
set incsearch   " do incremental searching
set tags=tags,./tags

"=================[ Copy/Paste ]
set clipboard=unnamed
if has("gui_macvim")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

"=================[ Crontab ]
autocmd filetype crontab setlocal nobackup nowritebackup

"=================[ Search ]
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "unless uppercase letters used
set hlsearch        "Highlight all matches

"=================[ Swap Crap ]
set nobackup
set noswapfile

"=================[ Spelling ]
autocmd BufRead,BufNewFile *.md setlocal spell

"=================[ Visual Mode ]
set virtualedit=block

"=================[ Mouse ]
if has('mouse')
    set mouse=a
endif

"=================[ Undo ]
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

"=================[ Goto last location ]
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
            \|     exe "normal! g`\""
            \|  endif

"=================[ Naughty Chars ]
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           set nolist
    autocmd BufEnter  *       endif
augroup END

set rtp^="/Users/gregoirelejay/.opam/system/share/ocp-indent/vim"

au FocusGained,BufEnter * :checktime
