#!/bin/bash

set -ue

DEFAULT_GROUPS='wheel'
DEFAULT_UID='1000'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

echo 'Please create a default LINUX user account.'
echo 'For more information visit: https://aka.ms/wslusers'

while true; do

  # Prompt from the username
  read -p 'Enter new LINUX username: ' username

  # Create the user
  if /bin/useradd --uid "$DEFAULT_UID" -c '' -m "$username" --shell /usr/bin/zsh ; then
    if /bin/usermod "$username" -aG "$DEFAULT_GROUPS"; then
      if /bin/passwd "$username"; then
        break
      else
        /bin/userdel "$username"
      fi
    else
      /bin/userdel "$username"
    fi
  fi
done

# Install oh-my-zsh for new user
sudo -u $username sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
