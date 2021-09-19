nnoremap <Space> <PageDown>

" Windows
nmap <silent> <Leader>w :wincmd k<CR>
nmap <silent> <Leader>s :wincmd j<CR>
nmap <silent> <Leader>a :wincmd h<CR>
nmap <silent> <Leader>d :wincmd l<CR>
nmap <silent> <Leader>m <C-W>m

" Tabs
nmap <silent> <Leader>e :tabn<CR>
nmap <silent> <Leader>q :tabp<CR>

" Common typos
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

" copy/pasta
" Paste from the system clipboard(in normal mode)
nnoremap <silent><leader>y "*y
" Paste from the system clipboard(in visual mode)
vnoremap <silent><leader>y "*y
" Cut from the system clipboard(in normal mode)
nnoremap <silent><leader>x "*x
" Cut from the system clipboard(in visual mode)
vnoremap <silent><leader>x "*x
" Paste from the system clipboard(in normal mode)
nnoremap <silent><leader>p "*p
" Paste from the system clipboard(in visual mode)
nnoremap <silent><leader>p "*p

" Misc
" Leader Escape in terminal mode takes you to normal mode
tnoremap <silent><leader><Esc> <C-\><C-n>

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


" Toggle search highlight
nnoremap <silent> <C-C> :if (&hlsearch == 1) \| set nohlsearch \| else \| set hlsearch \| endif<cr>

" Do not make Q go to ex-mode
nnoremap Q <Nop>


" NvimTree
function! ToggleNvimTree()
   if exists(":NvimTreeToggle") == 0
     " lazy load nvim-tree
     silent! packadd nvim-tree.lua
   endif

   NvimTreeToggle
 endfunction

nnoremap <silent> <C-n> :call ToggleNvimTree()<CR>


