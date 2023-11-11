#!/bin/sh

KINDCONFIG="$HOME/kind/kind_config.yaml"
KUBECONFIG="$HOME/kind/cluster1.yaml"

kind create cluster --config $KINDCONFIG
kind get kubeconfig --name kind-1 > $KUBECONFIG
echo "kind-1 Kubeconfig generated - $KUBECONFIG"

echo "export KUBECONFIG=$KUBECONFIG"
