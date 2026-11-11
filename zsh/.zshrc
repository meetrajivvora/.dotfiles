# Homebrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Starship handles prompt theming
ZSH_THEME=""

# Oh My Zsh Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------
# Completion Styles
# ------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# fzf keybindings & fuzzy completion
source <(fzf --zsh)
# Restore Tab to zsh's built-in completion menu (OMZ's compinit).
# `source <(fzf --zsh)` binds ^I to fzf-completion; this overrides it.
bindkey '^I' expand-or-complete

# ------------------------------------------------------------
# CLI Integrations
# ------------------------------------------------------------
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Environment variables & paths
export PATH="$HOME/.local/bin:$PATH"
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export PATH="/var/home/meetrajivvora/.bun/bin:$PATH"

# ------------------------------------------------------------
# Shortcuts & Aliases
# ------------------------------------------------------------
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

# ------------------------------------------------------------
# Keybindings & Line Editing (Fixes Ctrl+A and Ctrl+E)
# ------------------------------------------------------------
# Force Emacs keymap
bindkey -e

# Explicitly ensure Ctrl+A and Ctrl+E are bound
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line


# Added by Antigravity CLI installer
export PATH="/home/meetrajivvora/.local/bin:$PATH"
