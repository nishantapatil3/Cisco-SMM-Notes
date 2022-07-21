#!/bin/sh

KINDCONFIG="$HOME/kindconfig/config.yaml"
KUBECONFIG="$HOME/kindconfig/kind-1.kubeconfig"

kind create cluster --config $KINDCONFIG
kind get kubeconfig --name kind-1 > $KUBECONFIG
echo "kind-1 Kubeconfig generated - $KUBECONFIG"

export KUBECONFIG=$KUBECONFIG
