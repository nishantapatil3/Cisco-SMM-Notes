#!/bin/bash -e
# Syntax install-metallb.sh

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
    kubectl delete -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml
    kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/main/config/manifests/metallb-native.yaml
    exit 0
fi

# Install
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/main/config/manifests/metallb-native.yaml
for i in {1..5}; do
    kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml && break

    if [[ $? -eq 0 ]]; then
        echo "Command successful!"
        break  # Exit the loop on success
    fi

    echo "Error during apply attempt $i, retrying..."
    sleep 10  # Add a delay between retries (optional)
done
