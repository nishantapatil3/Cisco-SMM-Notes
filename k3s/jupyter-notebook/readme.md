## Install
```
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update

helm upgrade --cleanup-on-fail \
    --install jupyter-notebook jupyterhub/jupyterhub \
    --namespace jhub \
    --create-namespace \
    --values values.yaml

kubectl apply -f ingress.yaml
```

## Uninstall
```
helm uninstall --namespace jhub jupyter-notebook
```

### Additional useful info
Sources:
- https://discourse.jupyter.org/t/serving-jupyterhub-on-path-other-than-root-using-nginx-controller/2926
