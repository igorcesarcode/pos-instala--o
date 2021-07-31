#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_ULAUNCHER="ppa:agornostal/ulauncher"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_DRAGULA_GTK="https://github.com/dracula/gtk/archive/master.zip"
URL_INSOMNIA="https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website"


DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
    git
    zip
    unzip
    ulauncher
    

)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock


## Atualizando o repositório ##
sudo apt update -y

## Adicionando repositório (Drivers Nvidia)##

sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DRAGULA_GTK"         -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb


## Baixa e instala o tema do dracula na pasta .themes e defina o tema  ##
mkdir ~/.themes
git clone https://github.com/dracula/gtk.git ~/.themes/gtk

gsettings set org.cinnamon.theme name Dracula
gsettings set org.cinnamon.desktop.interface gtk-theme Dracula
# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done


# ------------------------------ INSTALAÇÃO DO FIRA CODE --------------------------------- #

mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do wget -O ~/.local/share/fonts/FiraCode-$type.ttf "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-$type.ttf?raw=true"; done
fc-cache -f
# --------------- HABILITA O ULAUNCHER NA INICIALIZAÇÃO E DEFINE O TEMA -------------------- #

systemctl --user enable ulauncher.service

mkdir ~/.config/ulauncher/
mkdir ~/.config/ulauncher/user-themes/
mkdir ~/.config/ulauncher/user-themes/dracula-ulauncher
git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher

# ----------------------------- INSTALAÇÃO DO NVM ----------------------------- #
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install v14.17.0
nvm install v12.22.1
nvm use v14.17.0

# ----------------------------- INSTALAÇÃO DO YARN ----------------------------- #
npm install --global yarn
yarn --version



# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
