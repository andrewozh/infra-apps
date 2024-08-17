.PHONY: kctx homelab start stop olm argocd init
all: kctx homelab start stop olm argocd init

kctx:
	kubectl config use-context kind-homelab

homelab: kctx
	kind get clusters | grep homelab || kind create cluster --config kind-homelab.yaml

start stop: homelab
	podman ps -aq --filter "name=homelab" | xargs podman "$@"

olm: kctx
	# https://github.com/argoproj-labs/argocd-operator/issues/945
	operator-sdk olm status || (operator-sdk olm install ; kubectl label namespace olm pod-security.kubernetes.io/enforce=baseline --overwrite)

argocd: kctx olm
	kubectl apply -k _argocd/olm-catalog-source/
	kubectl apply -k _argocd/olm-subscription/
	while ! kubectl get crd argocds.argoproj.io 2>/dev/null ; do sleep 1 ; done
	kubectl apply -k _argocd/

init: argocd
