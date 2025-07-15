wsl --install -d Debian
set "wslcommand=wsl -d Debian --cd ~ -u root"
%wslcommand% apt-get update
%wslcommand% apt-get install git make docker.io -y
%wslcommand% git clone https://github.com/bratne/oh-my-devops
%wslcommand% make -C oh-my-devops/arch
%wslcommand% make -C oh-my-devops/arch wslexport	
:: wsl --unregister Debian
%wslcommand% mv oh-my-devops/arch/arch.tar `wslpath -u "%CD%"`
wsl --install --from-file arch.tar
