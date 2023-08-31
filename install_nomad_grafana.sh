#!/bin/bash

# Install Docker
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker adika

# Run Nomad container
docker run -d --name=nomad \
  --net=host \
  --volume="$PWD:/nomad/config" \
  hashicorp/nomad agent -config=/nomad/config/nomad.hcl

# Run Grafana container
docker run -d --name=grafana \
  --net=host \
  -e "GF_INSTALL_PLUGINS=grafana-simple-json-datasource" \
  grafana/grafana
