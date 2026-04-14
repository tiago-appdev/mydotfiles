# -----------------------------
# ⚡ BASE RÁPIDA
# -----------------------------

autoload -Uz compinit
compinit -C

# -----------------------------
# 🚀 PATHS
# -----------------------------
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# -----------------------------
# ⚡ ALIASES
# -----------------------------
alias z="cd ~/work/"
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# -----------------------------
# ⚡ STARSHIP
# -----------------------------
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

# Fastfetch
if [[ -z "$FASTFETCH_SHOWN" ]]; then
  export FASTFETCH_SHOWN=1
  fastfetch
fi

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------
# 🧠 HISTORIAL (CLAVE)
# -----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

# búsqueda con flechas (↑ ↓)
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Created by `pipx` on 2026-04-06 21:07:23
export PATH="$PATH:/home/tiago/.local/bin"
