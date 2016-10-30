#!/bin/zsh
cat<<EOF
Host some_site
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile vagrant.d/insecure_private_key
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardX11 yes
EOF
