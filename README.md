# Dotfiles

Personal Linux configuration files and installation scripts for a reproducible development environment based on **EndeavourOS**.

This repository contains configuration files, package lists, and Fish scripts to help recreate and maintain my desktop environment across installations.

> **Status:** Work in progress. The repository is being developed incrementally.

## System

The current environment is based on:

- **OS:** EndeavourOS (Arch Linux)
- **Desktop Environment:** KDE Plasma
- **Display Server:** Wayland
- **Shell:** Fish
- **Terminal:** Kitty
- **Prompt:** Starship
- **Editor:** Kate
- **Version Control:** Git

## Repository Structure

```text
.dotfiles/
├── config/
│   ├── fastfetch/
│   ├── fish/
│   ├── git/
│   ├── hypr/
│   ├── kitty/
│   ├── rofi/
│   ├── starship/
│   ├── swaync/
│   ├── waybar/
│   └── wlogout/
├── docs/
├── install/
│   ├── dotfiles.fish
│   └── packages.fish
├── packages/
│   ├── aur.txt
│   ├── pacman-explicit.txt
│   └── pacman.txt
├── scripts/
├── wallpapers/
└── README.md
```

### Directories

| Directory | Purpose |
|---|---|
| `config/` | Application and desktop configuration files |
| `docs/` | Project documentation |
| `install/` | Installation scripts |
| `packages/` | Package lists and system package inventory |
| `scripts/` | Utility scripts |
| `wallpapers/` | Desktop wallpapers |

Some configuration directories are reserved for future components and may currently be empty.

## Installation

### 1. Clone the repository

```fish
git clone git@github.com:CristoCobos/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Alternatively, use HTTPS:

```fish
git clone https://github.com/CristoCobos/dotfiles.git ~/.dotfiles
```

### 2. Install packages

Review the package lists before installing.

- `packages/pacman.txt`: packages from official repositories.
- `packages/aur.txt`: packages from the Arch User Repository (AUR).
- `packages/pacman-explicit.txt`: reference inventory of explicitly installed packages.

The package installer requires `yay` for AUR packages.

Run:

```fish
fish install/packages.fish --check
```

This checks whether the package lists exist.

To install the listed packages:

```fish
fish install/packages.fish
```

### 3. Install configurations

First, verify the configuration files:

```fish
./install/dotfiles.fish --check
```

Then install the configurations:

```fish
./install/dotfiles.fish --install
```

The installer creates symbolic links from the repository to their corresponding locations in the home directory.

Existing files are backed up before being replaced. Backups are stored under:

```text
~/.local/share/dotfiles-backups/
```

Configurations already linked to the repository are left unchanged.

## Configuration Management

The repository uses symbolic links to keep configuration files version-controlled in one location.

For example:

```text
~/.config/kitty
    -> ~/.dotfiles/config/kitty
```

To modify a configuration, edit the corresponding file inside `~/.dotfiles/config/`.

Changes are then reflected in the application configuration through the symbolic link.

## Maintenance

After modifying configurations:

```fish
cd ~/.dotfiles
git status
git add .
git commit -m "Describe your changes"
git push
```

To update the local repository:

```fish
git pull
```

## Notes

- The installation scripts are written in Fish.
- The package installer targets Arch Linux-based distributions.
- Review package lists before running the installation script.
- This repository is tailored to my personal environment and may require adjustments on other systems.

## License

No license has been specified yet.
