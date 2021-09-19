nnoremap <Space> <PageDown>

nmap %% $>i}``    " Indent/outdent current block...
nmap $$ $<i}``
nnoremap R "_d
nnoremap gV `[v`] " Highlight last inserted block of text
nmap <Leader>nn :so %<CR>

"=================[ Plugins ]
map <C-n> :NERDTreeToggle<CR>
nmap <leader>h :ALELint<CR>
nmap <leader>b :Black<CR>
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>y :Rg!<CR>
noremap <leader>l  :Rg <C-r>=expand('<cword>')<CR>

"=================[ Windows ]
nmap <silent> <Leader>w :wincmd k<CR>
nmap <silent> <Leader>s :wincmd j<CR>
nmap <silent> <Leader>a :wincmd h<CR>
nmap <silent> <Leader>d :wincmd l<CR>
nmap <silent> <Leader>m <C-W>m

"=================[ Tabs ]
nmap <silent> <Leader>e :tabn<CR>
nmap <silent> <Leader>q :tabp<CR>

"=================[ Typos ]
nmap :Wq :wq
nmap :wQ :wq
nmap :Wq :wq
nmap :WQ :wq
nmap :Q  :q
nmap :W  :w

nmap :E  :e

nmap :te :tabe
nmap :Te :tabe

nmap :tc :tabclose
nmap :Tc :tabclose

nmap :Vsp :vsp
nmap :Sp :sp

nmap :yanks :Yanks

nmap :amke :make
nmap :amek :make

nmap :ack :Ack

"=================[ Movements ]
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

"=================[ Terminal ]
tnoremap <Esc> <C-\><C-n>

" Move between windows
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Quickly create a new terminal in a new tab
tnoremap <Leader>tt <C-\><C-n>:tab new<CR>:term<CR>
noremap <Leader>tt :tab new<CR>:term<CR>
inoremap <Leader>tt <Esc>:tab new<CR>:term<CR>

" Quickly create a new terminal in a vertical split
tnoremap <Leader>tv <C-\><C-n>:vsp<CR><C-w><C-w>:term<CR>
noremap <Leader>tv :vsp<CR><C-w><C-w>:term<CR>
inoremap <Leader>tv <Esc>:vsp<CR><C-w><C-w>:term<CR>

" Quickly create a new terminal in a horizontal split
tnoremap <Leader>th <C-\><C-n>:sp<CR><C-w><C-w>:term<CR>
noremap <Leader>th :sp<CR><C-w><C-w>:term<CR>
inoremap <Leader>th <Esc>:sp<CR><C-w><C-w>:term<CR>

"=================[ Visual Mode ]
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
