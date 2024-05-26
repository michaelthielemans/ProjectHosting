# Cert manager
## Actions handled by cert-manager

1. Generates a private/public key pair.
2. Creates a CSR with the public key and domain names.
3. Sends the CSR to the Let's Encrypt ACME server.
4. Completes the HTTP-01 challenge by provisioning an HTTP resource through your Ingress.
5. Receives the signed certificate from Let’s Encrypt.
6. Stores the signed certificate and private key in the specified secret (example-cert-tls).



1. installation
2. Issuers configurations
3. Certificate request







# ✅  The following listener is valid.
    - name: example-5
      hostname: bar.example.com # ✅ Required.
      port: 8443
      protocol: HTTPS
      allowedRoutes:
        namespaces:
          from: All
      tls:
        mode: Terminate # ✅ Required. "Terminate" is the only supported mode.
        certificateRefs:
          - name: example-com-tls # ✅ Required.
            kind: Secret  # ✅ Required. "Secret" is the only valid value.
            group: core # ✅ Required. "core" is the only valid value.
