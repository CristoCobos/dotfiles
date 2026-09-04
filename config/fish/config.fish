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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/cris/miniforge3/bin/conda
    eval /home/cris/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/cris/miniforge3/etc/fish/conf.d/conda.fish"
        . "/home/cris/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/cris/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<

