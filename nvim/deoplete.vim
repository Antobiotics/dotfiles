Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" call deoplete#custom#option('num_processes', 1)
let g:deoplete#enable_at_startup = 1

" Python
Plug 'zchee/deoplete-jedi'

" Go
Plug 'zchee/deoplete-go', { 'do': 'make' }
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" JS stuff
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarnpkg global add tern' }
Plug 'steelsojka/deoplete-flow'
let g:deoplete#sources#flow#flow_bin = 'flow'

" Rust
Plug 'sebastianmarkow/deoplete-rust'
let g:racer_experimental_completer = 1
if !exists('g:deoplete#sources#rust#racer_binary') || g:deoplete#sources#rust#racer_binary == ''
    if executable('racer')
        let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
    endif
endif

if !exists('g:deoplete#sources#rust#rust_source_path') || g:deoplete#sources#rust#rust_source_path == ''
    if executable('rustc')
        " if src was installed via rustup, get it by running rustc
        let rustc_root = systemlist('rustc --print sysroot')[0]
        let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'

        if isdirectory(rustc_src_dir)
            let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
        endif
    endif
endif

" Multiple Cursors
func! Multiple_cursors_before()
    if deoplete#is_enabled()
        call deoplete#disable()
        let g:deoplete_is_enable_before_multi_cursors = 1
    else
        let g:deoplete_is_enable_before_multi_cursors = 0
    endif
endfunc

func! Multiple_cursors_after()
    if g:deoplete_is_enable_before_multi_cursors
        call deoplete#enable()
    endif
endfunc

