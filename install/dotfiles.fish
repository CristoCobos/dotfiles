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

# Selección del modo de ejecución.
set -l MODE ""

for arg in $argv
    switch $arg
        case --check --install
            if test -n "$MODE"
                echo "Error: selecciona solo un modo."
                exit 2
            end
            set MODE $arg
        case '*'
            echo "Opción desconocida: $arg"
            echo "Uso: fish install/dotfiles.fish [--check | --install]"
            exit 2
    end
end

if test -z "$MODE"
    echo "Debes indicar --check o --install."
    exit 2
end

# Resolver las rutas de origen y destino.

function get_config_paths
    set -l config $argv[1]
    set -l dotfiles_dir $argv[2]

    switch $config
        case kitty
            set -g CONFIG_SOURCE "$dotfiles_dir/config/kitty"
            set -g CONFIG_TARGET "$HOME/.config/kitty"
        case fish/config.fish
            set -g CONFIG_SOURCE "$dotfiles_dir/config/fish/config.fish"
            set -g CONFIG_TARGET "$HOME/.config/fish/config.fish"
        case fastfetch/config.jsonc
            set -g CONFIG_SOURCE "$dotfiles_dir/config/fastfetch/config.jsonc"
            set -g CONFIG_TARGET "$HOME/.config/fastfetch/config.jsonc"
        case starship.toml
            set -g CONFIG_SOURCE "$dotfiles_dir/config/starship/starship.toml"
            set -g CONFIG_TARGET "$HOME/.config/starship.toml"
        case gitconfig
            set -g CONFIG_SOURCE "$dotfiles_dir/config/git/config"
            set -g CONFIG_TARGET "$HOME/.gitconfig"
    end
end


echo "Repositorio: $DOTFILES_DIR"
echo "Modo: $MODE"
echo ""

# Comprobar que todos los orígenes existen antes de instalar.
for config in $CONFIGS
    get_config_paths "$config" "$DOTFILES_DIR"

    if not test -e "$CONFIG_SOURCE"
        echo "[FALTA] Origen: $CONFIG_SOURCE"
        exit 1
    end
end

if test "$MODE" = --check
    for config in $CONFIGS
        get_config_paths "$config" "$DOTFILES_DIR"

        if test -L "$CONFIG_TARGET"; and test (realpath "$CONFIG_TARGET" 2>/dev/null) = (realpath "$CONFIG_SOURCE")
            echo "[OK] $config"
        else if test -e "$CONFIG_TARGET"; or test -L "$CONFIG_TARGET"
            echo "[EXISTE] $CONFIG_TARGET"
        else
            echo "[PENDIENTE] $CONFIG_TARGET"
        end
    end

    exit 0
end

# Preparar el directorio de respaldos.
set -l BACKUP_ROOT "$HOME/.local/share/dotfiles-backups"
set -l TIMESTAMP (date +%Y%m%d-%H%M%S)
set -l BACKUP_DIR "$BACKUP_ROOT/$TIMESTAMP-$fish_pid"
set -l BACKUP_CREATED false

# Instalar enlaces simbólicos.
for config in $CONFIGS
    get_config_paths "$config" "$DOTFILES_DIR"

    # No hacer nada si el enlace ya es correcto.
    if test -L "$CONFIG_TARGET"; and test (realpath "$CONFIG_TARGET" 2>/dev/null) = (realpath "$CONFIG_SOURCE")
        echo "[OK] $config: ya está enlazado."
        continue
    end

    # Crear el directorio padre si no existe.
    mkdir -p (dirname "$CONFIG_TARGET"); or exit 1

    # Respaldar cualquier archivo, directorio o enlace anterior.
    if test -e "$CONFIG_TARGET"; or test -L "$CONFIG_TARGET"
        if test "$BACKUP_CREATED" = false
            mkdir -p "$BACKUP_ROOT"; or exit 1
            mkdir "$BACKUP_DIR"; or exit 1
            set BACKUP_CREATED true
        end

        echo "[RESPALDO] $CONFIG_TARGET"
        mv "$CONFIG_TARGET" "$BACKUP_DIR/"; or exit 1
    end

    # Crear el enlace simbólico.
    ln -s "$CONFIG_SOURCE" "$CONFIG_TARGET"; or exit 1

    echo "[INSTALADO] $config"
end

echo ""
echo "Instalación terminada."

if test "$BACKUP_CREATED" = true
    echo "Respaldos guardados en: $BACKUP_DIR"
end
