#!/bin/bash
chown -R support:support /app/logs

rm -rf /home/support/.ssh
mkdir -p /home/support/.ssh
chmod 700 /home/support/.ssh

# cp -a /opt/ammotools_ssh_files/. /home/support/.ssh/

chown -R support:support /home/support/.ssh
find /home/support/.ssh -type f -exec chmod 600 {} +

exec gosu support "$@"
