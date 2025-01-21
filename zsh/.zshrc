# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

set -o vi

plugins=(git
    colored-man-pages
    jump
    docker
    pip
    kubectl
    rust
    golang
    fzf
)

setopt CORRECT
setopt RM_STAR_SILENT
unsetopt AUTO_CD

function source_if_exists {
    if [ -f $1 ]; then
        source $1
    fi
}

DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true

platform=$(uname)
export ZPLUG_HOME=$HOME/.zplug
if [[ "$platform" != "Linux" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export ZPLUG_HOME=$(brew --prefix)/opt/zplug
fi

source_if_exists $ZPLUG_HOME/init.zsh
source_if_exists $ZSH/oh-my-zsh.sh

fpath=($ZSH/completions $fpath)

zplug "pschmitt/emoji-fzf.zsh"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-syntax-highlighting",      defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"
export EMOJI_FZF_BINDKEY="^s"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_ROOT=$(pyenv root)
fi

if which direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

source_if_exists "$HOME/.autosuggestions"
source_if_exists "$HOME/.cargo/env"

source_if_exists $HOME/.env
source_if_exists $HOME/.aliases
source_if_exists $HOME/.dice.sh

eval "$(fzf --zsh)"
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export BAT_THEME="Solarized (light)"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
source "$HOME/.rye/env"
