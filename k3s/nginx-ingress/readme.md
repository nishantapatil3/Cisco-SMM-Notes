## nginx-ingress install
```
kubectl apply -k https://github.com/kubernetes/ingress-nginx//deploy/static/provider/baremetal

kubectl apply -f ingress-loadbalancer.yaml
```

## nginx-ingress uninstall
```
kubectl delete -k https://github.com/kubernetes/ingress-nginx//deploy/static/provider/baremetal
```
