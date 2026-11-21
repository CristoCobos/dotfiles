
#!/usr/bin/env fish

# Instalador de dotfiles para EndeavourOS

set -l SCRIPT_DIR (dirname (realpath (status filename)))
set -l DOTFILES_DIR (dirname "$SCRIPT_DIR")

# Configuraciones administradas por este instalador.
set -l CONFIGS \
    kitty \
    fish/config.fish \
    fastfetch/config.jsonc \
    starship.toml \
    gitconfig

# Comprobación de rutas.
if not contains -- --check $argv
    echo "Por ahora este instalador solo admite --check."
    echo "No se ha modificado ningún archivo."
    exit 1
end

echo "Repositorio: $DOTFILES_DIR"
echo ""

for config in $CONFIGS
    switch $config
        case kitty
            set source "$DOTFILES_DIR/config/kitty"
            set target "$HOME/.config/kitty"
        case fish/config.fish
            set source "$DOTFILES_DIR/config/fish/config.fish"
            set target "$HOME/.config/fish/config.fish"
        case fastfetch/config.jsonc
            set source "$DOTFILES_DIR/config/fastfetch/config.jsonc"
            set target "$HOME/.config/fastfetch/config.jsonc"
        case starship.toml
            set source "$DOTFILES_DIR/config/starship/starship.toml"
            set target "$HOME/.config/starship.toml"
        case gitconfig
            set source "$DOTFILES_DIR/config/git/config"
            set target "$HOME/.gitconfig"
    end

    if not test -e "$source"
        echo "[FALTA] Origen: $source"
    else if test -L "$target"; and test (readlink -f "$target") = (realpath "$source")
        echo "[OK] $config"
    else if test -e "$target"
        echo "[EXISTE] $target"
    else
        echo "[PENDIENTE] $target"
    end
end

