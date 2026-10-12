eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ============================================================
# Zsh configuration
# ============================================================

# Zinit
source /home/linuxbrew/.linuxbrew/opt/zinit/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ------------------------------------------------------------
# Oh My Zsh components & Zsh plugins (load before compinit)
# ------------------------------------------------------------

# Git aliases and helpers from Oh My Zsh
zinit snippet OMZP::git
zinit snippet OMZL::directories.zsh

# Replace Zsh's completion menu with an fzf-powered interface. # Must load after compinit and before widgets such as # zsh-autosuggestions. zinit light Aloxaf/fzf-tab
zinit light Aloxaf/fzf-tab

# Suggest commands as we type
zinit light zsh-users/zsh-autosuggestions

# ------------------------------------------------------------
# Completion Styles Configuration
# ------------------------------------------------------------

# Case insensitive folder/file autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize the completion menu to match your terminal colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Enable Group Headers inside fzf-tab
# NOTE: fzf-tab requires a simplified format without color escape codes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# Bind keys to switch between groups (e.g., hit ',' or '.' to jump groups)
zstyle ':fzf-tab:*' switch-group ',' '.'

# Preview directory contents natively when hitting tab after 'cd' or 'z'
zstyle ':fzf-tab:complete:(cd|z):*' fzf-preview 'ls --color=always -1 $realpath'

# ------------------------------------------------------------
# Zsh completion
# ------------------------------------------------------------

# Initialize Zsh's native completion system.
autoload -Uz compinit
compinit

# Tell Zinit to replay all plugin/snippet completions captured above
zinit cdreplay -q

# ------------------------------------------------------------
# fzf
# ------------------------------------------------------------

# Set up fzf's Zsh keybindings and fuzzy completion.
source <(fzf --zsh)

# ------------------------------------------------------------
# Final Shell Enhancements (Must load after completions)
# ------------------------------------------------------------

# Highlight shell syntax as we type (Crucial to keep this at the bottom of plugins!)
zinit light zsh-users/zsh-syntax-highlighting

# ============================================================
# CLI integrations
# ============================================================

eval "$(zoxide init zsh)"

# Atuin
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export PATH="/var/home/meetrajivvora/.bun/bin:$PATH"

# =============================================================
# Shortcuts
# =============================================================

alias g="git"
alias gsta=""
alias gstat="git status"
alias gad="git add"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gcd="git checkout"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gdiff="git diff"
