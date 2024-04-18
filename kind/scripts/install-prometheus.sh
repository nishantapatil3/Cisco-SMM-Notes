#!/bin/bash -e
# Syntax install-prometheus.sh

KUBECONFIG=~/.kind/config

while [[ $# -gt 0 ]]
do
    key="${1}"

    case ${key} in
    -c|--kubeconfig)
        KUBECONFIG="${2}"
        shift;shift
        ;;
    -u|--uninstall)
        UNINSTALL=true
        shift;
        ;;
    *) # unknown
        echo Unknown Parameter $1
        exit 4
    esac
done

# Uninstall
if [[ -n ${UNINSTALL} ]]; then
    helm uninstall prometheus-operator-crds -n prometheus-operator
    exit 0
fi

# Install prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
helm install \
    --create-namespace \
    --namespace prometheus-operator \
    prometheus-operator-crds prometheus-community/prometheus-operator-crds
