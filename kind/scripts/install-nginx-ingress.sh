#!/bin/bash -e
# Syntax kind_create.sh [-n|--name kindName] [-i|--image kindImage] [-c|--kubeconfig kubeConfig] [-d|--confdir confiDir]

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
    kubectl delete --kubeconfig ${KUBECONFIG} -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
    exit 0
fi

# Install
kubectl apply --kubeconfig ${KUBECONFIG} -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --kubeconfig ${KUBECONFIG} \
  --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s
