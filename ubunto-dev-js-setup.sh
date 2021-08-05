echo "Bem-vindo! Vamos começar a configurar seu sistema pode demorar um pouco."

git_config_user_name="Igor César Rocha"
git_config_user_email="igorcesarbernades@gmail.com"
username="igorcesarcode"

cd ~ && sudo apt-get update
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

echo 'Instalando curl' 
sudo apt-get install curl -y

echo 'Instalando a ultima versão do git' 
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update && sudo apt-get install git -y


echo 'Instalando ulauncher'
sudo add-apt-repository ppa:agornostal/ulauncher
sudo apt-get update && sudo apt-get install ulauncher -y

echo 'Instalando python3-pip'
sudo apt-get install python3-pip -y

echo 'Instalando zip'
sudo apt-get update && sudo apt-get install zip -y

echo 'Instalando unzip'
sudo apt-get update && sudo apt-get install unzip -y

echo 'Instalando ZSH'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)

echo 'Clonando seu .zshrc da essência'
getmy .zshrc

echo 'Indexando snap para ZSH'
sudo chmod 777 /etc/zsh/zprofile
echo "emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'" >> /etc/zsh/zprofile

echo 'Installing Spaceship ZSH Theme'
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
source ~/.zshrc

## Altera o Tema padrão para o spaceship ##
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="spaceship"/' ~/.zshrc

##Configua o ZPLUGIN no ##
echo '
# ZPLUGIN

zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions
zplugin light buonomo/yarn-completion# ZPLUGIN

zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions
zplugin light buonomo/yarn-completion

# SPACESHIP THEME
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "' >> ~/.zshrc

# ------------------------------ INSTALAÇÃO DO FIRA CODE --------------------------------- #
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do wget -O ~/.local/share/fonts/FiraCode-$type.ttf "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-$type.ttf?raw=true"; done
fc-cache -f

# ------------------------------ INSTALAÇÃO DO NVM --------------------------------- #
echo 'Instalando NVM' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
clear

echo 'Instalando NodeJS LTS'
nvm --version
nvm install --lts
nvm current

echo 'Instalando Yarn'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn
echo '"--emoji" true' >> ~/.yarnrc

echo 'Instalando Typescript'
yarn global add typescript
clear

echo 'Instalando VSCode'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update && sudo apt-get install code -y

echo 'Instalando as extensões base no vscode'
code --install-extension dracula-theme.theme-dracula
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension naumovs.color-highlight
code --install-extension donjayamanne.githistory
code --install-extension wix.vscode-import-cost
code --install-extension PKief.material-icon-theme
code --install-extension jpoissonnier.vscode-styled-components


echo 'Instalando PostBird'
wget -c https://github.com/Paxa/postbird/releases/download/0.8.4/Postbird_0.8.4_amd64.deb
sudo dpkg -i Postbird_0.8.4_amd64.deb
sudo apt-get install -f -y && rm Postbird_0.8.4_amd64.deb

echo 'Instalando Insomnia Core e Tema Dracula' 
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
  | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
  | sudo apt-key add -
sudo apt-get update && sudo apt-get install insomnia -y
mkdir ~/.config/Insomnia/plugins && cd ~/.config/Insomnia/plugins
git clone https://github.com/dracula/insomnia.git dracula && cd ~

echo 'Instalando Android Studio'
sudo add-apt-repository ppa:maarten-fonville/android-studio -y
sudo apt-get update && sudo apt-get install android-studio -y

echo 'Instalando VLC'
sudo apt-get install vlc -y
sudo apt-get install vlc-plugin-access-extra libbluray-bdj libdvdcss2 -y

echo 'Instalando Discord'
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt-get install -f -y && rm discord.deb


echo 'Instalando Spotify' 
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y


echo 'Ativando KVM do Android Studio'
sudo apt-get install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager -y
sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu

## BAIXA E INSTALA O TEMA DO DRACULA NA PASTA .themes ##
echo 'Baixando e intalando o dracula tema'
mkdir ~/.themes
git clone https://github.com/dracula/gtk.git ~/.themes/gtk
gsettings set org.cinnamon.theme name gtk
gsettings set org.cinnamon.desktop.interface gtk-theme gtk

## HABILITA O ULAUNCHER NA INICIALIZAÇÃO E DEFINE O TEMA ##
echo 'Definindo Ulauncher na Inicialização'
systemctl --user enable ulauncher.service
mkdir ~/.config/ulauncher/
mkdir ~/.config/ulauncher/user-themes/
mkdir ~/.config/ulauncher/user-themes/dracula-ulauncher
git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher




echo '⚡️ Tudo configurado, aproveite!⚡️'
