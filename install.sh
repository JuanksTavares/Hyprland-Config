#!/bin/bash

# install.sh - Script para criar symlinks dos dotfiles

echo "Instalando dotfiles..."

# Diretório base do repositório
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Lista de arquivos e pastas para linkar
declare -A dotfiles=(
    ["hypr"]=".config/hypr"
    ["waybar"]=".config/waybar"
    ["kitty"]=".config/kitty"
    ["rofi"]=".config/rofi"
    ["nvim"]=".config/nvim"
    ["zsh/.zshrc"]=".zshrc"
)

# Função para criar symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Cria backup se já existir
    if [ -e "$target" ]; then
        echo "Fazendo backup de $target"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Cria o diretório de destino se não existir
    mkdir -p "$(dirname "$target")"
    
    # Cria o symlink
    ln -sf "$source" "$target"
    echo "Symlink criado: $target → $source"
}

# Cria os symlinks
for source in "${!dotfiles[@]}"; do
    target="$HOME/${dotfiles[$source]}"
    create_symlink "$DOTFILES_DIR/$source" "$target"
done

echo "Instalação concluída!"