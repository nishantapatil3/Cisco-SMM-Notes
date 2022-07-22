## Steps to expose Cisco SMM dashboard

1.  ```
    kubectl edit controlplanes.smm.cisco.com smm

    Below two lines already exists
    spec:
      smm:

    Just add these
      exposeDashboard:
        meshGateway:
          enabled: true
    ```

    Which should look like this
    ```
    spec:
      smm:
        exposeDashboard:
          meshGateway:
            enabled: true
    ```

1. reconcile
    ```
    ./smm operator reconcile
    ```

1. check 
    ```
    ❯ k get istiomeshgateways.servicemesh.cisco.com --all-namespaces
    NAMESPACE      NAME                           TYPE      SERVICE TYPE   STATUS      INGRESS IPS         ERROR   AGE   CONTROL PLANE
    smm-system     smm-ingressgateway-external    ingress   LoadBalancer   Available   ["34.127.124.68"]           78s   {"name":"cp-v112x","namespace":"istio-system"}
    ```

1. edit cp again and add tls section as below
   copy smm-ingressgateway-external IP address and use domain `34.127.124.68.nip.io`
    ```
    kubectl edit controlplanes.smm.cisco.com smm

    exposeDashboard:
      meshGateway:
        enabled: true
        tls:
          enabled: true
          letsEncrypt:
            dnsNames:
              - 34.127.124.68.nip.io
            enabled: true
    ```

1. Reconcile
    ```
    ./smm operator reconcile
    ```
    At this point letsencrypt starts working its magic and fetches a certificate

    If it doesnt work

    delete below CRD resource
    ```
    ❯ kubectl get orders.acme.cert-manager.io --all-namespaces
    NAMESPACE    NAME                                           STATE     AGE
    smm-system   smm-ingressgateway-external-qv72c-3501498707   errored   104s

    ❯ kubectl get certificates.cert-manager.io --all-namespaces
    NAMESPACE    NAME                          READY   SECRET                   AGE
    smm-system   smm-ingressgateway-external   False   smm-ingressgateway-tls   3m17s
    ```

    change domain to any alternative from `nip.io` to `sslip.io`
    ```
    dnsNames:
      - 34.127.124.68.sslip.io
    ```

    reconcile
    ```
    ./smm operator reconcile
    ```

    Then you should have it running

    use https://34.127.124.68.sslip.io/