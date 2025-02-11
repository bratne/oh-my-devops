#!/bin/bash

set -ue

DEFAULT_GROUPS='sudo'
DEFAULT_UID='1000'

echo 'Please create a default LINUX user account.'
#echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new LINUX username: ' username

  # Create the user
  if /bin/useradd --uid "$DEFAULT_UID" --gecos ''  "$username"; then

    if /bin/usermod "$username" -aG "$DEFAULT_GROUPS"; then
      break
    else
      /usr/sbin/deluser "$username"
    fi
  fi
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # Install oh-my-zsh for user
done

