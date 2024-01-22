#https://github.com/nvm-sh/nvm#long-term-support
chsh -s /bin/bash
curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh -o install.sh
chmod a+x install.sh
/usr/bin/zsh -c ./install.sh
. $HOME/.bashrc
. $NVM_DIR/nvm.sh
nvm install node
npm install yarn -g
chsh -s /usr/bin/zsh