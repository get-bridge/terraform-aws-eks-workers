MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOUNDARY"

--BOUNDARY
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: "${cluster_name}"
    apiServerEndpoint: "${cluster_endpoint}"
    certificateAuthority: "${certificate_authority_data}"
    cidr: "${cluster_cidr}"
  kubelet:
    flags: 
      ${indent(6, kubelet_extra_args_yaml)}
%{ if length(after_cluster_joining_userdata) > 0 ~}
--BOUNDARY
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash

${after_cluster_joining_userdata}
%{ endif ~}
--BOUNDARY--