# Vim mode on escape
bindkey -v

# History
autoload -Uz compinit && compinit -i
HISTSIZE=500
SAVEHIST=500
HISTFILE="$HOME/.zsh_history"

# colors
autoload -U colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' %b'

setopt +o nomatch
    
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[alias]='fg=119'

# Prompt customization
precmd() {
    vcs_info
    PROMPT="%{$fg[cyan]%}%~%{$fg[yellow]%}${vcs_info_msg_0_}%{$fg[green]%}$(vim_open) $%{$reset_color%} "
}

autoload -U promptinit; promptinit

# Movement keys
bindkey '^l' forward-char

bindkey '^w' forward-word
bindkey '^b' backward-delete-word

alias vims="vim -S Session.vim"
alias vimjava="vim src/**/*.(java|proto|groovy) gen/**/*.java examples/**/*.java"
alias vimjs="vim src/**/*.(js|ts|vue|json) *.(js|json|ts) test*/**/*.(js|ts)"
alias ls="exa"
alias la="ls -a"
alias ll="ls -l"

# Git
alias gs="git status"
alias gp="git pull"
alias ga="git add -A"
alias gc="git commit -m"
alias gd="git diff"

alias pings="ping 8.8.8.8"
alias up="cd .."

alias cmt="cargo make test"
alias cm="cargo make"
alias cc="cargo check"

alias gradlew="./gradlew"
alias gradlew-test="(./gradlew test; firefox ./build/reports/tests/test/index.html)"

function vim_open() {
    if [[ $(env | grep "VIMRUNTIME=*" | wc -l) -ge 1 ]]; then
        echo " vim"
    else
        echo ""
    fi
}

export PATH=~/.config/scripts:$PATH

# ------------------------------------ #
# --------------- FZF ---------------- #
# ------------------------------------ #

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------ #
# -------- ZPlugin Installation ------ #
# ------------------------------------ #

source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

ZPLGM[MUTE_WARNINGS]=1

zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light b4b4r07/enhancd

# ------------------------------------ #
# --------------- NIX ---------------- #
# ------------------------------------ #

source $HOME/.nix-profile/etc/profile.d/nix.sh
