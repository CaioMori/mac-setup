#!/bin/bash

# Atualizar o sistema
echo "Atualizando o sistema..."
softwareupdate -i -a

# Instalar Homebrew (se ainda não estiver instalado)
if ! command -v brew &> /dev/null
then
    echo "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clonar repositório de dotfiles
echo "Clonando mac-setup..."
git clone https://github.com/CaioMori/mac-setup.git ~

# Criar links simbólicos para os dotfiles
echo "Configurando dotfiles..."
./install.sh

# Instalar pacotes do Brewfile
echo "Instalando pacotes do Homebrew..."
brew bundle --file=~/Brewfile

# Instalar Node.js LTS usando nvm
echo "Instalando Node.js LTS..."
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
nvm install --lts
nvm alias default node

echo "Configuração concluída!"