set nocompatible

if has('nvim')
    let g:editor_root=expand("~/.nvim")
else
    echo "Using Vim"
    let g:editor_root=expand("~/.vim")
endif

if has("unix")
    let s:uname = system("uname")
    let g:python_host_prog='/usr/bin/python'
    let g:python3_host_prog='/usr/bin/python3'
    if s:uname == "Darwin\n"
        let g:python_host_prog='/usr/local/Cellar/python@2/2.7.16/bin/python2'
        " let g:python3_host_prog='/Users/gregoirelejay/.pyenv/shims/python3'
        let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'
    endif
endif

source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/theme.vim
source $HOME/.config/nvim/keys.vim
source $HOME/.config/nvim/tabulation.vim
