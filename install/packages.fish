#!/usr/bin/env fish


# Instalador de paquetes para EndeavourOS
# Ejecutar desde cualquier directorio.

set -l SCRIPT_DIR (dirname (realpath (status --current-filename)))
set -l DOTFILES_DIR (dirname "$SCRIPT_DIR")

if contains -- --check $argv
    echo "Repositorio: $DOTFILES_DIR"
    test -f "$DOTFILES_DIR/packages/pacman.txt"; or exit 1
    test -f "$DOTFILES_DIR/packages/aur.txt"; or exit 1
    echo "Lista Pacman: encontrada"
    echo "Lista AUR: encontrada"
    exit 0
end

echo "Repositorio: $DOTFILES_DIR"
echo "Lista Pacman: "(test -f "$DOTFILES_DIR/packages/pacman.txt"; and echo "Encontrada"; or echo "No encontrada")
echo "Lista AUR: "(test -f "$DOTFILES_DIR/packages/aur.txt"; and echo "Encontrada"; or echo "No encontrada")


# Verificar que estamos en Arch Linux o EndeavourOS.
if not test -f /etc/arch-release
    echo "Error: este instalador requiere Arch Linux o EndeavourOS."
    exit 1
end

# Verificar que existen las listas.
if not test -f "$DOTFILES_DIR/packages/pacman.txt"
    echo "Error: no se encontró packages/pacman.txt"
    exit 1
end

if not test -f "$DOTFILES_DIR/packages/aur.txt"
    echo "Error: no se encontró packages/aur.txt"
    exit 1
end

echo "=== Instalación de paquetes oficiales ==="

sudo pacman -S --needed - < "$DOTFILES_DIR/packages/pacman.txt"

if test $status -ne 0
    echo "Error al instalar paquetes oficiales."
    exit 1
end

echo "=== Instalación de paquetes AUR ==="

if not command -q yay
    echo "Error: yay no está instalado."
    exit 1
end

yay -S --needed - < "$DOTFILES_DIR/packages/aur.txt"

if test $status -ne 0
    echo "Error al instalar paquetes AUR."
    exit 1
end

echo "Instalación de paquetes finalizada."
