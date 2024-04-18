#!/bin/bash -e
# Syntax install-istio.sh [-n|--namespace namespace]

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
    helm uninstall istio-ingress -n istio-system
    helm uninstall istiod -n istio-system
    helm uninstall istio-base -n istio-system
    kubectl delete namespace istio-system
    exit 0
fi

# Install istio
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update istio
helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace --version=1.15.6
helm install istiod istio/istiod -n istio-system --create-namespace --version=1.15.6 --wait
helm install istio-ingress istio/gateway -n istio-system --create-namespace --version=1.15.6 --wait
