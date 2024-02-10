#!/bin/bash

operator-sdk olm install
# WARN: manual 'olm' ns edit required
# pod-security.kubernetes.io/enforce: baseline
# https://github.com/argoproj-labs/argocd-operator/issues/945

# argocd

kubectl apply -k .
kubectl apply -k ../argocd/init

cat <<EOF | kubectl apply -f -
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
  namespace: argocd
EOF
