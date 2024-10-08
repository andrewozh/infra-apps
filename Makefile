.PHONY: kctx olm argocd init
all: kctx olm argocd init

help: ## Show this message
	@echo "Suggested commands:"
	@echo
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

kctx: ## Activate homelab kubecontext
	kubectl config use-context kind-homelab

olm: kctx ## Deploy Operator Lifecycle Manager
	# https://github.com/argoproj-labs/argocd-operator/issues/945
	operator-sdk olm status || (operator-sdk olm install ; kubectl label namespace olm pod-security.kubernetes.io/enforce=baseline --overwrite)

argocd: kctx olm ## Deploy argocd
	kubectl apply -k _argocd/olm-catalog-source/
	kubectl apply -k _argocd/olm-subscription/
	while ! kubectl get crd argocds.argoproj.io 2>/dev/null ; do sleep 1 ; done
	kubectl apply -k _argocd/

init: argocd ## Init cluster
