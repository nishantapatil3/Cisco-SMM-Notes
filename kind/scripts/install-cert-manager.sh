#!/bin/bash -e
# Syntax install-cert-manager.sh

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
    helm uninstall cert-manager -n cert-manager
    kubectl delete namespace cert-manager
    exit 0
fi

# Install cert-manager
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update jetstack
helm install cert-manager jetstack/cert-manager \
    --namespace cert-manager --create-namespace \
    --set installCRDs=true \
    --version v1.12.4
