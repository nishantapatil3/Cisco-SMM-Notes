## SMM dashboard without authentication

```
cat <<EOF > smm_expose_noauth_dashboard.yaml
spec:
  smm:
    exposeDashboard:
      meshGateway:
        enabled: true
    auth:
      forceUnsecureCookies: true
      mode: anonymous
EOF
kubectl patch controlplane --type=merge --patch "$(cat smm_expose_noauth_dashboard.yaml)" smm 
smm operator reconcile  
```
