#!/bin/sh

KINDCONFIG="$HOME/kindconfig/kind/kind_config.yaml"
KUBECONFIG="$HOME/Downloads/kind-1.yaml"

kind create cluster --config $KINDCONFIG
kind get kubeconfig --name kind-1 > $KUBECONFIG
echo "kind-1 Kubeconfig generated - $KUBECONFIG"

export KUBECONFIG=$KUBECONFIG
