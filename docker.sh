#!/bin/sh

# Setting and configuring the VM
apt-get update 
apt-get upgrade -y 
apt-get install -y python3 git vim bash-completion sshpass openssh-server curl

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

PASS=$(echo "docker" | openssl passwd -1 -stdin)
useradd -p  "$PASS" -s /bin/bash -d /home/student -m  student
echo "student  ALL=(ALL:ALL) NOPASSWD: ALL"  >> /etc/sudoers.d/student

cat <<EOF > /etc/hosts
192.168.1.200 docker.clevory.local
EOF

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker student

# Install docker-compose
curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

