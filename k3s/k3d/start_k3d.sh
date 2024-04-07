#!/bin/sh

export KUBECONFIG=~/Downloads/k3d-1.yaml
k3d cluster create --config ~/kindconfig/k3d/k3d_config.yaml
k3d kubeconfig get k3d-1 > ~/Downloads/k3d-1.yaml

echo "\n\nexport KUBECONFIG=~/Downloads/k3d-1.yaml"
