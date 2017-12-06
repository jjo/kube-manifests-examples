# Random jjo's kubernetes manifests

All/most examples use `kube.libsonnet` from
https://github.com/kubeapps/manifest


## Hashed ConfigMap example

As `ConfigMap` changes won't trigger objects using
it (typically a `Deployment`), forcing the `ConfigMap`
**name** to have hashed part (from its contents), will trigger
a "true" change on the objects referring to it.

A simple busybox plus volume mounted /etc/config/ ('foo'
key as a file there):

    manifests/bb-hashed.common.libsonnet
    manifests/bb-hashed.v2.jsonnet
    manifests/bb-hashed.v1.jsonnet


* See configs difference: `diff -u manifests/bb-hashed.v?.jsonnet`
* From `make dry-run` output, you can see how the `ConfigMap` name has
  changed, internally the `bb-hashed-deploy` points to
  `bb-hashed-config-8594ed7`

    $ make dry-run
    make -s show | kubectl apply --dry-run -f -
    configmap "bb-hashed-config-94232c5" created (dry run)
    deployment "bb-hashed-deploy" created (dry run)
    configmap "bb-hashed-config-8594ed7" created (dry run)
    deployment "bb-hashed-deploy" created (dry run)
