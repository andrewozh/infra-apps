#!/bin/bash

operator-sdk olm install

# argocd

kubectl create -n olm -f https://raw.githubusercontent.com/argoproj-labs/argocd-operator/master/deploy/catalog_source.yaml
kubectl create ns argocd
kubectl create -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-operator/master/deploy/operator_group.yaml
kubectl create -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-operator/master/deploy/subscription.yaml
cat <<EOF | kubectl apply -f -
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
    namespace: argocd
    spec: {}
EOF
cat <<EOF | kubectl apply -f -
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argocd-infra
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/andrewozh/infra-apps.git'
    targetRevision: main
    path: 1_cluster-init/argocd
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
EOF
