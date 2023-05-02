#!/bin/sh
echo "Docker Node Preparation ..."
sudo apt-get update 
sudo apt-get upgrade -y 
sudo apt-get install -y python3 git vim bash-completion

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

PASS=$(echo "docker" | openssl passwd -1 -stdin)
useradd -p "$PASS" docker
cat <<EOF > /etc/sudoers.d/docker
docker	ALL=NOPASSWD: ALL
EOF

cat <<EOF >> /etc/hosts
192.168.5.200 docker.clevory.local
EOF

# su - docker -c "ssh-keygen -b 2048 -t rsa -f /home/docker/.ssh/id_rsa -q -P \"\""
# su - docker -c "echo 'docker' | sshpass ssh-copy-id -f -i /home/docker/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ansible@ansible1.example.com"
# su - docker -c "echo 'docker' | sshpass ssh-copy-id -f -i /home/docker/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ansible@ansible2.example.com"

