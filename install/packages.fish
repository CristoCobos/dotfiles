#!/usr/bin/env fish

# Instalador de paquetes para EndeavourOS
# Uso: fish install/packages.fish [--check | --install]

# Localizar el repositorio.
set -l SCRIPT_DIR (dirname (realpath (status filename)))
set -l DOTFILES_DIR (dirname "$SCRIPT_DIR")

set -l PACMAN_FILE "$DOTFILES_DIR/packages/pacman.txt"
set -l AUR_FILE "$DOTFILES_DIR/packages/aur.txt"

# Seleccionar el modo de ejecución.
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
            echo "Error: opción desconocida: $arg"
            echo "Uso: fish install/packages.fish [--check | --install]"
            exit 2
    end
end

if test -z "$MODE"
    echo "Error: debes indicar --check o --install."
    echo "Uso: fish install/packages.fish [--check | --install]"
    exit 2
end

echo "Repositorio: $DOTFILES_DIR"
echo "Modo: $MODE"
echo ""

# Comprobar el sistema operativo.
if not test -f /etc/arch-release
    echo "[ERROR] Se requiere Arch Linux o EndeavourOS."
    exit 1
end

# Comprobar dependencias.
for dependency in pacman yay sudo
    if not command -q $dependency
        echo "[ERROR] No se encontró la dependencia: $dependency"
        exit 1
    end
    echo "[OK] Dependencia: $dependency"
end

echo ""

# Comprobar que las listas existen y no están vacías.
for file in "$PACMAN_FILE" "$AUR_FILE"
    if not test -s "$file"
        echo "[ERROR] Archivo inexistente o vacío: $file"
        exit 1
    end
end

# Leer las listas, ignorando líneas vacías y comentarios.
set -l PACMAN_PACKAGES (string match --regex --invert '^[[:space:]]*(#|$)' < "$PACMAN_FILE" | string trim)
set -l AUR_PACKAGES (string match --regex --invert '^[[:space:]]*(#|$)' < "$AUR_FILE" | string trim)

# Validar nombres de paquetes y detectar duplicados.
function validate_package_list
    set -l label $argv[1]
    set -l packages $argv[2..-1]
    set -l seen

    if test (count $packages) -eq 0
        echo "[ERROR] La lista $label no contiene paquetes."
        return 1
    end

    for package in $packages
        if not string match --quiet --regex '^[[:alnum:]@._+-]+$' -- "$package"
            echo "[ERROR] Nombre de paquete inválido en $label: $package"
            return 1
        end

        if contains -- "$package" $seen
            echo "[ERROR] Paquete duplicado en $label: $package"
            return 1
        end

        set -a seen "$package"
    end

    echo "[OK] Lista $label: "(count $packages)" paquetes."
    return 0
end

if not validate_package_list "Pacman" $PACMAN_PACKAGES
    exit 1
end

if not validate_package_list "AUR" $AUR_PACKAGES
    exit 1
end

echo ""

# El modo check termina aquí: no instala ni modifica nada.
if test "$MODE" = --check
    echo "Comprobación finalizada. No se instalaron paquetes."
    exit 0
end

# Solicitar autenticación antes de comenzar la instalación.
echo "Se solicitarán permisos para instalar los paquetes."

if not sudo -v
    echo "[ERROR] No fue posible obtener permisos de administrador."
    exit 1
end

# Instalar paquetes oficiales.
echo ""
echo "=== Instalación de paquetes oficiales ==="

if not sudo pacman -S --needed $PACMAN_PACKAGES
    echo "[ERROR] Falló la instalación de paquetes oficiales."
    exit 1
end

# Instalar paquetes AUR.
echo ""
echo "=== Instalación de paquetes AUR ==="

if not yay -S --needed $AUR_PACKAGES
    echo "[ERROR] Falló la instalación de paquetes AUR."
    exit 1
end

echo ""
echo "Instalación de paquetes finalizada."
