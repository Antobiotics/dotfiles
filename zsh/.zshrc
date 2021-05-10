# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git
    colored-man-pages
    jump
    docker
    pip
    kubectl
    cargo
    fzf
    zsh-syntax-highlighting
    zsh-completions
)

setopt CORRECT
setopt RM_STAR_SILENT

function source_if_exists {
    if [ -f $1 ]; then
        source $1
    fi
}

DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true

source_if_exists $ZSH/oh-my-zsh.sh
source_if_exists $HOME/.bashrc
source_if_exists $HOME/.init_dice.sh
source_if_exists $HOME/.env
source_if_exists $HOME/.aliases
source_if_exists $HOME/.kube_comp.sh

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=($ZSH/completions $fpath)
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

export ZPLUG_HOME=/usr/local/opt/zplug
source_if_exists $ZPLUG_HOME/init.zsh

zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"

zplug romkatv/powerlevel10k, as:theme, depth:1

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    export PYENV_ROOT=$(pyenv root)
fi


source_if_exists $HOME/.dbt-completion.bash
source_if_exists $HOME/.fzf.zsh
source_if_exists $HOME/.autosuggestions

PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/Users/gregoirelejay/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/gregoirelejay/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/gregoirelejay/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/gregoirelejay/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/gregoirelejay/perl5"; export PERL_MM_OPT;
