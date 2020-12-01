# Default values for jenkins-charts.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
replicaCount: ${jenkins_replica_count}
image:
  repository: ${ocir_jenkins_repo}
  tag: stable
  pullPolicy: IfNotPresent
  pullSecret: ${jenkins_pull_secret}
ports:
  containerPort: ${jenkins_container_port}
service:
  type: ClusterIP
  port: ${jenkins_service_port}
  nodeport: ${jenkins_service_nodeport}
  targetPort: ${jenkins_service_targetport}
  jnlpnodeport: ${jenkins_service_jnlpnodeport}
  jnlpport: ${jenkins_service_jnlpport}
  jnlptargetport: ${jenkins_service_jnlptargetport}
  proxy: ${jenkins_proxy}
  servicename: ${jenkins_servicename}
  name: ${jenkins_name}
  namespace: ${jenkins_namespace}
  kubeUrl: ${kube_url}
  jenkinsHome: ${jenkins_home}
volumeMounts:
  mountPath: ${oke_mount_path}
  hostVolumeMountPath: ${jenkins_host_volume_mount_path}
secrets:
  mountPath: ${jenkins_cert_secret_mount_path}
volumes:
  claimName: ${jenkins_name}-pvc
  secretName: ${jenkins_cert_secret}
persistence:
  enabled: true
  ip: ${nfs_mount_ip}
  path: ${nfs_mount_path}
  accessMode: "ReadWriteMany"
  size: "100Gi"
storageClassName: ${fss_chart_name}
env:
  jenkinsOpts: _jenkins_opts_
  dockerImage: _docker_image_
