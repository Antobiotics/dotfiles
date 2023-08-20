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
    rust
    golang
    fzf
    zsh-syntax-highlighting
    zsh-completions
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

export ZPLUG_HOME=$(brew --prefix)/opt/zplug

source_if_exists $ZSH/oh-my-zsh.sh
source_if_exists $HOME/.bashrc
source_if_exists $ZPLUG_HOME/init.zsh
source_if_exists $HOME/.env
source_if_exists $HOME/.aliases
source_if_exists $HOME/.kube_comp.sh
source_if_exists $HOME/.init_dice.sh

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=($ZSH/completions $fpath)

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi


zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq

zplug "pschmitt/emoji-fzf.zsh"
EMOJI_FZF_BINDKEY="^s"

zplug romkatv/powerlevel10k, as:theme, depth:1

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

if which pyenv > /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_ROOT=$(pyenv root)
fi

if which direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

source_if_exists $HOME/.dbt-completion.bash
source_if_exists $HOME/.fzf.zsh
source_if_exists $HOME/.autosuggestions

PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='~~'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/Users/gregoirelejay/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/gregoirelejay/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/gregoirelejay/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/gregoirelejay/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/gregoirelejay/perl5"; export PERL_MM_OPT;
export GPG_TTY=$(tty)
if [ -e /Users/gregoirelejay/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/gregoirelejay/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/.poetry/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export TERM=xterm-256color

# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"
