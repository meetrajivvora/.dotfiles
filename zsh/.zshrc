# Homebrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Starship handles prompt theming
ZSH_THEME=""

# Oh My Zsh Plugins
# Note: fzf-tab must be loaded before zsh-autosuggestions and zsh-syntax-highlighting
plugins=(
  git
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------
# Completion Styles & fzf-tab Configuration
# ------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:(cd|z):*' fzf-preview 'ls --color=always -1 $realpath'

# fzf keybindings & fuzzy completion
source <(fzf --zsh)

# ------------------------------------------------------------
# Keybindings & Line Editing (Fixes Ctrl+A and Ctrl+E)
# ------------------------------------------------------------
bindkey -e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

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
