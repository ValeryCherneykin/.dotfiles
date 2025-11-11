# ============================================================================
# Performance optimizations
# ============================================================================
ZSH_DISABLE_COMPFIX=true
skip_global_compinit=1

# Lazy load compinit (only once per 24h)
autoload -Uz compinit
if [[ -n ~/.zsh/cache/zcompdump(#qN.mh+24) ]]; then
    compinit -d ~/.zsh/cache/zcompdump
else
    compinit -C -d ~/.zsh/cache/zcompdump
fi

# Completion optimizations
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' rehash false
zstyle ':completion::complete:*' gain-privileges 0

# ============================================================================
# Kanagawa color scheme
# ============================================================================
# Based on kanagawa.nvim theme
typeset -A KANAGAWA
KANAGAWA[fujiWhite]='#DCD7BA'
KANAGAWA[oldWhite]='#C8C093'
KANAGAWA[sumiInk0]='#16161D'
KANAGAWA[sumiInk3]='#363646'
KANAGAWA[sumiInk4]='#54546D'
KANAGAWA[waveBlue1]='#223249'
KANAGAWA[waveBlue2]='#2D4F67'
KANAGAWA[winterGreen]='#2B3328'
KANAGAWA[autumnGreen]='#76946A'
KANAGAWA[autumnRed]='#C34043'
KANAGAWA[autumnYellow]='#DCA561'
KANAGAWA[samuraiRed]='#E82424'
KANAGAWA[roninYellow]='#FF9E3B'
KANAGAWA[waveAqua1]='#6A9589'
KANAGAWA[dragonBlue]='#658594'
KANAGAWA[springViolet1]='#938AA9'
KANAGAWA[oniViolet]='#957FB8'
KANAGAWA[crystalBlue]='#7E9CD8'
KANAGAWA[springBlue]='#7FB4CA'
KANAGAWA[lightBlue]='#A3D4D5'

# Custom Kanagawa prompt (minimal, fast)
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{#76946A}✔%f'
zstyle ':vcs_info:*' unstagedstr ' %F{#C34043}✘%f'
zstyle ':vcs_info:git:*' formats ' %F{#938AA9}%b%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' %F{#938AA9}%b%f %F{#E82424}%a%f%c%u'

precmd() { vcs_info }

PROMPT='%F{#7E9CD8}%~%f${vcs_info_msg_0_} %F{#DCA561}❯%f '

# Vi mode indicator (optimized)
function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        vicmd)      echo -ne '\e[1 q' ;;  # block cursor
        viins|main) echo -ne '\e[5 q' ;;  # beam cursor
    esac
}
zle -N zle-line-init
zle -N zle-keymap-select

# ============================================================================
# PATH
# ============================================================================
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# ============================================================================
# History
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# ============================================================================
# Plugins (direct load, no Oh-My-Zsh overhead)
# ============================================================================
# Vi mode
if [[ -f /opt/homebrew/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
    source /opt/homebrew/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# Autosuggestions (with Kanagawa colors)
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#54546D'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Ctrl+Space или End для принятия подсказки
bindkey '^ ' autosuggest-accept
bindkey '^[[F' autosuggest-accept
# Ctrl+Right для принятия одного слова
bindkey '^[[1;5C' forward-word

# History substring search (используем Ctrl+Up/Down вместо обычных стрелок)
if [[ -f /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
# Ctrl+Up/Down для substring search
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down
# Обычные стрелки для нормальной навигации по истории
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Syntax highlighting (load last, with Kanagawa colors)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_STYLES[command]='fg=#7E9CD8'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7FB4CA'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#938AA9'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7E9CD8'
ZSH_HIGHLIGHT_STYLES[path]='fg=#DCD7BA'
ZSH_HIGHLIGHT_STYLES[string]='fg=#98BB6C'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#DCA561'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#DCA561'

# Zoxide (lazy init for faster startup)
eval "$(zoxide init zsh)"

# Bracketed paste fix
unset zle_bracketed_paste
zstyle ':bracketed-paste-magic' active off
unset ZLE_BRACKETED_PASTE

# Disable all bell sounds
setopt NO_BEEP
setopt NO_LIST_BEEP
setopt NO_HIST_BEEP
unsetopt BEEP

# ============================================================================
# Vim hotkeys - Lightning fast access (macOS optimized)
# ============================================================================
# Alt+E - открыть nvim в текущей директории (edit) - аналог ve
function _quick_nvim_dir() {
    BUFFER="nvim ."
    zle accept-line
}
zle -N _quick_nvim_dir
bindkey '^[e' _quick_nvim_dir

# Alt+V - просто nvim (аналог v)
function _quick_nvim_simple() {
    BUFFER="nvim"
    zle accept-line
}
zle -N _quick_nvim_simple
bindkey '^[v' _quick_nvim_simple

# Alt+N - открыть vim config (аналог vconfig)
function _quick_nvim_config() {
    BUFFER="nvim ~/.config/nvim"
    zle accept-line
}
zle -N _quick_nvim_config
bindkey '^[n' _quick_nvim_config

# Alt+W - открыть wezterm config (аналог vw)
function _quick_nvim_wezterm() {
    BUFFER="nvim ~/.wezterm.lua"
    zle accept-line
}
zle -N _quick_nvim_wezterm
bindkey '^[w' _quick_nvim_wezterm

# Alt+T - открыть tmux config
function _quick_nvim_tmux() {
    BUFFER="nvim ~/.tmux.conf"
    zle accept-line
}
zle -N _quick_nvim_tmux
bindkey '^[t' _quick_nvim_tmux

# Alt+Z - открыть zsh config
function _quick_nvim_zsh() {
    BUFFER="nvim ~/.zshrc"
    zle accept-line
}
zle -N _quick_nvim_zsh
bindkey '^[z' _quick_nvim_zsh

# ============================================================================
# Aliases
# ============================================================================
alias ...='cd ../..'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gco='git checkout'
alias reload='exec zsh'
alias v="nvim"
alias vim="nvim"
alias vconfig="nvim ~/.config/nvim"
alias ve="nvim ."
alias vw="nvim ~/.wezterm.lua"

source /Users/valerycherneykin/dev/learning/trash-code/godoc-config.sh
