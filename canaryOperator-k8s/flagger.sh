#!/bin/sh

# Flagger Demo script
echo "\n" && read -p "Deploy Istio"
istioctl manifest install --set profile=default

# deploy prometheus
echo "\n" && read -p "Deploy Prometheus"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml

# deploy flagger
echo "\n" && read -p "Deploy Flagger and connect to Istio and Prometheus"
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flagger/main/artifacts/flagger/crd.yaml
helm upgrade -i flagger flagger/flagger \
--namespace=istio-system \
--set crd.create=false \
--set meshProvider=istio \
--set metricsServer=http://prometheus:9090

# test demo
echo "\n" && read -p "Deploy target and tester pods"
kubectl create ns test
kubectl label namespace test istio-injection=enabled
kubectl apply -k https://github.com/fluxcd/flagger//kustomize/podinfo?ref=main
kubectl apply -k https://github.com/fluxcd/flagger//kustomize/tester?ref=main

kubectl apply -f flagger/demo_ingress.yaml
kubectl apply -f flagger/podinfo-canary.yaml
exit



###
kubectl -n test set image deployment/podinfo podinfod=stefanprodan/podinfo:3.1.1
kubectl -n test set image deployment/podinfo podinfod=stefanprodan/podinfo:3.1.2

# Generate HTTP 500 errors and latency:
kubectl -n test exec -it deploy/flagger-loadtester sh
watch "curl http://podinfo-canary:9898/delay/1 && curl http://podinfo-canary:9898/status/500"
