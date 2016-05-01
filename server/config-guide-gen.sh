#!/usr/bin/env sh

CONF_USER=${CONF_USER:-tunnel}
CONF_PASSWD=${CONF_PASSWD:-$(pwgen -s 16 1)}
CONF_NOSHELL=${CONF_NOSHELL:-/usr/sbin/nologin}
CONF_HOST=${CONF_HOST:-host}
CONF_SSH_KEY=${CONF_SSH_KEY:-/path/to/id_rsa.pub}

cat <<-EOF
# Configuration guide

> view source to see all the available configuration options

## Server-side

### Create user
\`\`\`
adduser --disabled-password --gecos "" $CONF_USER
touch /home/$CONF_USER/.hushlogin
  echo $CONF_USER:$CONF_PASSWD | chpasswd
\`\`\`


## Client-side

### Copy admin ssh public key
\`\`\`
ssh-copy-id -i $CONF_SSH_KEY $CONF_USER@$CONF_HOST
\`\`\`


## Server-side

### Disable user
\`\`\`
usermod --shell $CONF_NOSHELL -L $CONF_USER
\`\`\`

___THE END___
EOF