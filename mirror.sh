#!/bin/sh

set -Eeuo pipefail

function skopeo_copy () {
    # gcr.json has been extracted as such:
    #
    # $ oc extract secret/gcrcred --to=- --keys=.dockerconfigjson -n backend > gcr.json
    #
    skopeo copy --authfile "gcr.json" --dest-creds "$DESTINATION_CREDENTIALS" docker://$1 docker://$2
}

skopeo_copy "gcr.io/rox-se/sample-image:getting-started"                  "registry.itix.xyz/stackrox-demo/sample-image:getting-started"
skopeo_copy "gcr.io/rox-se/srox/netflow:latest"                           "registry.itix.xyz/stackrox-demo/netflow:latest"
skopeo_copy "gcr.io/rox-se/struts-violations/mastercard-processor:latest" "registry.itix.xyz/stackrox-demo/mastercard-processor:latest"
skopeo_copy "gcr.io/rox-se/struts-violations/visa-processor:latest-v2"    "registry.itix.xyz/stackrox-demo/visa-processor:latest-v2"
skopeo_copy "gcr.io/rox-se/srox/visa-processor:sidecar-latest-v2"         "registry.itix.xyz/stackrox-demo/visa-processor-sidecar:sidecar-latest-v2"
skopeo_copy "gcr.io/rox-se/srox/jump-host:latest"                         "registry.itix.xyz/stackrox-demo/jump-host:latest"
skopeo_copy "gcr.io/rox-se/srox/proxy:latest"                             "registry.itix.xyz/stackrox-demo/proxy:latest"
skopeo_copy "gcr.io/rox-se/srox/reporting:latest"                         "registry.itix.xyz/stackrox-demo/reporting:latest"
skopeo_copy "gcr.io/rox-se/struts-violations/asset-cache:latest"          "registry.itix.xyz/stackrox-demo/struts-asset-cache"
skopeo_copy "gcr.io/rox-se/srox/asset-cache:sidecar-latest"               "registry.itix.xyz/stackrox-demo/srox-asset-cache"
skopeo_copy "gcr.io/rox-se/srox/monitor:latest"                           "registry.itix.xyz/stackrox-demo/monitor:latest"
skopeo_copy "gcr.io/rox-se/struts-violations/backend-atlas:latest"        "registry.itix.xyz/stackrox-demo/backend-atlas"
