ZSH_DISABLE_COMPFIX=true
skip_global_compinit=1

autoload -Uz compinit
typeset -g _compinit_called
if [[ -z $_compinit_called ]]; then
    _compinit_called=1
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
    zstyle ':completion:*' rehash false
    zstyle ':completion::complete:*' gain-privileges 0
    ZSH_COMPDUMP="$HOME/.zsh/cache/zcompdump"
    if [[ -n ~/.zsh/cache/zcompdump(#qN.mh+24) ]]; then
        compinit -d ~/.zsh/cache/zcompdump
    else
        compinit -C -d ~/.zsh/cache/zcompdump
    fi
fi

export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(zsh-vi-mode zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

unset zle_bracketed_paste
zstyle ':bracketed-paste-magic' active off
unset ZLE_BRACKETED_PASTE

HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

alias ...='cd ../..'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gco='git checkout'
alias reload='source ~/.zshrc'
alias v="nvim"
alias vconfig="nvim ~/.config/nvim"
alias ve="nvim ."
alias vw="nvim ~/.wezterm.lua"

export PATH="$HOME/bin:$PATH"
