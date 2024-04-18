#!/bin/bash -e
# Syntax kind_create.sh [-n|--name kindName] [-i|--image kindImage] [-c|--kubeconfig kubeConfig] [-d|--confdir confiDir]

KIND_CLUSTER_NAME=kind-1
KIND_IMAGE=kindest/node:v1.27.3
KIND_HOSTPORT=10080
KCONFDIR_ROOT=~/.kind/kubeconfigs
KUBECONFIG=~/${KCONFDIR_ROOT}/config


while [[ $# -gt 0 ]]
do
    key="${1}"

    case ${key} in
    -n|--name)
        KIND_CLUSTER_NAME="${2}"
        shift;shift
        ;;
    -i|--image)
        KIND_IMAGE="${2}"
        shift;shift
        ;;
    -p|--hostport)
        KIND_HOSTPORT="${2}"
        shift;shift
        ;;
    -c|--kubeconfig)
        KUBECONFIG="${2}"
        shift;shift
        ;;
    -d|--confdir)
        KCONFDIR_ROOT="${2}"
        shift;shift
        ;;
    -h|--help)
        echo "Usage: `basename $0` [-n|--name kindName] [-i|--image kindImage] [-c|--kubeconfig kubeConfig] [-d|--confdir confiDir]"
        exit 0
        ;;
    *) # unknown
        echo Unknown Parameter $1
        exit 4
    esac
done

# Create kind config for cluster creation
KIND_CONFIG="
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "127.0.0.1"
  apiServerPort: 8443
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: ${KIND_HOSTPORT}
    protocol: TCP
"

if [ ! -d "${KCONFDIR_ROOT}" ]; then
    mkdir -p "${KCONFDIR_ROOT}"
fi
echo "${KIND_CONFIG}" > ${KCONFDIR_ROOT}/kindConfig.yaml

# Create kind cluster
set -e
kind --version
kind create cluster --name ${KIND_CLUSTER_NAME} --image ${KIND_IMAGE} --config ${KCONFDIR_ROOT}/kindConfig.yaml --wait 2m
kind get kubeconfig --name=${KIND_CLUSTER_NAME} > "${KUBECONFIG}"
export KUBECONFIG="${KUBECONFIG}"
