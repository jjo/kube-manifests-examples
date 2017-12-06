# show/dry-run manifests/*.jsonnet
#
# doesn't create/modify k8s objects, tho
# kubectl apply --dry-run still requires a live API endpoint

IMAGE = jjo/kube-manifests-examples
help:
	@echo make build
	@echo make show
	@echo make dry-run

show:
	@docker run -v $(CURDIR)/manifests:/work/manifests $(IMAGE)

dry-run:
	$(MAKE) -s show | kubectl apply --dry-run -f -

build:
	docker build -t $(IMAGE) .
