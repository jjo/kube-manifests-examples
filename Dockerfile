# See https://github.com/ksonnet/kubecfg
FROM bitnami/kubecfg:0.5.0
WORKDIR /work

# Using kube.libsonnet from https://raw.githubusercontent.com/kubeapps
COPY lib /work/lib
# Your manifests written in jsonnet
VOLUME /work/manifests
# Just show'em all ...
CMD kubecfg -J lib show manifests/*.jsonnet
