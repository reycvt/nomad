#!/bin/bash

echo "Update package lists and install required dependencies"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y

echo "Add Docker's GPG key to the system"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "Add Docker repository to apt sources"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Update package lists again after adding Docker repository"
sudo apt update -y

echo "Check the available Docker packages"
apt-cache policy docker-ce

echo "Install Docker packages"
sudo apt install docker-ce docker-ce-cli containerd.io -y

echo "Install Docker Compose"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Start Docker service and check its status"
sudo systemctl start docker
#sudo systemctl status docker

echo "Add the current user to the 'docker' group"
sudo usermod -aG docker ${USER}

#echo "Switch to the user's context to apply the group membership changes"
#su - ${USER}
#exit

echo "Verify the user's groups (including 'docker' group)"
id -nG

echo "Add the current user to the 'docker' group again to ensure changes take effect immediately"
sudo usermod -aG docker ${USER}

echo "Check Docker version"
docker --version

echo "Check Docker Compose version"
docker-compose version

# Install Docker
# sudo apt update
# sudo apt install -y docker.io
# sudo usermod -aG docker ${USER}

# Run Nomad container
# docker pull hashicorp/nomad
# docker run -d --name=nomad \
#   --net=host \
#   --volume="$PWD:/nomad/config" \
#   hashicorp/nomad agent -config=/nomad/config/nomad.hcl

# # Run Grafana container
# docker run -d --name=grafana \
#   --net=host \
#   -e "GF_INSTALL_PLUGINS=grafana-simple-json-datasource" \
#   grafana/grafana
