# wget -O- https://apt.releases.hashicorp.com/gpg | \
#     gpg --dearmor | \
#     sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
#TODO: Verify GPG-key with 
#gpg --no-default-keyring \
#    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#    --fingerprint
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
#     https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
#     sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update
sudo apt-get -y install terraform-switcher
terraform-switcher -u
