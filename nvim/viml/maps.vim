" nnoremap <Space> <PageDown>
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" Windows
" nmap <silent> <Leader>ww :wincmd k<CR>
" nmap <silent> <Leader>ws :wincmd j<CR>
" nmap <silent> <Leader>wa :wincmd h<CR>
" nmap <silent> <Leader>wd :wincmd l<CR>

" Tabs
" nmap <silent> <Leader>e :tabn<CR>
" nmap <silent> <Leader>q :tabp<CR>

" Common typos
nmap :Wq :wq
nmap :wQ :wq
nmap :Wq :wq
nmap :WQ :wq
nmap :Q  :q
nmap :W  :w

nmap :te :tabe
nmap :Te :tabe
nmap :E :e

nmap :tc :tabclose
nmap :Tc :tabclose

nmap :Vsp :vsp
nmap :Sp :sp

nmap ]b :bnext<CR>
nmap [b :bprev<CR>

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
tnoremap <Leader>tx <C-\><C-n>:sp<CR><C-w><C-w>:term<CR>
noremap <Leader>tx:sp<CR><C-w><C-w>:term<CR>
inoremap <Leader>tx <Esc>:sp<CR><C-w><C-w>:term<CR>


" Toggle search highlight
nnoremap <silent> <Leader>/ :if (&hlsearch == 1) \| set nohlsearch \| else \| set hlsearch \| endif<cr>

" Do not make Q go to ex-mode
nnoremap Q <Nop>

xnoremap("<leader>p", "\"_dP")

" NvimTree
function! ToggleNvimTree()
   if exists(":NvimTreeToggle") == 0
     " lazy load nvim-tree
     silent! packadd nvim-tree.lua
   endif

   NvimTreeToggle
endfunction

nnoremap <silent> <C-n> :call ToggleNvimTree()<CR>
nnoremap <silent><leader>bb :Gitsigns blame_line<CR>

" Telescope
nnoremap <silent><leader>ll :execute 'Telescope find_files default_text=' . expand('<cword>')<CR>

" R pipe >> maps to |>
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a \|><CR>a
autocmd FileType rnoweb inoremap <buffer> >> <Esc>:normal! a \|><CR>a
autocmd FileType rmd inoremap <buffer> >> <Esc>:normal! a \|><CR>a
autocmd FileType quarto inoremap <buffer> >> <Esc>:normal! a \|><CR>a

" R pip %>% (magrittr pie) maps to |>
autocmd FileType r inoremap <buffer> %>% <Esc>:normal! a \|><CR>a
autocmd FileType rnoweb inoremap <buffer> %>% <Esc>:normal! a \|><CR>a
autocmd FileType rmd inoremap <buffer> %>% <Esc>:normal! a \|><CR>a
autocmd FileType quarto inoremap <buffer> %>% <Esc>:normal! a \|><CR>a

autocmd Filetype r setlocal ts=2 sw=2 expandtab
autocmd Filetype rnoweb setlocal ts=2 sw=2 expandtab
autocmd Filetype rmd setlocal ts=2 sw=2 expandtab
autocmd Filetype quarto setlocal ts=2 sw=2 expandtab

" Folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" Makes sure all folds are open with a file is opened
autocmd BufRead,BufReadPost,FileReadPost * normal zR
