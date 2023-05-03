#!/bin/sh

# Setting and configuring the VM
sudo apt-get update 
sudo apt-get upgrade -y 
sudo apt-get install -y python3 git vim bash-completion sshpass openssh-server curl

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

PASS=$(echo "docker" | openssl passwd -1 -stdin)
sudo useradd -p  "$PASS" -s /bin/bash -d /home/docker -m  docker 
echo "docker  ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/docker"

cat <<EOF > /etc/hosts
192.168.1.200 docker.clevory.local
EOF

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install docker-compose

curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

