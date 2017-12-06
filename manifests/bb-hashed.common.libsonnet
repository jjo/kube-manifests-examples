# https://raw.githubusercontent.com/kubeapps/manifest/master/lib/kube.libsonnet
local kube = import "kube.libsonnet";
local hash(value) = (
  std.substr(std.md5(std.toString(value)), 0, 7)
);
{
  deploy: kube.Deployment("bb-hashed-deploy") {
    spec+: {
      template+: {
        spec+: {
          containers_+: {
            busybox: kube.Container("busybox") {
              image: "busybox",
              args: ["sh", "-c", "cat /etc/config/foo; sleep 3600"],
              volumeMounts_+: {
                config: { mountPath: "/etc/config", readOnly: true },
              },
            },
          },
          volumes_+: {
            config: kube.ConfigMapVolume($.config),
          },
        },
      },
    },
  },
  config: kube.ConfigMap("bb-hashed-config-" + hash($.config.data)) {
    data+: {
      foo: null,
    },
  },
}
