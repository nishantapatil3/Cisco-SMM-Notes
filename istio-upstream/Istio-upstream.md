# Istio upstream

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/grafana.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/kiali.yaml

export INGRESS_DOMAIN=<externalIP>.nip.io # Get ingress ip from istio-ingressgateway
kubectl apply -f prometheus.yaml
kubectl apply -f jaeger.yaml
kubectl apply -f grafana.yaml
kubectl apply -f kiali.yaml

# Delete
kubectl delete -f prometheus.yaml
kubectl delete -f jaeger.yaml
kubectl delete -f grafana.yaml
kubectl delete -f kiali.yaml

kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/prometheus.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/jaeger.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/grafana.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/kiali.yaml