#!/bin/sh

# deploy istio demo profile

echo "\n" && read -p "Deploy Istio"
istioctl manifest install --set profile=default
kubectl label namespace default istio-injection=enabled

# deploy prometheus
echo "\n" && read -p "Deploy Prometheus"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
# kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml

# deploy
echo "\n" && read -p "Deploy Argo Rollout"
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

echo "\n" && read -p "Deploy Rollout and loadtester"
k apply -f argo_demo
k apply -f hey.yaml

###
# kubectl argo rollouts set image rollouts-demo rollouts-demo=argoproj/rollouts-demo:orange
# kubectl argo rollouts get rollout rollouts-demo --watch
# kubectl argo rollouts promote rollouts-demo
