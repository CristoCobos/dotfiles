# ─────────────────────────────────────────────
# Fish configuration
# ─────────────────────────────────────────────

# Only run in interactive shells
if status is-interactive

    # ─────────────────────────────────────────
    # Aliases
    # ─────────────────────────────────────────

    alias ls="eza --icons"
    alias ll="eza -lah --icons"
    alias la="eza -a --icons"

    alias cat="bat"
    alias grep="rg"

    # ─────────────────────────────────────────
    # Git
    # ─────────────────────────────────────────

    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"
    alias gl="git log --oneline --graph --decorate"

end

# ─────────────────────────────────────────────
# Starship
# ─────────────────────────────────────────────



starship init fish | source
