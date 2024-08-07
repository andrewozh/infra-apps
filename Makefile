.PHONY: homelab start stop olm argocd init
all: homelab start stop olm argocd init

homelab:
	kind get clusters | grep homelab || kind create cluster --config kind-homelab.yaml

start stop: homelab
	podman ps -aq --filter "name=homelab" | xargs podman "$@"

olm:
	# https://github.com/argoproj-labs/argocd-operator/issues/945
	operator-sdk olm status || (operator-sdk olm install ; kubectl label namespace olm pod-security.kubernetes.io/enforce=baseline --overwrite)

argocd: olm
	kubectl apply -k ./argocd/olm-catalog-source/
	kubectl apply -k ./argocd/olm-subscription/
	while ! kubectl get crd argocds.argoproj.io 2>/dev/null ; do sleep 1 ; done
	kubectl apply -k ./argocd/

init: argocd
