local bb_common = import "bb-hashed.common.libsonnet";

bb_common {
  config+: { data+: { foo: "bar" } },
}
