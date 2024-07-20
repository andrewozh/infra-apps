.PHONY: homelab olm argocd init
all: homelab olm argocd init

homelab:
	kind create cluster --config kind-homelab.yaml 

olm:
	# https://github.com/argoproj-labs/argocd-operator/issues/945
	operator-sdk olm status || (operator-sdk olm install ; kubectl label namespace olm pod-security.kubernetes.io/enforce=baseline --overwrite)

argocd: olm
	kubectl apply -k ./argocd/olm-catalog-source/
	kubectl apply -k ./argocd/olm-subscription/
	while ! kubectl get crd argocds.argoproj.io 2>/dev/null ; do sleep 1 ; done
	kubectl apply -k ./argocd/

init: argocd
